<?php

namespace EmergencyMedicine\Controller;

use FhirAPI\FhirRestApiBuilder\Parts\ErrorCodes;
use GenericTools\Controller\BaseController as GenericBaseController;
use GenericTools\Model\DocumentsCategoriesTable;
use GenericTools\Model\DocumentsTable;
use Interop\Container\ContainerInterface;
use GenericTools\Traits\saveDocToServer;

class BaseController extends GenericBaseController
{
    use saveDocToServer;

    CONST HEADER_PATH= 'emergency-medicine/letter-generator/letter-generator-header';
    CONST FOOTER_PATH= 'emergency-medicine/letter-generator/letter-generator-footer';

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
        if(!is_null($id)){
            $info= $this->container->get('GenericTools\Model\FacilityTable')->getFacility(intval($id));
            $data=array();
            $data['clinic'] =$info->name;
            $data['address'] =$info->street." ".$info->city;
            $data['phone'] =$info->phone;
            $data['email'] =$info->email;
            return $data;

        }else{
            return array();
        }
    }

    /**
     *
     */
    public function saveDoc($data,$fileName,$date)
    {
        $dataToSave=array();
        $dataToSave['storage']['data']= $data;
        $dataToSave['documents']['date']=$date;
        $dataToSave['documents']['url']=$fileName;
        $rez=$this->uploadToStorage($dataToSave);
        return $rez;
    }

    public function saveAsDocumentReference($savedata,$postData,$fileName,$date)
    {
        $documentsTable = $this->container->get(DocumentsTable::class);
        $documentsCategoriesTable = $this->container->get(DocumentsCategoriesTable::class);

    }


}
