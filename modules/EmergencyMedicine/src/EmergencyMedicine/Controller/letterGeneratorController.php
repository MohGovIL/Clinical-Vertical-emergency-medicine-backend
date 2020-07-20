<?php

namespace EmergencyMedicine\Controller;
/**
 *
 * This is a template class for develop and testing 
 *
 */
class letterGeneratorController extends BaseController
{

    public function pdfAction()
    {
        /*
        if (!acl_check('patients', 'symptoms_after_vaccination')) {
            $this->redirect()->toRoute('errors', array(
                'action' => 'access-denied'
            ));
        }
        */

        $this->getPdfService()->fileName('stam' . date("Y_m_d"));
        $this->getPdfService()->setCustomHeaderFooter(self::HEADER_PATH,self::FOOTER_PATH,"datetime");
        $this->getPdfService()->body('emergency-medicine/letter-generator/letter-generator', array(
            'patient' => 1,
        ));
        //$this->getPdfService()->returnBinaryString();
        $this->getPdfService()->render();
        //return $this->getPdfService()->render();

    }

}
