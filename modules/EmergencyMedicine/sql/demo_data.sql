


--
-- Dumping data for table `facility`



REPLACE INTO `facility` (`id`, `name`, `phone`, `fax`, `street`, `city`, `state`, `postal_code`, `country_code`, `federal_ein`, `website`, `email`, `service_location`, `billing_location`, `accepts_assignment`, `pos_code`, `x12_sender_id`, `attn`, `domain_identifier`, `facility_npi`, `tax_id_type`, `color`, `primary_business_entity`, `facility_code`, `extra_validation`, `facility_taxonomy`, `mail_street`, `mail_street2`, `mail_city`, `mail_state`, `mail_zip`, `oid`, `iban`, `info`, `active`)
VALUES
('5', 'כללית', NULL, NULL, NULL, NULL, NULL, NULL, '', NULL, NULL, NULL, '0', '1', '0', '71', NULL, NULL, NULL, NULL, '', '#91AFFF', '0', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '', NULL, NULL, '1'),
('6', 'לאומית', NULL, NULL, NULL, NULL, NULL, NULL, '', NULL, NULL, NULL, '0', '1', '0', '71', NULL, NULL, NULL, NULL, '', '#92AFFF', '0', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '', NULL, NULL, '1'),
('7', 'מאוחדת', NULL, NULL, NULL, NULL, NULL, NULL, '', NULL, NULL, NULL, '0', '1', '0', '71', NULL, NULL, NULL, NULL, '', '#93AFFF', '0', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '', NULL, NULL, '1'),
('8', 'מכבי', NULL, NULL, NULL, NULL, NULL, NULL, '', NULL, NULL, NULL, '0', '1', '0', '71', NULL, NULL, NULL, NULL, '', '#94AFFF', '0', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '', NULL, NULL, '1');

REPLACE INTO `facility` (`id`, `name`, `phone`, `fax`, `street`, `city`, `state`, `postal_code`, `country_code`, `federal_ein`, `website`, `email`, `service_location`, `billing_location`, `accepts_assignment`, `pos_code`, `x12_sender_id`, `attn`, `domain_identifier`, `facility_npi`, `tax_id_type`, `color`, `primary_business_entity`, `facility_code`, `extra_validation`, `facility_taxonomy`, `mail_street`, `mail_street2`, `mail_city`, `mail_state`, `mail_zip`, `oid`, `iban`, `info`, `active`)
VALUES
('15', 'מרפאת תל אביב', NULL, NULL, NULL, NULL, NULL, NULL, '', NULL, NULL, NULL, '1', '1', '0', '11', NULL, NULL, NULL, NULL, '', '#95AFFF', '0', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '', NULL, NULL, '1'),
('16', 'מרפאת חיפה', NULL, NULL, NULL, NULL, NULL, NULL, '', NULL, NULL, NULL, '1', '1', '0', '11', NULL, NULL, NULL, NULL, '', '#96AFFF', '0', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '', NULL, NULL, '1');

INSERT INTO `facility` (`id`, `name`, `phone`, `fax`, `street`, `city`, `state`, `postal_code`, `country_code`, `federal_ein`, `website`, `email`, `service_location`, `billing_location`, `accepts_assignment`, `pos_code`, `x12_sender_id`, `attn`, `domain_identifier`, `facility_npi`, `tax_id_type`, `color`, `primary_business_entity`, `facility_code`, `extra_validation`, `facility_taxonomy`, `mail_street`, `mail_street2`, `mail_city`, `mail_state`, `mail_zip`, `oid`, `iban`, `info`, `active`) VALUES
(17, 'מרפאת מטריקס', '099599989', '099591234', 'החרש', 'הוד השרון', '4', '5232568', 'ישראל', '', 'matrix.co.il', 'matrix@co.il', 0, 1, 0, 1, NULL, '', '', '3', 'EI', '#33CC99', 0, '1', 1, '', '', '', '', '', '', '', '', '', 1);

--
-- Dumping data for table `fhir_healthcare_services`

INSERT INTO `fhir_healthcare_services` (`id`, `active`, `providedBy`, `category`, `type`, `name`, `comment`, `extraDetails`, `availableTime`, `notAvailable`, `availabilityExceptions`) VALUES
(1, 1, 3, 30, 1, 'מוקד תל אביב', NULL, NULL, NULL, NULL, NULL);


UPDATE `fhir_healthcare_services` SET `providedBy` = '15' WHERE `fhir_healthcare_services`.`providedBy` = 3;
UPDATE `fhir_healthcare_services` SET `providedBy` = '16' WHERE `fhir_healthcare_services`.`id` = 4;
UPDATE `fhir_healthcare_services` SET `providedBy` = '17' WHERE `fhir_healthcare_services`.`id` = 5;

--  IN THE TEST DEV - UNTIL HERE!!!

-- for the fields that use templets in the test installation. can be changed in every clinic.
INSERT INTO `list_options` (`list_id`, `option_id`, `title`, `seq`, `activity`, `notes`) VALUES
('clinikal_form_fields_templates', 'nursing_anamnesis', 'Nursing anamnesis', 10, 1, 'medical_admission'),
('clinikal_form_fields_templates', 'templates_x_ray', 'Instructions for x-ray', 10, 1, 'tests_and_treatments'),
('clinikal_form_fields_templates', 'templates_providing_medicine', 'Instructions for providing medicine', 10, 1, 'tests_and_treatments'),
('clinikal_form_fields_templates', 'templates_dehydration', 'Instructions for EKG', 10, 1, 'tests_and_treatments'),
('clinikal_form_fields_templates', 'templates_inhalation', 'Instructions for inhalation', 10, 1, 'tests_and_treatments'),
('clinikal_form_fields_templates', 'templates_laboratory_tests', 'Instructions for laboratory tests', 10, 1, 'tests_and_treatments'),
('clinikal_form_fields_templates', 'templates_bandage', 'Instructions for bandage', 10, 1, 'tests_and_treatment'),
('clinikal_form_fields_templates', 'templates_taking_metrics', 'Instructions for taking metrics', 10, 1, 'tests_and_treatments'),
('clinikal_form_fields_templates', 'templates_fluid_infusion', 'Instructions for fluid infusion', 10, 1, 'tests_and_treatments'),
('clinikal_form_fields_templates', 'findings_details', 'Findings details', 10, 1, 'diagnosis_and_recommendations'),
('clinikal_form_fields_templates', 'diagnosis_details', 'Diagnosis details', 10, 1, 'diagnosis_and_recommendations'),
('clinikal_form_fields_templates', 'treatment_details', 'Treatment details', 10, 1, 'diagnosis_and_recommendations'),
('clinikal_form_fields_templates', 'instructions_further_treatment', 'Instructions further treatment', 10, 1, 'diagnosis_and_recommendations'),
('clinikal_form_fields_templates', 'instructions_drug', 'Instructions drug', 10, 1, 'diagnosis_and_recommendations');

