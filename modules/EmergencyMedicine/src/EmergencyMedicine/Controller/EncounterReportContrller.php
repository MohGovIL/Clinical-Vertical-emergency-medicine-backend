<?php

namespace EmergencyMedicine\Controller;

use FhirAPI\FhirRestApiBuilder\Parts\ErrorCodes;
use Interop\Container\ContainerInterface;
use ClinikalAPI\Controller\PdfBaseController;

use ReportTool\Controller\BaseController;
use ReportTool\Controller\ReportInterface;
use ReportTool\Model\CustomDB;
use GenericTools\Controller\GenericToolsController;
use ReportTool\Model\RegistryTable;

class EncounterReportContrller  extends BaseController implements ReportInterface
{
    const PROCEDURE_NAME = 'EncounterReport';

    public function __construct(ContainerInterface $container)
    {
        parent::__construct($container, self::PROCEDURE_NAME);
        $this->container = $container;
    }

    public function indexAction()
    {
        $data = [];
        $this->layout()->setVariable("title", xlt("Encounter Report"));
        return $this->renderReport('reports_draw_table', $data, 'encounter-report');
    }

    public function getDataAjaxAction()
    {

    }

    public function excelAction()
    {

    }

    public function pdfAction()
    {

    }

    private function processFilters($filters)
    {

    }

}
