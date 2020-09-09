<?php

namespace EmergencyMedicine\Controller;

use FhirAPI\FhirRestApiBuilder\Parts\ErrorCodes;
use Interop\Container\ContainerInterface;
use ClinikalAPI\Controller\PdfBaseController;
use ReportTool\Controller\ReportInterface;
use ReportTool\Model\CustomDB;
use GenericTools\Controller\GenericToolsController;
use GenericTools\Model\RegistryTable;

use ReportTool\Controller\BaseController;

class EncounterReportContrller extends BaseController implements ReportInterface
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

    public function __construct(ContainerInterface $container)
    {
        parent::__construct($container, self::PROCEDURE_NAME);
        $this->container = $container;
    }

    public function indexAction()
    {

        $this->initDefaultFilters();
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
        $result = $this->getData($dataToProcedure, $columns);

        foreach ($result['data'] as $key => $value) {
            // # in href causees refresh not to work
        }

        $result = json_encode($result);

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
