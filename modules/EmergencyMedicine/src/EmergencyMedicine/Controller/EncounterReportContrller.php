<?php

namespace EmergencyMedicine\Controller;

use FhirAPI\FhirRestApiBuilder\Parts\ErrorCodes;
use Interop\Container\ContainerInterface;
use ClinikalAPI\Controller\PdfBaseController;
use ReportTool\Controller\ReportInterface;
use ReportTool\Model\CustomDB;
use GenericTools\Controller\GenericToolsController;
use GenericTools\Model\RegistryTable;

use ReportTool\Controller\BaseController as ReportBase;

class EncounterReportContrller extends ReportBase implements ReportInterface
{
    const PROCEDURE_NAME = 'EncounterReport';
    const REPORT_ID = "encounter-report";
    const REPORT_TITLE = "Encounter report";
    const REPORT_ROUTE = "EncounterReport";
    const TABLE_COLUMNS_NAME = array(
        'Date',
        'Patient name',
        'Id',
        'Insurance body',
        'Branch',
        'Service type',
        'Decision',
        'Release way',
        );
    const REPORT_NAME = 'encounter_report_';
    const TAB_TITLE = 'EncounterReport';
    const FILE_NAME = 'encounter-report';

    /*************************future FHIR search trait ***********************************/

    const ORGANIZATION = "Organization";
    const BRANCH_SEARCH = array (
        'REWRITE_COMMAND' => 'fhir/v4/Organization',
        'ARGUMENTS' => array ( 'type' => array (
         0 => array (
                    'value' => '11',
                    'operator' => NULL,
                    'modifier' => 'exact',
         ),
    ),),
     'PARAMETERS_FOR_SEARCH_RESULT' => array (),
     'PARAMETERS_FOR_ALL_RESOURCES' => array (),
     'POST_PARSED_JSON' => array (),
    );

    public function fhirSearch($container,$FHIRElement,$bodyParams)
    {
        $strategy = "FhirAPI\FhirRestApiBuilder\Parts\Strategy\StrategyElement\\$FHIRElement\\$FHIRElement";
        $params = ['paramsFromBody' => $bodyParams,'paramsFromUrl'=>array(),'container' => $container];
        $obj = new $strategy($params);
        $search = $obj->search();
        return $search;
    }
    /***********************************************************************/

    public $container = null;

    public function __construct(ContainerInterface $container)
    {
        parent::__construct($container, self::PROCEDURE_NAME);
        $this->container = $container;
    }

    public function indexAction()
    {

        $branchList=array();
        $serviceTypeList=array();
        $hmoList=array();


        //$l=$this->fhirSearch($this->container,self::ORGANIZATION,self::BRANCH_SEARCH);

        $facilities=array("all"=>"All","all2"=>"All2");

        $this->addSelectFilter('branch_name', 'Branch name', $branchList, "all", 230, false);

        $this->addSelectFilter('service_type', 'Service Type', $serviceTypeList, "all", 230, false);

        $this->addSelectFilter('hmo', 'HMO', $hmoList, "all", 230, false);

        //from date
        $this->addInputFilter('from_date', 'From date', 120, oeFormatShortDate(date('Y-m-01')),true);
        //to date
        $this->addInputFilter('until_date', 'Until date', 120, oeFormatShortDate(),true);

        /*
        $doctorList = $this->AddSpecialFilters($doctorList, true, false, false);
        $eventStatusList=$this->getListsTable()->getListForViewForm(self::STATUS_LIST,false,array(),true,true);
        $eventStatusList = $this->AddSpecialFilters($eventStatusList, true, false, false);
        $patientNames= $this->AddSpecialFilters($eventStatusList, true, false, false);

        $this->addSelectFilter('attending_physician', 'Attending Physician', $doctorList, '-1', 240, false, false,'form-control simple-select');
        $this->addSelectFilter('patient_name', 'Patient Name', $patientNames, '-1', 350, false, false,'form-control simple-select');
        $this->addInputFilter('until_date', 'Until date', 120, oeFormatShortDate(date('Y-m-d')),false);
        */

        $this->renderHeader(xl(self::REPORT_TITLE), array());

        $data = [];

        //processFilters must be exactly as name of columns define below
        $data[self::COLUMNS] = self::TABLE_COLUMNS_NAME;
        $data[self::ID] = self::REPORT_ID;
        $data[self::TITLE] = self::REPORT_TITLE;
        $data[self::ROUTE] = self::REPORT_ROUTE;
        $data[self::FILTERS] = $this->filtersElements;
        $data[self::LISTS] = array();

        $this->layout()->setTemplate('ReportTool/layout');
        $this->layout()->setVariable("title", xlt("Encounter Report"));  // set tab title

        return $this->renderReport('reports_draw_table', $data, 'encounter-report','emergency-medicine/encounter-report/');
    }

    public function getDataAjaxAction()
    {
        $filters = array();
        $settings = $this->ajaxDefaultSettings();
        extract($settings);
        $dataToProcedure = $this->processFilters($filters);
        $columns[] = array(self::DATA => '');
        $columns[] = array(self::DATA => '');


        /*$result = $this->getData($dataToProcedure, $columns);

        foreach ($result['data'] as $key => $value) {
            // # in href causees refresh not to work
        }

        $result = json_encode($result);
        */

        $result='{"data": [{"Date": 1,"Patient name": "1","Id": "1","Insurance body": "1","Branch": "1","Service type": "1","Decision": "1","Release way": "1"}]}';

        die($result);

    }

    public function excelAction()
    {
        $filters = array();
        $columns = array();
        $settings = $this->pdfDefaultSettings();
        extract($settings);
        $dataToProcedure = $this->processFilters($filters);
        $this->generateExcel($dataToProcedure, $columns, self::FILE_NAME, self::TAB_TITLE);
    }

    public function pdfAction()
    {
        $filters = array();
        $columns = array();
        $settings = $this->pdfDefaultSettings();
        extract($settings);
        $reportName = self::REPORT_NAME;
        $dataToProcedure = $this->processFilters($filters);
        $this->createReportPdf($dataToProcedure, $columns, $reportName);

    }

    private function processFilters($filters)
    {
        $filters = $this->normalizedGenericFilters($filters);
        extract($filters);
        $currentUserId = $_SESSION['authUserID'];
        $filtersToProcedure = array(
            $currentUserId,
        );
        return $filtersToProcedure;
    }

    public function CustomAjaxTemplateAction()
    {
        $result = array();
        //example
        //$result='{"results": [{"id": 1,"text": "Option 1"},{"id": 2,"text": "Option 2"}],"pagination": {"more": true}}';
        return $this->ajaxOutPut($result, 200, 'success');
    }

}
