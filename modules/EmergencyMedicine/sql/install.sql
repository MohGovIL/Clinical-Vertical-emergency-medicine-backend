
-- GENERIC SQL NEED TO MOVE TO CLINIKALAPI MODULE
REPLACE INTO `facility` (`id`, `name`, `phone`, `fax`, `street`, `city`, `state`, `postal_code`, `country_code`, `federal_ein`, `website`, `email`, `service_location`, `billing_location`, `accepts_assignment`, `pos_code`, `x12_sender_id`, `attn`, `domain_identifier`, `facility_npi`, `tax_id_type`, `color`, `primary_business_entity`, `facility_code`, `extra_validation`, `facility_taxonomy`, `mail_street`, `mail_street2`, `mail_city`, `mail_state`, `mail_zip`, `oid`, `iban`, `info`, `active`)
VALUES
('5', 'כללית', NULL, NULL, NULL, NULL, NULL, NULL, '', NULL, NULL, NULL, '1', '0', '0', '71', NULL, NULL, NULL, NULL, '', '#91AFFF', '0', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '', NULL, NULL, '1'),
('6', 'מכבי', NULL, NULL, NULL, NULL, NULL, NULL, '', NULL, NULL, NULL, '1', '0', '0', '71', NULL, NULL, NULL, NULL, '', '#92AFFF', '0', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '', NULL, NULL, '1'),
('7', 'מאוחדת', NULL, NULL, NULL, NULL, NULL, NULL, '', NULL, NULL, NULL, '1', '0', '0', '71', NULL, NULL, NULL, NULL, '', '#93AFFF', '0', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '', NULL, NULL, '1'),
('8', 'לאומית', NULL, NULL, NULL, NULL, NULL, NULL, '', NULL, NULL, NULL, '1', '0', '0', '71', NULL, NULL, NULL, NULL, '', '#94AFFF', '0', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '', NULL, NULL, '1'),
('9', 'צה"ל', NULL, NULL, NULL, NULL, NULL, NULL, '', NULL, NULL, NULL, '1', '0', '0', '71', NULL, NULL, NULL, NULL, '', '#95AFFF', '0', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, '', NULL, NULL, '1');

UPDATE `list_options` SET `option_id` = '5' WHERE `list_options`.`list_id` = 'mh_ins_organizations' AND `list_options`.`option_id` = 'hmo_1';
UPDATE `list_options` SET `option_id` = '6' WHERE `list_options`.`list_id` = 'mh_ins_organizations' AND `list_options`.`option_id` = 'hmo_2';
UPDATE `list_options` SET `option_id` = '7' WHERE `list_options`.`list_id` = 'mh_ins_organizations' AND `list_options`.`option_id` = 'hmo_3';
UPDATE `list_options` SET `option_id` = '8' WHERE `list_options`.`list_id` = 'mh_ins_organizations' AND `list_options`.`option_id` = 'hmo_4';

INSERT INTO `list_options` (`list_id`, `option_id`, `title`, `seq`, `is_default`, `option_value`, `notes`,`activity`)
VALUES
('mh_ins_organizations', 'idf', 'IDF', '0', '0', '0','' ,'1');

ALTER TABLE facility AUTO_INCREMENT = 17;


INSERT INTO `questionnaires_schemas` (`qid`, `form_name`,`form_table`, `column_type`, `question`)
VALUES
('1', 'commitment_questionnaire','form_commitment_questionnaire', 'integer', 'Commitment number'),
('2', 'commitment_questionnaire','form_commitment_questionnaire', 'date', 'Commitment date'),
('3', 'commitment_questionnaire','form_commitment_questionnaire', 'date', 'Commitment expiration date'),
('4', 'commitment_questionnaire','form_commitment_questionnaire', 'string', 'Signing doctor'),
('5', 'commitment_questionnaire','form_commitment_questionnaire', 'integer', 'doctor license number'),
('6', 'commitment_questionnaire','form_commitment_questionnaire', 'string', 'Payment amount'),
('7', 'commitment_questionnaire','form_commitment_questionnaire', 'string', 'Payment method'),
('8', 'commitment_questionnaire','form_commitment_questionnaire', 'string', 'Receipt number');


INSERT INTO `registry` (`name`, `state`, `directory`, `sql_run`, `unpackaged`, `date`, `priority`, `category`, `nickname`, `patient_encounter`, `therapy_group_encounter`, `aco_spec`)
VALUES
('Commitment questionnaire', 1, 'commitment_questionnaire', 1, 1, '2020-03-14 00:00:00', 0, 'Clinical', '', 0, 0, 'encounters|notes');


-- --------------------------------------------------------

UPDATE `categories` SET `name` = 'HPatient Photograph', `lft` = '105', `rght` = '106' WHERE `id` = '4';
UPDATE `categories` SET `name` = 'EMedical Record', `lft` = '101', `rght` = '102' WHERE `id` = '2';
UPDATE `categories` SET `rght` = '271' WHERE `id` = '1';
UPDATE `categories` SET `name` = 'FLab Report', `lft` = '103', `rght` = '104' WHERE `id` = '3';

DELETE FROM `categories` WHERE `id` = '19';
DELETE FROM `categories` WHERE `id` = '22';
DELETE FROM `categories` WHERE `id` = '15';
DELETE FROM `categories` WHERE `id` = '14';
DELETE FROM `categories` WHERE `id` = '11';
DELETE FROM `categories` WHERE `id` = '21';
DELETE FROM `categories` WHERE `id` = '25';
DELETE FROM `categories` WHERE `id` = '20';
DELETE FROM `categories` WHERE `id` = '27';
DELETE FROM `categories` WHERE `id` = '6';
DELETE FROM `categories` WHERE `id` = '12';
DELETE FROM `categories` WHERE `id` = '24';
DELETE FROM `categories` WHERE `id` = '9';
DELETE FROM `categories` WHERE `id` = '10';
DELETE FROM `categories` WHERE `id` = '5';
DELETE FROM `categories` WHERE `id` = '8';
DELETE FROM `categories` WHERE `id` = '16';
DELETE FROM `categories` WHERE `id` = '17';
DELETE FROM `categories` WHERE `id` = '18';
DELETE FROM `categories` WHERE `id` = '13';
DELETE FROM `categories` WHERE `id` = '28';
DELETE FROM `categories` WHERE `id` = '7';
DELETE FROM `categories` WHERE `id` = '29';
DELETE FROM `categories` WHERE `id` = '26';
DELETE FROM `categories` WHERE `id` = '23';

DELETE FROM `categories_seq` WHERE `id` = '29';
INSERT INTO `categories_seq` (`id`) VALUES('9');


INSERT INTO `fhir_questionnaire` (`name`, `directory`, `state`, `aco_spec`) VALUES
('Commitment questionnaire', 'commitment_questionnaire', '1', 'encounters|notes');
