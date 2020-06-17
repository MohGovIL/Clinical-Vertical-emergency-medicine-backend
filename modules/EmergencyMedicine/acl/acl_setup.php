
<?php
// Ensure this script is not called separately
if ((empty($_SESSION['acl_setup_unique_id'])) ||
    (empty($unique_id)) ||
    ($unique_id != $_SESSION['acl_setup_unique_id'])) {
    die('Authentication Error');
}
unset($_SESSION['acl_setup_unique_id']);

use OpenEMR\Common\Acl\AclExtended;

$admin_write = AclExtended::getAclIdNumber('Administrators', 'write');
$emergency_clinic_manager_write =AclExtended::addNewACL('Emergency manager', 'emergency_clinic_manager', 'write', 'Things that emergency clinic manager can modify');
$emergency_clinic_manager_view =AclExtended::addNewACL('Emergency manager', 'emergency_clinic_manager', 'view', 'Things that emergency clinic manager can read but not modify');
$emergency_receptionist_write =AclExtended::addNewACL('Emergency receptionist', 'emergency_receptionist', 'write', 'Things that emergency receptionist can modify');
$emergency_receptionist_view =AclExtended::addNewACL('Emergency receptionist', 'emergency_receptionist', 'view', 'Things that emergency receptionist can read but not modify');
$emergency_nurse_write =AclExtended::addNewACL('Emergency nurse', 'emergency_nurse', 'write', 'Things that emergency nurse can modify');
$emergency_nurse_view =AclExtended::addNewACL('Emergency nurse', 'emergency_nurse', 'view', 'Things that emergency nurse can read but not modify');
$emergency_doctor_write =AclExtended::addNewACL('Emergency doctor', 'emergency_doctor', 'write', 'Things that emergency doctor can modify');
$emergency_doctor_view =AclExtended::addNewACL('Emergency doctor', 'emergency_doctor', 'view', 'Things that emergency doctor can read but not modify');

AclExtended::addObjectAcl('client_app', 'Client Application', 'MedicalAdmissionForm','Medical Admission Form');
AclExtended::addObjectAcl('client_app', 'Client Application', 'TestsandTreatmentsForm','Tests and Treatments Form');
AclExtended::addObjectAcl('client_app', 'Client Application', 'DiagnosisandRecommendationsForm','Diagnosis and Recommendations Form');
AclExtended::addObjectAcl('client_app', 'Client Application', 'SummaryLetter','Summary Letter');
AclExtended::addObjectAcl('client_app', 'Client Application', 'EncountersReport','Encounters Report');
AclExtended::addObjectAcl('client_app', 'Client Application', 'UnidentifiedPatient','Unidentified Patient');
AclExtended::addObjectAcl('client_app', 'Client Application', 'PatientTrackingWaitingForRelease','Patient Tracking Waiting for Release');


//Emergency manager ACL
// client app ACL
AclExtended::updateAcl($emergency_clinic_manager_write, 'Emergency manager', 'client_app', 'Client Application', 'PatientTrackingInvited','Patient Tracking Invited', 'write');
AclExtended::updateAcl($emergency_clinic_manager_write, 'Emergency manager', 'client_app', 'Client Application', 'PatientTrackingWaitingForExamination','Patient Tracking Waiting for Examination', 'write');
AclExtended::updateAcl($emergency_clinic_manager_write, 'Emergency manager', 'client_app', 'Client Application', 'PatientTrackingWaitingForDecoding','Patient Tracking Waiting for Decoding', 'write');
AclExtended::updateAcl($emergency_clinic_manager_write, 'Emergency manager', 'client_app', 'Client Application', 'PatientTrackingWaitingForRelease','Patient Tracking Waiting for Release', 'write');
AclExtended::updateAcl($emergency_clinic_manager_write, 'Emergency manager', 'client_app', 'Client Application', 'PatientTrackingFinished','Patient Tracking Finished', 'write');
AclExtended::updateAcl($emergency_clinic_manager_view, 'Emergency manager', 'client_app', 'Client Application', 'SearchPatient','Search Patient', 'view');
AclExtended::updateAcl($emergency_clinic_manager_write, 'Emergency manager', 'client_app', 'Client Application', 'AddPatient','Add Patient', 'write');
AclExtended::updateAcl($emergency_clinic_manager_write, 'Emergency manager', 'client_app', 'Client Application', 'PatientAdmission','Patient Admission', 'write');
AclExtended::updateAcl($emergency_clinic_manager_view, 'Emergency manager', 'client_app', 'Client Application', 'AppointmentsAndEncounters','Appointments And Encounters', 'view');
AclExtended::updateAcl($emergency_clinic_manager_view, 'Emergency manager', 'client_app', 'Client Application', 'EncounterSheet','Encounter Sheet', 'view');

