<?php

namespace EmergencyMedicine\Controller;

use FhirAPI\FhirRestApiBuilder\Parts\ErrorCodes;
use Interop\Container\ContainerInterface;

class xrayLetterController extends BaseController
{
    const CATEGORY = "2";

    private $postData = array();

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

        $headerData = array_merge($postData, $facilityInfo);

        $date = date('Y-m-d H:i:s');

        $pdfBodyData = array(
            'somedata' => 1,
        );

        $fileName = strtotime($date) . "_" . 'xray';

        $pdfEncoded = $this->createBase64Pdf($fileName, self::HEADER_PATH, self::FOOTER_PATH, $headerData, $pdfBodyData);

        $storageSave = $this->saveDocToStorage($pdfEncoded, 'xray', $date);  //timestamp is added later

        return $this->saveDocInfoToDb($storageSave, $configData, $pdfEncoded);         //save doc info to db

    }

}
