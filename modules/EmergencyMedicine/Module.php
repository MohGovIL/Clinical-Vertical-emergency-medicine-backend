<?php
/* +-----------------------------------------------------------------------------+
 * Copyright 2016 matrix israel
 * LICENSE: This program is free software; you can redistribute it and/or
 * modify it under the terms of the GNU General Public License
 * as published by the Free Software Foundation; either version 3
 * of the License, or (at your option) any later version.
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
 * GNU General Public License for more details.
 * You should have received a copy of the GNU General Public License
 * along with this program. If not, see
 * http://www.gnu.org/licenses/licenses.html#GPL
 *    @author  Oshri Rozmarin <oshri.rozmarin@gmail.com>
 * +------------------------------------------------------------------------------+
 *
 */
namespace EmergencyMedicine;


use Interop\Container\ContainerInterface;
use Laminas\Db\ResultSet\ResultSet;
use Laminas\Db\TableGateway\TableGateway as ZendTableGateway;
use OpenEMR\Events\Globals\GlobalsInitializedEvent;
use OpenEMR\Events\RestApiExtend\RestApiCreateEvent;
use OpenEMR\Services\Globals\GlobalSetting;
use Symfony\Component\EventDispatcher\EventDispatcherInterface;
use Zend\Db\TableGateway\TableGateway;
use Zend\ModuleManager\ModuleManager;
use Zend\Mvc\MvcEvent;
use ClinikalAPI\Model\QuestionnaireMap;
use ClinikalAPI\Model\QuestionnaireMapTable;

class Module {


    public function getAutoloaderConfig()
    {
        return array(
            'Zend\Loader\ClassMapAutoloader' => array(
                __DIR__ . '/autoload_classmap.php',
            ),
            'Zend\Loader\StandardAutoloader' => array(
                'namespaces' => array(
                    __NAMESPACE__ => __DIR__ . '/src/' . __NAMESPACE__,

                ),
            ),
        );
    }

    public function getConfig()
    {
        return include __DIR__ . '/config/module.config.php';
    }


    /**
     * @return array
     */
    public function getServiceConfig()
    {
        return array(
            'factories' => array(
                'FormDiagnosisAndRecommendationsQuestionnaireMapTable' =>  function(ContainerInterface $container) {
                    $dbAdapter = $container->get(\Laminas\Db\Adapter\Adapter::class);
                    $resultSetPrototype = new ResultSet();
                    $resultSetPrototype->setArrayObjectPrototype(new QuestionnaireMap());
                    $tableGateway = new ZendTableGateway('form_diagnosis_and_recommendations_questionnaire', $dbAdapter, null, $resultSetPrototype);
                    $table = new QuestionnaireMapTable($tableGateway);
                    return $table;
                },

                'FormMedicalAdmissionQuestionnaireMapTable'  =>  function(ContainerInterface $container) {
                    $dbAdapter = $container->get(\Laminas\Db\Adapter\Adapter::class);
                    $resultSetPrototype = new ResultSet();
                    $resultSetPrototype->setArrayObjectPrototype(new QuestionnaireMap());
                    $tableGateway = new ZendTableGateway('form_medical_admission_questionnaire', $dbAdapter, null, $resultSetPrototype);
                    $table = new QuestionnaireMapTable($tableGateway);
                    return $table;
                },

                'FormCommitmentQuestionnaireMapTable' =>  function(ContainerInterface $container) {
                    $dbAdapter = $container->get(\Laminas\Db\Adapter\Adapter::class);
                    $resultSetPrototype = new ResultSet();
                    $resultSetPrototype->setArrayObjectPrototype(new QuestionnaireMap());
                    $tableGateway = new ZendTableGateway('form_commitment_questionnaire', $dbAdapter, null, $resultSetPrototype);
                    $table = new QuestionnaireMapTable($tableGateway);
                    return $table;
                },
            ),
        );
    }

    /**
     * @param \Laminas\Mvc\MvcEvent $e
     *
     * Register our event listeners here
     */
    public function onBootstrap(MvcEvent $e)
    {
        // Get application service manager and get instance of event dispatcher
        $serviceManager = $e->getApplication()->getServiceManager();
        $oemrDispatcher = $serviceManager->get(EventDispatcherInterface::class);
        $this->container = $serviceManager;
        // listen for view events for routes in zend_modules
        $oemrDispatcher->addListener(GlobalsInitializedEvent::EVENT_HANDLE, [$this, 'addCustomGlobals']);
    }


    public function addCustomGlobals(GlobalsInitializedEvent $event)
    {
        /*******************************************************************/
        $setting = new GlobalSetting(xlt("medical admission form - hide insulation input"), 'bool', 0, xlt("When checked insulation field is hidden in the medical admission form"));
        $event->getGlobalsService()->appendToSection("clinikal settings", "clinikal_forms_hide_insulation", $setting);
        /*******************************************************************/

        /*******************************************************************/
        $setting = new GlobalSetting(xlt("Summery letter - general instructions"), 'text', '', xlt("Constant statement is shown as general instructions in the summary letter"));
        $event->getGlobalsService()->appendToSection("clinikal settings", "summery_letter_general_instructions", $setting);
        /*******************************************************************/
        /*******************************************************************/
        $setting = new GlobalSetting(xlt("Medical admission form - Medical Background Comments"), 'bool', 1, xlt("When checked, Medical Background Comments field is shown"));
        $event->getGlobalsService()->appendToSection("clinikal settings", "clinikal_forms_medical_background_comments", $setting);
        /*******************************************************************/
    }

}