AclExtended::updateAcl($emergency_clinic_manager_view, 'Emergency manager', 'client_app', 'Client Application', 'MedicalAdmissionForm','Medical Admission Form', 'view');
AclExtended::updateAcl($emergency_clinic_manager_view, 'Emergency manager', 'client_app', 'Client Application', 'TestsandTreatmentsForm','Tests and Treatments Form', 'view');
AclExtended::updateAcl($emergency_clinic_manager_view, 'Emergency manager', 'client_app', 'Client Application', 'DiagnosisandRecommendationsForm','Diagnosis and Recommendations Form', 'view');
AclExtended::updateAcl($emergency_clinic_manager_view, 'Emergency manager', 'client_app', 'Client Application', 'SummaryLetter','Summary Letter', 'view');
AclExtended::updateAcl($emergency_clinic_manager_view, 'Emergency manager', 'client_app', 'Client Application', 'EncountersReport','Encounters Report', 'view');
AclExtended::updateAcl($emergency_clinic_manager_write, 'Emergency manager', 'client_app', 'Client Application', 'UnidentifiedPatient','Unidentified Patient', 'write');

// FHIR ACL
AclExtended::updateAcl($emergency_clinic_manager_write, 'Emergency manager', 'fhir_api', 'FHIR API', 'patient','Patient', 'write');
AclExtended::updateAcl($emergency_clinic_manager_write, 'Emergency manager', 'fhir_api', 'FHIR API', 'appointment','Appointment', 'write');
AclExtended::updateAcl($emergency_clinic_manager_write, 'Emergency manager', 'fhir_api', 'FHIR API', 'encounter','Encounter', 'write');
AclExtended::updateAcl($emergency_clinic_manager_view, 'Emergency manager', 'fhir_api', 'FHIR API', 'practitioner','Practitioner', 'view');
AclExtended::updateAcl($emergency_clinic_manager_view, 'Emergency manager', 'fhir_api', 'FHIR API', 'organization','Organization', 'view');
AclExtended::updateAcl($emergency_clinic_manager_view, 'Emergency manager', 'fhir_api', 'FHIR API', 'healthcareservice','Healthcareb Service', 'view');
AclExtended::updateAcl($emergency_clinic_manager_view, 'Emergency manager', 'fhir_api', 'FHIR API', 'valueset','Value Set', 'view');
AclExtended::updateAcl($emergency_clinic_manager_write, 'Emergency manager', 'fhir_api', 'FHIR API', 'relatedperson','Related Person', 'write');
AclExtended::updateAcl($emergency_clinic_manager_write, 'Emergency manager', 'fhir_api', 'FHIR API', 'documentreference','Document Reference', 'write');
AclExtended::updateAcl($emergency_clinic_manager_view, 'Emergency manager', 'fhir_api', 'FHIR API', 'questionnaire','Questionnaire', 'view');
AclExtended::updateAcl($emergency_clinic_manager_view, 'Emergency manager', 'fhir_api', 'FHIR API', 'questionnaireresponse','Questionnaire Response', 'view');
AclExtended::updateAcl($emergency_clinic_manager_view, 'Emergency manager', 'fhir_api', 'FHIR API', 'condition','Condition', 'view');
AclExtended::updateAcl($emergency_clinic_manager_view, 'Emergency manager', 'fhir_api', 'FHIR API', 'medicationstatement','Medication Statement Response', 'view');
AclExtended::updateAcl($emergency_clinic_manager_view, 'Emergency manager', 'fhir_api', 'FHIR API', 'observation','Observation', 'view');


