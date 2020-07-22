<?php

namespace EmergencyMedicine\Controller;

use FhirAPI\FhirRestApiBuilder\Parts\ErrorCodes;
use Interop\Container\ContainerInterface;

class xrayLetterController extends BaseController
{
    private $postData=array();
    public $container = null;

    public function __construct(ContainerInterface $container , array $post=array())
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
        $data=$this->getPostData();
        if(empty($data['facility'])){
            ErrorCodes::http_response_code('500', 'facility missing');
        }
        $facilityInfo=$this->getFacilityInfo($data['facility']);
        $data=array_merge($data,$facilityInfo);
        $date=date('Y-m-d H:i:s');
        $fileName= strtotime($date)."_".'xray';
        $this->getPdfService()->fileName($fileName);
        $this->getPdfService()->setCustomHeaderFooter(self::HEADER_PATH,self::FOOTER_PATH,$data,"datetime");
        $this->getPdfService()->body('emergency-medicine/xray-letter/xray-letter', array(
            'somedata' => 1,
        ));
        $this->getPdfService()->returnBinaryString();
        $binary=$this->getPdfService()->render();
        $pdfEncoded= base64_encode($binary);
        $rez=$this->saveDoc($pdfEncoded,'xray',$date);  //timestamp is added later

        if($rez['id']){
            return  array(
                "id"=>$rez['id'],
                "url"=>$rez['url'],
                "rev"=>$rez['rev'],
                "base64_data"=>$pdfEncoded
            );
        }else{
            ErrorCodes::http_response_code('500', 'failed to save document');
            return  array();
        }


    }

}
