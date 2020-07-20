<?php

namespace EmergencyMedicine\Controller;

use GenericTools\Controller\BaseController as GenericBaseController;
use Interop\Container\ContainerInterface;


class BaseController extends GenericBaseController
{
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

}