//Emergency receptionist ACL
// client app ACL
AclExtended::updateAcl($emergency_receptionist_write, 'Emergency receptionist', 'client_app', 'Client Application', 'PatientTrackingInvited','Patient Tracking Invited', 'write');
AclExtended::updateAcl($emergency_receptionist_write, 'Emergency receptionist', 'client_app', 'Client Application', 'PatientTrackingWaitingForExamination','Patient Tracking Waiting for Examination', 'write');
AclExtended::updateAcl($emergency_receptionist_write, 'Emergency receptionist', 'client_app', 'Client Application', 'PatientTrackingWaitingForDecoding','Patient Tracking Waiting for Decoding', 'write');
AclExtended::updateAcl($emergency_receptionist_write, 'Emergency receptionist', 'client_app', 'Client Application', 'PatientTrackingWaitingForRelease','Patient Tracking Waiting for Release', 'write');
AclExtended::updateAcl($emergency_receptionist_write, 'Emergency receptionist', 'client_app', 'Client Application', 'PatientTrackingFinished','Patient Tracking Finished', 'write');
AclExtended::updateAcl($emergency_receptionist_view, 'Emergency receptionist', 'client_app', 'Client Application', 'SearchPatient','Search Patient', 'view');
AclExtended::updateAcl($emergency_receptionist_write, 'Emergency receptionist', 'client_app', 'Client Application', 'AddPatient','Add Patient', 'write');
AclExtended::updateAcl($emergency_receptionist_write, 'Emergency receptionist', 'client_app', 'Client Application', 'PatientAdmission','Patient Admission', 'write');
AclExtended::updateAcl($emergency_receptionist_view, 'Emergency receptionist', 'client_app', 'Client Application', 'AppointmentsAndEncounters','Appointments And Encounters', 'view');
AclExtended::updateAcl($emergency_receptionist_view, 'Emergency receptionist', 'client_app', 'Client Application', 'EncounterSheet','Encounter Sheet', 'view');

AclExtended::updateAcl($emergency_receptionist_view, 'Emergency receptionist', 'client_app', 'Client Application', 'MedicalAdmissionForm','Medical Admission Form', 'view');
AclExtended::updateAcl($emergency_receptionist_view, 'Emergency receptionist', 'client_app', 'Client Application', 'TestsandTreatmentsForm','Tests and Treatments Form', 'view');
AclExtended::updateAcl($emergency_receptionist_view, 'Emergency receptionist', 'client_app', 'Client Application', 'DiagnosisandRecommendationsForm','Diagnosis and Recommendations Form', 'view');
AclExtended::updateAcl($emergency_receptionist_view, 'Emergency receptionist', 'client_app', 'Client Application', 'SummaryLetter','Summary Letter', 'view');
AclExtended::updateAcl($emergency_receptionist_view, 'Emergency receptionist', 'client_app', 'Client Application', 'EncountersReport','Encounters Report', 'view');
AclExtended::updateAcl($emergency_receptionist_write, 'Emergency receptionist', 'client_app', 'Client Application', 'UnidentifiedPatient','Unidentified Patient', 'write');

