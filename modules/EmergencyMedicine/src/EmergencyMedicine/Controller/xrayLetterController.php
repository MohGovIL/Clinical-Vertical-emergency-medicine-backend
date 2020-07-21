<?php

namespace EmergencyMedicine\Controller;
/**
 *
 * This is a template class for develop and testing
 *
 */
class xrayLetterController extends BaseController
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

        $data=array();
        $facility=$this->getFacilityInfo(17);
        $data=array_merge($data,$facility);


        $this->getPdfService()->fileName('stam' . date("Y_m_d"));
        $this->getPdfService()->setCustomHeaderFooter(self::HEADER_PATH,self::FOOTER_PATH,$data,"datetime");
        $this->getPdfService()->body('emergency-medicine/xray-letter/xray-letter', array(
            'patient' => 1,
        ));
        //$this->getPdfService()->returnBinaryString();
        $this->getPdfService()->render();
        //return $this->getPdfService()->render();

    }

}
