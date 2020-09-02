


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