// FHIR ACL
AclExtended::updateAcl($emergency_receptionist_write, 'Emergency receptionist', 'fhir_api', 'FHIR API', 'patient','Patient', 'write');
AclExtended::updateAcl($emergency_receptionist_write, 'Emergency receptionist', 'fhir_api', 'FHIR API', 'appointment','Appointment', 'write');
AclExtended::updateAcl($emergency_receptionist_write, 'Emergency receptionist', 'fhir_api', 'FHIR API', 'encounter','Encounter', 'write');
AclExtended::updateAcl($emergency_receptionist_view, 'Emergency receptionist', 'fhir_api', 'FHIR API', 'practitioner','Practitioner', 'view');
AclExtended::updateAcl($emergency_receptionist_view, 'Emergency receptionist', 'fhir_api', 'FHIR API', 'organization','Organization', 'view');
AclExtended::updateAcl($emergency_receptionist_view, 'Emergency receptionist', 'fhir_api', 'FHIR API', 'healthcareservice','Healthcareb Service', 'view');
AclExtended::updateAcl($emergency_receptionist_view, 'Emergency receptionist', 'fhir_api', 'FHIR API', 'valueset','Value Set', 'view');
AclExtended::updateAcl($emergency_receptionist_write, 'Emergency receptionist', 'fhir_api', 'FHIR API', 'relatedperson','Related Person', 'write');
AclExtended::updateAcl($emergency_receptionist_write, 'Emergency receptionist', 'fhir_api', 'FHIR API', 'documentreference','Document Reference', 'write');
AclExtended::updateAcl($emergency_receptionist_view, 'Emergency receptionist', 'fhir_api', 'FHIR API', 'questionnaire','Questionnaire', 'view');
AclExtended::updateAcl($emergency_receptionist_view, 'Emergency receptionist', 'fhir_api', 'FHIR API', 'questionnaireresponse','Questionnaire Response', 'view');
AclExtended::updateAcl($emergency_receptionist_view, 'Emergency receptionist', 'fhir_api', 'FHIR API', 'condition','Condition', 'view');
AclExtended::updateAcl($emergency_receptionist_view, 'Emergency receptionist', 'fhir_api', 'FHIR API', 'medicationstatement','Medication Statement Response', 'view');
AclExtended::updateAcl($emergency_receptionist_view, 'Emergency receptionist', 'fhir_api', 'FHIR API', 'observation','Observation', 'view');

//Emergency nurse ACL
// client app ACL
AclExtended::updateAcl($emergency_nurse_write, 'Emergency nurse', 'client_app', 'Client Application', 'PatientTrackingInvited','Patient Tracking Invited', 'write');
AclExtended::updateAcl($emergency_nurse_write, 'Emergency nurse', 'client_app', 'Client Application', 'PatientTrackingWaitingForExamination','Patient Tracking Waiting for Examination', 'write');
AclExtended::updateAcl($emergency_nurse_write, 'Emergency nurse', 'client_app', 'Client Application', 'PatientTrackingWaitingForDecoding','Patient Tracking Waiting for Decoding', 'write');
AclExtended::updateAcl($emergency_nurse_write, 'Emergency nurse', 'client_app', 'Client Application', 'PatientTrackingWaitingForRelease','Patient Tracking Waiting for Release', 'write');
AclExtended::updateAcl($emergency_nurse_write, 'Emergency nurse', 'client_app', 'Client Application', 'PatientTrackingFinished','Patient Tracking Finished', 'write');
AclExtended::updateAcl($emergency_nurse_view, 'Emergency nurse', 'client_app', 'Client Application', 'SearchPatient','Search Patient', 'view');
//AclExtended::updateAcl($emergency_nurse_write, 'Emergency nurse', 'client_app', 'Client Application', 'AddPatient','Add Patient', 'write');
//AclExtended::updateAcl($emergency_nurse_write, 'Emergency nurse', 'client_app', 'Client Application', 'PatientAdmission','Patient Admission', 'write');
AclExtended::updateAcl($emergency_nurse_view, 'Emergency nurse', 'client_app', 'Client Application', 'AppointmentsAndEncounters','Appointments And Encounters', 'view');
AclExtended::updateAcl($emergency_nurse_view, 'Emergency nurse', 'client_app', 'Client Application', 'EncounterSheet','Encounter Sheet', 'view');

