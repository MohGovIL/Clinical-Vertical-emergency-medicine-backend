<?php

namespace EmergencyMedicine\Controller;

use ClinikalAPI\Model\FormDiagnosisAndRecommendationsQuestionnaireMapTable;
use ClinikalAPI\Model\GetTemplatesServiceTable;
use FhirAPI\FhirRestApiBuilder\Parts\ErrorCodes;
use Interop\Container\ContainerInterface;
use ClinikalAPI\Controller\PdfBaseController;

class xrayLetterController extends PdfBaseController
{
    const CATEGORY = "2";
    const BODY_PATH = 'emergency-medicine/xray-letter/xray-letter';

    private $postData = array();

    public $container = null;

    private function getMedicalAdmissionQData($qid){
        $FormMedicalAdmissionQTable= $this->container->get(FormDiagnosisAndRecommendationsQuestionnaireMapTable::class);
        $dbData=$FormMedicalAdmissionQTable->getLastQuestionnaireAnswer($this->postData['encounter'],$qid);
        return $dbData['answer'];
    }
    private function getPregnancyState(){
        //form_medical_admission_questionnaire.answer
        //where form_id =  encounter = <ENC_ID>, qid = 4 )
       return $this->getMedicalAdmissionQData(4);
    }

    private function getFindings(){
        //form_medical_admission_questionnaire.answer
        //where form_id =  encounter = <ENC_ID>, qid = 2 )
        return $this->getMedicalAdmissionQData(2);
    }

    private function getDiagnostics(){
        //form_diagnosis_and_recommendations_questionnaire.answer
        //where encounter = <ENC_ID>, qid = 1 )
        return $this->getMedicalAdmissionQData(1);
    }
    private function getServiceTypeAndReasonCode(){
        //from encounter
    }
    private function getEmergencyXrayLetterData(){
        $data = [];
        $data['pregnant'] = $this->getPregnancyState();
        $data['findings'] = $this->getFindings();
        $data['diagnostics'] = $this->getDiagnostics();
        return $data;
    }

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
        $letterName = $postData['name_of_letter'];
        $headerData = array_merge($postData, $facilityInfo);

        $date = date('Y-m-d H:i:s');

        $patientData=$this->getPatientInfo($postData['patient']);
        $doctorData=$this->getUserInfo($postData['owner']);
        $bodyData = $this->getEmergencyXrayLetterData();
        $pdfBodyData = array(
            'clientReqData' => $postData,
            'patientData'=>$patientData,
            'doctorData'=>$doctorData,
            'bodyData'=>$bodyData
        );

        $fileName = strtotime($date) . "_" . 'xray';

        $pdfEncoded = $this->createBase64Pdf($fileName,self::BODY_PATH, self::HEADER_PATH, self::FOOTER_PATH, $headerData, $pdfBodyData);

        $storageSave = $this->saveDocToStorage($pdfEncoded, 'xray', $date);  //timestamp is added later

        return $this->saveDocInfoToDb($storageSave, $configData, $pdfEncoded);         //save doc info to db

    }

}
