<?php

namespace EmergencyMedicine\Controller;

use GenericTools\Controller\BaseController as GenericBaseController;
use Interop\Container\ContainerInterface;


class BaseController extends GenericBaseController
{
    CONST HEADER_PATH= 'emergency-medicine/letter-generator/letter-generator-header';
    CONST FOOTER_PATH= 'emergency-medicine/letter-generator/letter-generator-footer';

    public function __construct(ContainerInterface $container)
    {
        parent::__construct($container);
        $this->container = $container;
    }

}