AclExtended::updateAcl($emergency_nurse_write, 'Emergency nurse', 'client_app', 'Client Application', 'MedicalAdmissionForm','Medical Admission Form', 'write');
AclExtended::updateAcl($emergency_nurse_write, 'Emergency nurse', 'client_app', 'Client Application', 'TestsandTreatmentsForm','Tests and Treatments Form', 'write');
AclExtended::updateAcl($emergency_nurse_view, 'Emergency nurse', 'client_app', 'Client Application', 'DiagnosisandRecommendationsForm','Diagnosis and Recommendations Form', 'view');
AclExtended::updateAcl($emergency_nurse_view, 'Emergency nurse', 'client_app', 'Client Application', 'SummaryLetter','Summary Letter', 'view');
AclExtended::updateAcl($emergency_nurse_view, 'Emergency nurse', 'client_app', 'Client Application', 'EncountersReport','Encounters Report', 'view');
AclExtended::updateAcl($emergency_nurse_write, 'Emergency nurse', 'client_app', 'Client Application', 'UnidentifiedPatient','Unidentified Patient', 'write');
// FHIR ACL
AclExtended::updateAcl($emergency_nurse_write, 'Emergency nurse', 'fhir_api', 'FHIR API', 'patient','Patient', 'write');
AclExtended::updateAcl($emergency_nurse_view, 'Emergency nurse', 'fhir_api', 'FHIR API', 'appointment','Appointment', 'view');
AclExtended::updateAcl($emergency_nurse_write, 'Emergency nurse', 'fhir_api', 'FHIR API', 'encounter','Encounter', 'write');
AclExtended::updateAcl($emergency_nurse_view, 'Emergency nurse', 'fhir_api', 'FHIR API', 'practitioner','Practitioner', 'view');
AclExtended::updateAcl($emergency_nurse_view, 'Emergency nurse', 'fhir_api', 'FHIR API', 'organization','Organization', 'view');
AclExtended::updateAcl($emergency_nurse_view, 'Emergency nurse', 'fhir_api', 'FHIR API', 'healthcareservice','Healthcareb Service', 'view');
AclExtended::updateAcl($emergency_nurse_view, 'Emergency nurse', 'fhir_api', 'FHIR API', 'valueset','Value Set', 'view');
AclExtended::updateAcl($emergency_nurse_write, 'Emergency nurse', 'fhir_api', 'FHIR API', 'relatedperson','Related Person', 'write');
AclExtended::updateAcl($emergency_nurse_write, 'Emergency nurse', 'fhir_api', 'FHIR API', 'documentreference','Document Reference', 'write');
AclExtended::updateAcl($emergency_nurse_write, 'Emergency nurse', 'fhir_api', 'FHIR API', 'questionnaire','Questionnaire', 'write');
AclExtended::updateAcl($emergency_nurse_write, 'Emergency nurse', 'fhir_api', 'FHIR API', 'questionnaireresponse','Questionnaire Response', 'write');
AclExtended::updateAcl($emergency_nurse_write, 'Emergency nurse', 'fhir_api', 'FHIR API', 'condition','Condition', 'write');
AclExtended::updateAcl($emergency_nurse_write, 'Emergency nurse', 'fhir_api', 'FHIR API', 'medicationstatement','Medication Statement Response', 'write');
AclExtended::updateAcl($emergency_nurse_write, 'Emergency nurse', 'fhir_api', 'FHIR API', 'observation','Observation', 'write');

//Emergency doctor ACL
// client app ACL
AclExtended::updateAcl($emergency_doctor_write, 'Emergency doctor', 'client_app', 'Client Application', 'PatientTrackingInvited','Patient Tracking Invited', 'write');
AclExtended::updateAcl($emergency_doctor_write, 'Emergency doctor', 'client_app', 'Client Application', 'PatientTrackingWaitingForExamination','Patient Tracking Waiting for Examination', 'write');
AclExtended::updateAcl($emergency_doctor_write, 'Emergency doctor', 'client_app', 'Client Application', 'PatientTrackingWaitingForDecoding','Patient Tracking Waiting for Decoding', 'write');
AclExtended::updateAcl($emergency_doctor_write, 'Emergency doctor', 'client_app', 'Client Application', 'PatientTrackingWaitingForRelease','Patient Tracking Waiting for Release', 'write');
AclExtended::updateAcl($emergency_doctor_write, 'Emergency doctor', 'client_app', 'Client Application', 'PatientTrackingFinished','Patient Tracking Finished', 'write');
AclExtended::updateAcl($emergency_doctor_view, 'Emergency doctor', 'client_app', 'Client Application', 'SearchPatient','Search Patient', 'view');
//AclExtended::updateAcl($emergency_doctor_write, 'Emergency doctor', 'client_app', 'Client Application', 'AddPatient','Add Patient', 'write');
//AclExtended::updateAcl($emergency_doctor_write, 'Emergency doctor', 'client_app', 'Client Application', 'PatientAdmission','Patient Admission', 'write');
AclExtended::updateAcl($emergency_doctor_view, 'Emergency doctor', 'client_app', 'Client Application', 'AppointmentsAndEncounters','Appointments And Encounters', 'view');
AclExtended::updateAcl($emergency_doctor_view, 'Emergency doctor', 'client_app', 'Client Application', 'EncounterSheet','Encounter Sheet', 'view');

