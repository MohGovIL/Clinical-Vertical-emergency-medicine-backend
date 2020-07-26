<?php

namespace EmergencyMedicine\Controller;

use FhirAPI\FhirRestApiBuilder\Parts\ErrorCodes;
use GenericTools\Controller\BaseController as GenericBaseController;
use GenericTools\Model\DocumentsCategoriesTable;
use GenericTools\Model\DocumentsTable;
use GenericTools\Service\CouchdbService;
use GenericTools\Service\S3Service;
use Interop\Container\ContainerInterface;
use GenericTools\Traits\saveDocToServer;

class BaseController extends GenericBaseController
{
    use saveDocToServer;

    const HEADER_PATH = 'emergency-medicine/letter-generator/letter-generator-header';
    const FOOTER_PATH = 'emergency-medicine/letter-generator/letter-generator-footer';
    const DOC_TYPE = "file_url";
    const PDF_MINE_TYPE = "application/pdf";

    private $container;

    public function __construct(ContainerInterface $container)
    {
        parent::__construct($container);
        $this->container = $container;
    }

    /**
     * get facility data
     */
    public function getFacilityInfo($id = null)
    {
        if (!is_null($id)) {
            $info = $this->container->get('GenericTools\Model\FacilityTable')->getFacility(intval($id));
            $data = array();
            $data['clinic'] = $info->name;
            $data['address'] = $info->street . " " . $info->city;
            $data['phone'] = $info->phone;
            $data['email'] = $info->email;
            return $data;

        } else {
            return array();
        }
    }

    public function saveDocToStorage($data, $fileName, $date)
    {
        $dataToSave = array();
        $dataToSave['storage']['data'] = $data;
        $dataToSave['documents']['date'] = $date;
        $dataToSave['documents']['url'] = $fileName;
        $rez = $this->uploadToStorage($dataToSave);
        return $rez;
    }

    public function buildArrToDb($data)
    {
        if (empty($data['category']) || empty($data['encounter']) || empty($data['mimetype'])) {
            return array();
        }

        $dbStructuredData = array(
            'documents' => array(
                'id' => null,     //will be filled later
                'type' => self::DOC_TYPE,
                'storagemethod' => $GLOBALS['clinikal_storage_method'],
                'mimetype' => $data['mimetype'],
                'owner' => (empty($data['owner'])) ? $_SESSION['authUserID'] : $data['owner'],
                'foreign_id' => (empty($data['patient'])) ? null : $data['patient'],      //patient
                'encounter_id' => $data['encounter'],
                'date' => date('Y-m-d H:i:s'),
            ),
            'categories_to_documents' => array(
                'document_id' => null,   //will be filled later
                'category_id' => $data['category'],
            )
        );

        if($GLOBALS['clinikal_storage_method'] == S3Service::STORAGE_METHOD_CODE) {
            $dbStructuredData['documents']['url'] = $data['url'];
            $dbStructuredData['documents']['couch_docid'] = null;
            $dbStructuredData['documents']['couch_revid'] = null;
        }
        elseif($GLOBALS['clinikal_storage_method'] == CouchdbService::STORAGE_METHOD_CODE) {
            $dbStructuredData['documents']['couch_docid'] = $data['id'];
            $dbStructuredData['documents']['couch_revid'] = $data['rev'];
        }

        return $dbStructuredData;
    }

    public function saveDocToDb($dbStructuredData)
    {
        $documentsTable = $this->container->get(DocumentsTable::class);
        $documentsCategoriesTable = $this->container->get(DocumentsCategoriesTable::class);

        $id= $documentsTable->lastId() + 1;

        $dbStructuredData['documents']['id'] = $id;
        $dbStructuredData['categories_to_documents']['document_id']= $id;

        // save to documents table
        $insertInfo = $documentsTable->insert($dbStructuredData['documents']);
        if ($insertInfo == false) {
            return false;
        }

        // save to categories_to_documents table
        $insertCategory = $documentsCategoriesTable->insert($dbStructuredData['categories_to_documents']);
        if ($insertCategory == false) {
            return false;
        }

        return $id;
    }

    public function saveDocInfoToDb($storageSave, $configData,$pdfEncoded)
    {

        if ($storageSave['id']) {

            $configData = array_merge($configData, $storageSave);

            $dbStructuredData = $this->buildArrToDb($configData);

            if (empty($dbStructuredData)) {
                ErrorCodes::http_response_code('500', 'failed to build data to db');
                return array();
            } else {

                $save = $this->saveDocToDb($dbStructuredData);

                if($save){
                    return array(
                        "id" => $save,
                        "base64_data" => $pdfEncoded
                    );
                }else{
                    ErrorCodes::http_response_code('500', 'failed to build data to db');
                    return array();
                }
            }
        } else {
            ErrorCodes::http_response_code('500', 'failed to save document');
            return array();
        }
    }

    public function createConfigData($postData,$mimetype, $category)
    {
        if (empty($postData['facility']) || empty($postData['encounter'])) {
            return array();
        }

        $configData = array(
            'mimetype' => $mimetype,
            'category' => $category,
            'encounter' => $postData['encounter']
        );

        if (empty($postData['owner'])) {
            $configData['owner'] = $postData['owner'];
        }

        if (empty($postData['patient'])) {
            $configData['patient'] = $postData['patient'];
        }
        return $configData;
    }
}
