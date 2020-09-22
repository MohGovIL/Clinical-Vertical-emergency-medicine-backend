<?php

namespace EmergencyMedicine\Controller;



use ClinikalAPI\Model\GetTemplatesServiceTable;
use FhirAPI\FhirRestApiBuilder\Parts\ErrorCodes;
use GenericTools\Model\FormEncounterTable;
use GenericTools\Model\Lists;
use GenericTools\Model\ListsOpenEmrTable;
use GenericTools\Model\ListsTable;
use Interop\Container\ContainerInterface;
use ClinikalAPI\Controller\PdfBaseController;

class prescriptionLetterController extends PdfBaseController
{
    const CATEGORY = ""; //Referral for Summary
    const BODY_PATH = ['emergency-medicine/prescription-letter/prescription-letter'];
    public $container = null;
    public function __construct(ContainerInterface $container, array $post = array())
    {
        parent::__construct($container);
        $this->container = $container;
        $this->setPostData($post);

    }

    public function setPostData(array $data)
    {
        $this->postData = $data;
    }

    public function getPostData()
    {
        return $this->postData;
    }

    public function pdfAction()
    {

        $postData = $this->getPostData();

        $configData = $this->createConfigData($postData, self::PDF_MINE_TYPE, self::CATEGORY);

        if (empty($configData)) {
            ErrorCodes::http_response_code('500', 'facility or encounter missing');
            return array();
        }

        $facilityInfo = $this->getFacilityInfo($postData['facility']);
        $letterName = $this->postData['name_of_letter'];
        $headerData = array_merge($postData, $facilityInfo);

        $date = date('Y-m-d H:i:s');

        $patientData=$this->getPatientInfo($postData['patient']);
        $doctorData=$this->getUserInfo($postData['owner']);
        $bodyData =  $this->getPrescriptions();

        $pdfBodyData = array(
            'clientReqData' => $postData,
            'patientData'=>$patientData,
            'doctorData'=>$doctorData,
            'bodyData'=>$bodyData
        );

        $fileName = "{$letterName}_{$postData['patient']}_$date.pdf";

        $pdfEncoded = $this->createBase64Pdf($fileName,self::BODY_PATH, self::HEADER_PATH, self::FOOTER_PATH, $headerData, $pdfBodyData);

        $storageSave = $this->saveDocToStorage($pdfEncoded, $fileName, $date);  //timestamp is added later

        return $this->saveDocInfoToDb($storageSave, $configData, $pdfEncoded, $fileName);         //save doc info to db

    }

}
