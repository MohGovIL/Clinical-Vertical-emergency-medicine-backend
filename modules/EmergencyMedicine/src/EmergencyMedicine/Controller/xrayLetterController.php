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

class xrayLetterController extends PdfBaseController
{
    /*  collect data from these orms
        FormDiagnosisAndRecommendationsQuestionnaireMapTable
        FormCommitmentQuestionnaireMapTable
        FormMedicalAdmissionQuestionnaireMapTable*/
    const CATEGORY = "4"; //Referral for X-ray
    const BODY_PATH = 'emergency-medicine/xray-letter/xray-letter';



    public $container = null;
    public function getPregnancyState($patientData){
        if($patientData['Gender']=="Male")
            return "";
        //form_medical_admission_questionnaire.answer
        //where form_id =  encounter = <ENC_ID>, qid = 4 )
        return $this->getQData(4,'FormMedicalAdmissionQuestionnaireMapTable');
    }

    public function getFindings(){
        //form_medical_admission_questionnaire.answer
        //where form_id =  encounter = <ENC_ID>, qid = 2 )
        return $this->getQData(1,'FormDiagnosisAndRecommendationsQuestionnaireMapTable');
    }

    public function getDiagnostics(){
        //form_diagnosis_and_recommendations_questionnaire.answer
        //where encounter = <ENC_ID>, qid = 1 )
        return $this->getQData(2,'FormDiagnosisAndRecommendationsQuestionnaireMapTable');
    }

    private function getEmergencyXrayLetterData($patientData){
        $data = [];
        $data['reason_for_refferal'] = $this->getServiceTypeAndReasonCode();
        $data['pregnant'] = $this->getPregnancyState($patientData);
        $data['findings'] =str_replace("\n","<br/>",
                                       str_replace("\r\n","<br/>",$this->getFindings()));
        $data['diagnosis'] =str_replace("\n","<br/>",
                                       str_replace("\r\n","<br/>",$this->getDiagnostics()));



        return $data;
    }
    private function getXrayType(){
        $x_ray_type = $this->getTitleOfOptionFromListTable("x_ray_types",$this->postData['x_ray_type']);
        $this->postData['x_ray_type'] = $x_ray_type;
    }
    public function __construct(ContainerInterface $container, array $post = array())
    {
        parent::__construct($container);
        $this->container = $container;
        $this->setPostData($post);
        $this->getXrayType();
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
        $letterName = $postData['name_of_letter'];
        $headerData = array_merge($postData, $facilityInfo);

        $date = date('Y-m-d H:i:s');

        $patientData=$this->getPatientInfo($postData['patient']);
        $doctorData=$this->getUserInfo($postData['owner']);
        $bodyData = $this->getEmergencyXrayLetterData($patientData);


        $pdfBodyData = array(
            'clientReqData' => $postData,
            'patientData'=>$patientData,
            'doctorData'=>$doctorData,
            'bodyData'=>$bodyData
        );

        $fileName = "x_ray_patient_{$postData['patient']}_$date.pdf";

        $pdfEncoded = $this->createBase64Pdf($fileName,self::BODY_PATH, self::HEADER_PATH, self::FOOTER_PATH, $headerData, $pdfBodyData);

        $storageSave = $this->saveDocToStorage($pdfEncoded, $fileName, $date);  //timestamp is added later

        return $this->saveDocInfoToDb($storageSave, $configData, $pdfEncoded, $fileName);         //save doc info to db

    }

}