AclExtended::updateAcl($emergency_doctor_write, 'Emergency doctor', 'client_app', 'Client Application', 'MedicalAdmissionForm','Medical Admission Form', 'write');
AclExtended::updateAcl($emergency_doctor_write, 'Emergency doctor', 'client_app', 'Client Application', 'TestsandTreatmentsForm','Tests and Treatments Form', 'write');
AclExtended::updateAcl($emergency_doctor_write, 'Emergency doctor', 'client_app', 'Client Application', 'DiagnosisandRecommendationsForm','Diagnosis and Recommendations Form', 'write');
AclExtended::updateAcl($emergency_doctor_view, 'Emergency doctor', 'client_app', 'Client Application', 'SummaryLetter','Summary Letter', 'view');
AclExtended::updateAcl($emergency_doctor_view, 'Emergency doctor', 'client_app', 'Client Application', 'EncountersReport','Encounters Report', 'view');
AclExtended::updateAcl($emergency_doctor_write, 'Emergency doctor', 'client_app', 'Client Application', 'UnidentifiedPatient','Unidentified Patient', 'write');
// FHIR ACL
AclExtended::updateAcl($emergency_doctor_write, 'Emergency doctor', 'fhir_api', 'FHIR API', 'patient','Patient', 'write');
AclExtended::updateAcl($emergency_doctor_view, 'Emergency doctor', 'fhir_api', 'FHIR API', 'appointment','Appointment', 'view');
AclExtended::updateAcl($emergency_doctor_write, 'Emergency doctor', 'fhir_api', 'FHIR API', 'encounter','Encounter', 'write');
AclExtended::updateAcl($emergency_doctor_view, 'Emergency doctor', 'fhir_api', 'FHIR API', 'practitioner','Practitioner', 'view');
AclExtended::updateAcl($emergency_doctor_view, 'Emergency doctor', 'fhir_api', 'FHIR API', 'organization','Organization', 'view');
AclExtended::updateAcl($emergency_doctor_view, 'Emergency doctor', 'fhir_api', 'FHIR API', 'healthcareservice','Healthcareb Service', 'view');
AclExtended::updateAcl($emergency_doctor_view, 'Emergency doctor', 'fhir_api', 'FHIR API', 'valueset','Value Set', 'view');
AclExtended::updateAcl($emergency_doctor_write, 'Emergency doctor', 'fhir_api', 'FHIR API', 'relatedperson','Related Person', 'write');
AclExtended::updateAcl($emergency_doctor_write, 'Emergency doctor', 'fhir_api', 'FHIR API', 'documentreference','Document Reference', 'write');
AclExtended::updateAcl($emergency_doctor_write, 'Emergency doctor', 'fhir_api', 'FHIR API', 'questionnaire','Questionnaire', 'write');
AclExtended::updateAcl($emergency_doctor_write, 'Emergency doctor', 'fhir_api', 'FHIR API', 'questionnaireresponse','Questionnaire Response', 'write');
AclExtended::updateAcl($emergency_doctor_write, 'Emergency doctor', 'fhir_api', 'FHIR API', 'condition','Condition', 'write');
AclExtended::updateAcl($emergency_doctor_write, 'Emergency doctor', 'fhir_api', 'FHIR API', 'medicationstatement','Medication Statement Response', 'write');
AclExtended::updateAcl($emergency_doctor_write, 'Emergency doctor', 'fhir_api', 'FHIR API', 'observation','Observation', 'write');



?>
<html>
<head>
    <title>Imaging ACL Setup</title>
    <link rel=STYLESHEET href="interface/themes/style_blue.css">
</head>
<body>
<b>OpenEMR EmergencyMedicine ACL Setup</b>
<br>
All done configuring and installing access controls (php-GACL)!
</body>
</html>
