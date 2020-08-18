--
--  Comment Meta Language Constructs:
--
--  #IfNotTable
--    argument: table_name
--    behavior: if the table_name does not exist,  the block will be executed

--  #IfTable
--    argument: table_name
--    behavior: if the table_name does exist, the block will be executed

--  #IfColumn
--    arguments: table_name colname
--    behavior:  if the table and column exist,  the block will be executed

--  #IfMissingColumn
--    arguments: table_name colname
--    behavior:  if the table exists but the column does not,  the block will be executed

--  #IfNotColumnType
--    arguments: table_name colname value
--    behavior:  If the table table_name does not have a column colname with a data type equal to value, then the block will be executed

--  #IfNotRow
--    arguments: table_name colname value
--    behavior:  If the table table_name does not have a row where colname = value, the block will be executed.

--  #IfNotRow2D
--    arguments: table_name colname value colname2 value2
--    behavior:  If the table table_name does not have a row where colname = value AND colname2 = value2, the block will be executed.

--  #IfNotRow3D
--    arguments: table_name colname value colname2 value2 colname3 value3
--    behavior:  If the table table_name does not have a row where colname = value AND colname2 = value2 AND colname3 = value3, the block will be executed.

--  #IfNotRow4D
--    arguments: table_name colname value colname2 value2 colname3 value3 colname4 value4
--    behavior:  If the table table_name does not have a row where colname = value AND colname2 = value2 AND colname3 = value3 AND colname4 = value4, the block will be executed.

--  #IfNotRow2Dx2
--    desc:      This is a very specialized function to allow adding items to the list_options table to avoid both redundant option_id and title in each element.
--    arguments: table_name colname value colname2 value2 colname3 value3
--    behavior:  The block will be executed if both statements below are true:
--               1) The table table_name does not have a row where colname = value AND colname2 = value2.
--               2) The table table_name does not have a row where colname = value AND colname3 = value3.

--  #IfRow2D
--    arguments: table_name colname value colname2 value2
--    behavior:  If the table table_name does have a row where colname = value AND colname2 = value2, the block will be executed.

--  #IfRow3D
--        arguments: table_name colname value colname2 value2 colname3 value3
--        behavior:  If the table table_name does have a row where colname = value AND colname2 = value2 AND colname3 = value3, the block will be executed.

--  #IfIndex
--    desc:      This function is most often used for dropping of indexes/keys.
--    arguments: table_name colname
--    behavior:  If the table and index exist the relevant statements are executed, otherwise not.

--  #IfNotIndex
--    desc:      This function will allow adding of indexes/keys.
--    arguments: table_name colname
--    behavior:  If the index does not exist, it will be created

--  #EndIf
--    all blocks are terminated with a #EndIf statement.

--  #IfNotListReaction
--    Custom function for creating Reaction List

--  #IfNotListOccupation
--    Custom function for creating Occupation List

--  #IfTextNullFixNeeded
--    desc: convert all text fields without default null to have default null.
--    arguments: none

--  #IfTableEngine
--    desc:      Execute SQL if the table has been created with given engine specified.
--    arguments: table_name engine
--    behavior:  Use when engine conversion requires more than one ALTER TABLE

--  #IfInnoDBMigrationNeeded
--    desc: find all MyISAM tables and convert them to InnoDB.
--    arguments: none
--    behavior: can take a long time.

--  #IfTranslationNeeded
--    desc: find all MyISAM tables and convert them to InnoDB.
--    arguments: constant_name english hebrew
--    behavior: can take a long time.

-- setting for Isreali emergency medicine clinics
REPLACE INTO `globals` (`gl_name`, `gl_index`, `gl_value`) VALUES ('date_display_format', '0', '2'),('language_default', '0', 'Hebrew');

-- setting for client side app
REPLACE INTO `globals` (`gl_name`, `gl_index`, `gl_value`) VALUES
('clinikal_react_vertical', 0, 'emergency');

REPLACE INTO `globals` (`gl_name`, `gl_index`, `gl_value`) VALUES
('clinikal_hide_appoitments', 0, '1');

REPLACE INTO `globals` (`gl_name`, `gl_index`, `gl_value`) VALUES
('clinikal_pa_commitment_form', 0, '0');

REPLACE INTO `globals` (`gl_name`, `gl_index`, `gl_value`) VALUES
('clinikal_pa_arrival_way', 0, '1');

REPLACE INTO `globals` (`gl_name`, `gl_index`, `gl_value`) VALUES
('clinikal_pa_next_enc_status', 0, 'arrived');




#IfNotRow fhir_value_sets id identifier_type_list
INSERT INTO fhir_value_sets (id, title, status) VALUES
('identifier_type_list', 'Identifier Type List', 'active');
#EndIf

#IfNotRow fhir_value_set_systems vs_id identifier_type_list
INSERT INTO `fhir_value_set_systems` (`vs_id`, `system`, `type`, `filter`)
VALUES
('identifier_type_list', 'userlist3', 'All', NULL);
#EndIf


#IfNotRow fhir_value_sets id gender
INSERT INTO fhir_value_sets (id, title, status) VALUES
('gender', 'Gender', 'active');
#EndIf


#IfNotRow fhir_value_set_systems vs_id gender
-- replace LAST_INSERT_ID()
DELETE FROM `fhir_value_set_systems` WHERE `fhir_value_set_systems`.`vs_id` = "gender";
DELETE FROM `fhir_value_set_codes` WHERE `fhir_value_set_codes`.`code` IN('other','male','female');

INSERT INTO `fhir_value_set_systems` (`vs_id`, `system`, `type`, `filter`)
VALUES
('gender', 'sex', 'Partial', NULL);

INSERT INTO `fhir_value_set_codes` (`vss_id`, `code`) VALUES
((SELECT id FROM fhir_value_set_systems WHERE vs_id = 'gender' AND type = 'Partial'), 'female'),
((SELECT id FROM fhir_value_set_systems WHERE vs_id = 'gender' AND type = 'Partial'), 'male'),
((SELECT id FROM fhir_value_set_systems WHERE vs_id = 'gender' AND type = 'Partial'), 'other');

#EndIf

-- default FHIR statuses for non-block development
#IfNotRow2D list_options list_id clinikal_enc_statuses option_id planned
DELETE FROM `list_options` WHERE `list_id` = 'clinikal_enc_statuses';
INSERT INTO `list_options` (`list_id`, `option_id`, `title`, `seq`, `is_default`, `option_value`, `mapping`, `notes`, `codes`, `toggle_setting_1`, `toggle_setting_2`, `activity`, `subtype`, `edit_options`) VALUES
('clinikal_enc_statuses', 'planned', 'Planned', 10, 0, 0, '', '', '', 0, 0, 1, '', 1),
('clinikal_enc_statuses', 'arrived', 'Admitted', 20, 0, 0, '', '', '', 0, 0, 1, '', 1),
('clinikal_enc_statuses', 'triaged', 'Triaged', 30, 0, 0, '', '', '', 0, 0, 1, '', 1),
('clinikal_enc_statuses', 'in-progress', 'In Progress', 40, 0, 0, '', '', '', 0, 0, 1, '', 1),
('clinikal_enc_statuses', 'finished', 'Finished', 60, 0, 0, '', '', '', 0, 0, 1, '', 1),
('clinikal_enc_statuses', 'cancelled', 'Cancelled', 15, 0, 0, '', '', '', 0, 0, 1, '', 1);
#EndIf


#IfNotRow fhir_value_sets id encounter_statuses
INSERT INTO `fhir_value_sets` (`id`, `title`) VALUES
 ('encounter_statuses', 'Encounter Statuses');
#EndIf

#IfNotRow2D fhir_value_set_systems vs_id encounter_statuses system clinikal_enc_statuses
INSERT INTO `fhir_value_set_systems` (`vs_id`, `system`, `type`) VALUES
('encounter_statuses', 'clinikal_enc_statuses', 'All');
#EndIf

#IfNotRow2D list_options list_id lists option_id clinikal_app_statuses
INSERT INTO `list_options` (`list_id`, `option_id`, `title`, `seq`, `is_default`, `option_value`, `mapping`, `notes`, `codes`, `toggle_setting_1`, `toggle_setting_2`, `activity`, `subtype`, `edit_options`) VALUES
('lists', 'clinikal_app_statuses', 'Clinikal Appointment Statuses', 0, 0, 0, '', '', '', 0, 0, 1, '', 1),
('clinikal_app_statuses', '1', 'Pending', 10, 0, 0, '', '', '', 0, 0, 1, '', 1),
('clinikal_app_statuses', '2', 'Booked', 20, 0, 0, '', '', '', 0, 0, 1, '', 1),
('clinikal_app_statuses', '3', 'Arrived', 30, 0, 0, '', '', '', 0, 0, 1, '', 1),
('clinikal_app_statuses', '4', 'Cancelled', 40, 0, 0, '', '', '', 0, 0, 1, '', 1),
('clinikal_app_statuses', '5', 'No Show', 50, 0, 0, '', '', '', 0, 0, 1, '', 1),
('clinikal_app_statuses', '6', 'Waitlisted', 60, 0, 0, '', '', '', 0, 0, 1, '', 1);
#EndIf

#IfNotRow fhir_value_sets id appointment_statuses
INSERT INTO `fhir_value_sets` (`id`, `title`) VALUES
('appointment_statuses', 'Appointment Statuses');
#EndI

#IfNotRow2D fhir_value_set_systems vs_id appointment_statuses system clinikal_app_statuses
INSERT INTO `fhir_value_set_systems` (`vs_id`, `system`, `type`) VALUES
('appointment_statuses', 'clinikal_app_statuses', 'All');
#EndIf

#IfNotRow2D list_options list_id lists option_id clinikal_service_types
INSERT INTO `list_options` (`list_id`, `option_id`, `title`, `seq`, `is_default`, `option_value`, `mapping`, `notes`, `codes`, `toggle_setting_1`, `toggle_setting_2`, `activity`, `subtype`, `edit_options`) VALUES
('lists', 'clinikal_service_types', 'Clinikal Service Types', 0, 0, 0, '', '', '', 0, 0, 1, '', 1),
('clinikal_service_types', '1', 'Emergency Medicine', 10, 0, 0, '', '', '', 0, 0, 1, '', 1);
#EndIf

#IfNotRow fhir_value_sets id service_types
INSERT INTO `fhir_value_sets` (`id`, `title`) VALUES
('service_types', 'Service Types');
#EndIf

#IfNotRow2D fhir_value_set_systems vs_id service_types system clinikal_service_types
INSERT INTO `fhir_value_set_systems` (`vs_id`, `system`, `type`) VALUES
('service_types', 'clinikal_service_types', 'All');
#EndIf

#IfNotRow2D list_options list_id clinikal_reason_codes option_id 7

DELETE FROM `list_options` WHERE list_id='clinikal_reason_codes' OR option_id="clinikal_reason_codes";

INSERT INTO `list_options` (`list_id`, `option_id`, `title`, `seq`, `activity`,`notes`) VALUES
('lists', 'clinikal_reason_codes', 'Clinikal Reason Codes', 0, 1,'1'),
('clinikal_reason_codes', '1', 'Dehydration', 10, 1,'1'),
('clinikal_reason_codes', '2', 'Orthopedic sabotage', 20, 1,'1'),
('clinikal_reason_codes', '3', 'head injury', 30, 1,'1'),
('clinikal_reason_codes', '4', 'Foreign body penetration', 40, 1,'1'),
('clinikal_reason_codes', '5', 'high temperature', 50, 1,'1'),
('clinikal_reason_codes', '6', 'cut', 60, 1,'1'),
('clinikal_reason_codes', '7', 'Pain', 70, 1,'1'),
('clinikal_reason_codes', '8', 'Chest pain', 80, 1,'1'),
('clinikal_reason_codes', '9', 'Back pain', 90, 1,'1'),
('clinikal_reason_codes', '10', 'Headache', 100, 1,'1'),
('clinikal_reason_codes', '11', 'Rash', 110, 1,'1'),
('clinikal_reason_codes', '12', 'Shortness of breath', 120, 1,'1'),
('clinikal_reason_codes', '13', 'Diarrhea and vomiting', 130, 1,'1');
#EndIf

#IfNotTable form_medical_admission_questionnaire
CREATE TABLE form_medical_admission_questionnaire(
    id bigint(20) NOT NULL AUTO_INCREMENT,
    encounter varchar(255) DEFAULT NULL,
    form_id bigint(20) NOT NULL,
    question_id int(11) NOT NULL,
    answer text,
    PRIMARY KEY (`id`)
);
#EndIf

#IfNotRow fhir_questionnaire directory medical_admission_questionnaire
INSERT INTO `fhir_questionnaire` (`name`, `directory`, `state`, `aco_spec`) VALUES
('Medical admission questionnaire', 'medical_admission_questionnaire', '1', 'encounters|notes');
#EndIf

#IfNotRow2D questionnaires_schemas form_name medical_admission_questionnaire question Pregnancy
INSERT INTO `questionnaires_schemas` (`qid`, `form_name`,`form_table`, `column_type`, `question`)
VALUES
('1', 'medical_admission_questionnaire','form_medical_admission_questionnaire', 'boolean', 'Insulation required'),
('2', 'medical_admission_questionnaire','form_medical_admission_questionnaire', 'string', 'Insulation instructions'),
('3', 'medical_admission_questionnaire','form_medical_admission_questionnaire', 'string', 'Nursing anamnesis'),
('4', 'medical_admission_questionnaire','form_medical_admission_questionnaire', 'boolean', 'Pregnancy');
#EndIf


#IfNotRow2D registry directory medical_admission component_name MedicalAdmission
REPLACE INTO `registry` (`name`, `state`, `directory`, `sql_run`, `unpackaged`, `date`, `priority`, `category`, `nickname`, `patient_encounter`, `therapy_group_encounter`, `aco_spec`,`component_name`)
VALUES
('Medical Admission', 1, 'medical_admission', 1, 1, '2020-03-14 00:00:00', 1, 'React form', '', 0, 0, 'client_app|MedicalAdmissionForm','MedicalAdmission');

REPLACE INTO `form_context_map` (`form_id`, `context_type`, `context_id`)
SELECT id,'service_type','1' FROM registry WHERE directory = 'medical_admission';
#EndIf

#IfNotRow2D registry directory tests_and_treatments component_name TestsAndTreatments
REPLACE INTO `registry` (`name`, `state`, `directory`, `sql_run`, `unpackaged`, `date`, `priority`, `category`, `nickname`, `patient_encounter`, `therapy_group_encounter`, `aco_spec`,`component_name`)
VALUES
('Tests and Treatments', 1, 'tests_and_treatments', 1, 1, '2020-03-14 00:00:00', 2, 'React form', '', 0, 0, 'client_app|TestsAndTreatmentsForm','TestsAndTreatments');

REPLACE INTO `form_context_map` (`form_id`, `context_type`, `context_id`)
SELECT id,'service_type','1' FROM registry WHERE directory = 'tests_and_treatments';
#EndIf``

#IfNotRow2D registry directory diagnosis_and_recommendations component_name DiagnosisAndRecommendations
REPLACE INTO `registry` (`name`, `state`, `directory`, `sql_run`, `unpackaged`, `date`, `priority`, `category`, `nickname`, `patient_encounter`, `therapy_group_encounter`, `aco_spec`,`component_name`)
VALUES
('Diagnosis and Recommendations', 1, 'diagnosis_and_recommendations', 1, 1, '2020-03-14 00:00:00', 3, 'React form', '', 0, 0, 'client_app|DiagnosisAndRecommendationsForm','DiagnosisAndRecommendations');

REPLACE INTO `form_context_map` (`form_id`, `context_type`, `context_id`)
SELECT id,'service_type','1' FROM registry WHERE directory = 'diagnosis_and_recommendations';
#EndIf

#IfNotRow fhir_value_sets id reason_codes_1
INSERT INTO `fhir_value_sets` (`id`, `title`)
VALUES ('reason_codes_1', 'Emergency Medicine Reason Codes');
#EndIf

#IfNotRow3D fhir_value_set_systems vs_id reason_codes_1 system clinikal_reason_codes type Filter
INSERT INTO `fhir_value_set_systems` (`vs_id`, `system`, `type`,`filter`)
VALUES ('reason_codes_1', 'clinikal_reason_codes', 'Filter', '1');
#EndIf

ALTER TABLE `fhir_value_set_systems` MODIFY COLUMN `type` ENUM('All', 'Partial', 'Exclude', 'Filter', 'Codes') NOT NULL AFTER `system`;

#IfNotRow fhir_value_sets id sensitivities
INSERT INTO `fhir_value_sets` (`id`, `title`)
VALUES ('sensitivities', 'Sensitivities');
#EndIf

#IfNotRow3D fhir_value_set_systems vs_id sensitivities system 9920 type Codes
INSERT INTO `fhir_value_set_systems` (`vs_id`, `system`, `type`,`filter`)
VALUES ('sensitivities', '9920', 'Codes', NULL);
#EndIf

#IfNotRow fhir_value_sets id bk_diseases
INSERT INTO `fhir_value_sets` (`id`, `title`)
VALUES ('bk_diseases', 'BK Diseases');
#EndIf

#IfNotRow3D fhir_value_set_systems vs_id bk_diseases system 9921 type Codes
INSERT INTO `fhir_value_set_systems` (`vs_id`, `system`, `type`,`filter`)
VALUES ('bk_diseases', '9921', 'Codes', NULL);
#EndIf

#IfNotRow fhir_value_sets id tests_and_treatments
INSERT INTO `fhir_value_sets` (`id`, `title`)
VALUES ('tests_and_treatments', 'Tests And Treatments');
#EndIf

#IfNotRow3D fhir_value_set_systems vs_id tests_and_treatments system tests_and_treatments type All
INSERT INTO `fhir_value_set_systems` (`vs_id`, `system`, `type`,`filter`)
VALUES ('tests_and_treatments', 'tests_and_treatments', 'All', NULL);
#EndIf


#IfRow2D fhir_value_sets id x_ray_types title Xray Types
DELETE FROM fhir_value_sets WHERE id ="x_ray_types";
#EndIf

#IfRow3D fhir_value_set_systems vs_id x_ray_types system x_ray_types type All
DELETE FROM fhir_value_set_systems WHERE vs_id ="x_ray_types";
#EndIf

#IfNotRow fhir_value_sets id details_x_ray
INSERT INTO `fhir_value_sets` (`id`, `title`)
VALUES ('details_x_ray', 'Xray Type');
#EndIf

#IfNotRow3D fhir_value_set_systems vs_id details_x_ray system x_ray_types type All
INSERT INTO `fhir_value_set_systems` (`vs_id`, `system`, `type`,`filter`)
VALUES ('details_x_ray', 'x_ray_types', 'All', NULL);
#EndIf


#IfNotRow2D list_options list_id lists option_id x_ray_types
INSERT INTO `list_options` (`list_id`, `option_id`, `title`, `seq`, `activity`,`notes`) VALUES
('lists', 'x_ray_types', 'X-Ray Types', 0, 1,''),
('x_ray_types', 'dehydration', 'Chest', 10, 1,''),
('x_ray_types', 'inhalation', 'Palm', 20, 1,''),
('x_ray_types', 'laboratory_tests', 'sole', 30, 1,''),
('x_ray_types', 'bandage', 'Shoulder', 40, 1,''),
('x_ray_types', 'taking_metrics', 'Neck', 50, 1,''),
('x_ray_types', 'fluid_infusion', 'Ankle', 60, 1,'');
#EndIf


#IfNotRow2D list_options list_id lists option_id tests_and_treatments
INSERT INTO `list_options` (`list_id`, `option_id`, `title`, `seq`, `activity`,`notes`) VALUES
('lists', 'tests_and_treatments', 'Tests and Treatments', 0, 1,''),
('tests_and_treatments', 'dehydration', 'EGK', 10, 1,''),
('tests_and_treatments', 'inhalation', 'Inhalation', 20, 1,''),
('tests_and_treatments', 'laboratory_tests', 'Laboratory tests', 30, 1,''),
('tests_and_treatments', 'bandage', 'Bandage', 40, 1,''),
('tests_and_treatments', 'taking_metrics', 'Taking metrics', 50, 1,''),
('tests_and_treatments', 'fluid_infusion', 'Fluid infusion', 60, 1,''),
('tests_and_treatments', 'providing_medicine', 'Providing medicine', 70, 1,''),
('tests_and_treatments', 'x_ray', 'X-Ray', 80, 1,'');
#EndIf


#IfNotRow2D list_options list_id clinikal_enc_secondary_statuses option_id waiting_for_nurse
INSERT INTO `list_options` (`list_id`, `option_id`, `title`, `seq`, `is_default`, `option_value`, `mapping`, `notes`, `codes`, `toggle_setting_1`, `toggle_setting_2`, `activity`, `subtype`, `edit_options`)
VALUES
('clinikal_enc_secondary_statuses', 'waiting_for_nurse', 'Waiting for Nurse', 10, 0, 0, '', 'In Progress ', '', 0, 0, 1, '', 1),
('clinikal_enc_secondary_statuses', 'waiting_for_doctor', 'Waiting for Doctor', 20, 0, 0, '', 'In Progress ', '', 0, 0, 1, '', 1),
('clinikal_enc_secondary_statuses', 'waiting_for_xray', 'Waiting for X-ray', 30, 0, 0, '', 'In Progress ', '', 0, 0, 1, '', 1),
('clinikal_enc_secondary_statuses', 'waiting_for_release', 'Waiting for Release', 40, 0, 0, '', 'In Progress ', '', 0, 0, 1, '', 1);
#EndIf


#IfNotTable form_diagnosis_and_recommendations_questionnaire
CREATE TABLE form_diagnosis_and_recommendations_questionnaire(
    id bigint(20) NOT NULL AUTO_INCREMENT,
    encounter varchar(255) DEFAULT NULL,
    form_id bigint(20) NOT NULL,
    question_id int(11) NOT NULL,
    answer text,
    PRIMARY KEY (`id`)
);
#EndIf

#IfNotRow fhir_questionnaire directory form_diagnosis_and_recommendations_questionnaire
INSERT INTO `fhir_questionnaire` (`name`, `directory`, `state`, `aco_spec`) VALUES
('Diagnosis and recommendations questionnaire', 'diagnosis_and_recommendations_questionnaire', '1', 'encounters|notes');
#EndIf

#IfNotRow2D questionnaires_schemas form_name diagnosis_and_recommendations_questionnaire question Decision
INSERT INTO `questionnaires_schemas` (`qid`, `form_name`,`form_table`, `column_type`, `question`)
VALUES
('1', 'diagnosis_and_recommendations_questionnaire','form_diagnosis_and_recommendations_questionnaire', 'string', 'Findings details'),
('2', 'diagnosis_and_recommendations_questionnaire','form_diagnosis_and_recommendations_questionnaire', 'string', 'Diagnosis details'),
('3', 'diagnosis_and_recommendations_questionnaire','form_diagnosis_and_recommendations_questionnaire', 'string', 'Treatment details'),
('4', 'diagnosis_and_recommendations_questionnaire','form_diagnosis_and_recommendations_questionnaire', 'string', 'Instructions for further treatment'),
('5', 'diagnosis_and_recommendations_questionnaire','form_diagnosis_and_recommendations_questionnaire', 'string', 'Decision'),
('6', 'diagnosis_and_recommendations_questionnaire','form_diagnosis_and_recommendations_questionnaire', 'string', 'Evacuation way'),
('7', 'diagnosis_and_recommendations_questionnaire','form_diagnosis_and_recommendations_questionnaire', 'integer', 'Sick leave');
#EndIf

#IfNotRow fhir_value_sets id encounter_secondary_statuses
INSERT INTO `fhir_value_sets` (`id`, `title`)
VALUES ('encounter_secondary_statuses', 'Encounter Secondary Statuses');
#EndIf

#IfNotRow3D fhir_value_set_systems vs_id encounter_secondary_statuses system clinikal_enc_secondary_statuses type All
INSERT INTO `fhir_value_set_systems` (`vs_id`, `system`, `type`,`filter`)
VALUES ('encounter_secondary_statuses', 'clinikal_enc_secondary_statuses', 'All', NULL);
#EndIf

#IfNotRow fhir_value_sets id waiting_for_xray_statuses
INSERT INTO `fhir_value_sets` (`id`, `title`)
VALUES ('waiting_for_xray_statuses', 'Waiting For Xray Statuses');
#EndIf

#IfNotRow3D fhir_value_set_systems vs_id waiting_for_xray_statuses system clinikal_enc_secondary_statuses type Partial
INSERT INTO `fhir_value_set_systems` (`vs_id`, `system`, `type`,`filter`)
VALUES ('waiting_for_xray_statuses', 'clinikal_enc_secondary_statuses', 'Partial', NULL);

INSERT INTO `fhir_value_set_codes` (`vss_id`, `code`) VALUES
((SELECT id FROM fhir_value_set_systems WHERE vs_id = 'waiting_for_xray_statuses' AND system = 'clinikal_enc_secondary_statuses' AND type = 'Partial'), 'waiting_for_nurse'),
((SELECT id FROM fhir_value_set_systems WHERE vs_id = 'waiting_for_xray_statuses' AND system = 'clinikal_enc_secondary_statuses' AND type = 'Partial'), 'waiting_for_doctor'),
((SELECT id FROM fhir_value_set_systems WHERE vs_id = 'waiting_for_xray_statuses' AND system = 'clinikal_enc_secondary_statuses' AND type = 'Partial'), 'waiting_for_xray');
#EndIf

#IfNotRow fhir_value_sets id waiting_for_release_statuses
INSERT INTO `fhir_value_sets` (`id`, `title`)
VALUES ('waiting_for_release_statuses', 'Waiting For Release Statuses');
#EndIf

#IfNotRow3D fhir_value_set_systems vs_id waiting_for_release_statuses system clinikal_enc_secondary_statuses type Partial
INSERT INTO `fhir_value_set_systems` (`vs_id`, `system`, `type`,`filter`)
VALUES ('waiting_for_release_statuses', 'clinikal_enc_secondary_statuses', 'Partial', NULL);

INSERT INTO `fhir_value_set_codes` (`vss_id`, `code`) VALUES
((SELECT id FROM fhir_value_set_systems WHERE vs_id = 'waiting_for_release_statuses' AND system = 'clinikal_enc_secondary_statuses' AND type = 'Partial'), 'waiting_for_release');
#EndIf

#IfNotRow3D fhir_value_set_systems vs_id waiting_for_release_statuses system clinikal_enc_statuses type Partial
INSERT INTO `fhir_value_set_systems` (`vs_id`, `system`, `type`,`filter`)
VALUES ('waiting_for_release_statuses', 'clinikal_enc_statuses', 'Partial', NULL);

INSERT INTO `fhir_value_set_codes` (`vss_id`, `code`) VALUES
((SELECT id FROM fhir_value_set_systems WHERE vs_id = 'waiting_for_release_statuses' AND system = 'clinikal_enc_statuses' AND type = 'Partial'), 'finished');
#EndIf


#IfNotRow fhir_value_sets id details_providing_medicine
INSERT INTO `fhir_value_sets` (`id`, `title`)
VALUES ('details_providing_medicine', 'Drug name');
#EndIf


#IfNotRow fhir_value_set_systems vs_id details_providing_medicine
INSERT INTO `fhir_value_set_systems` (`vs_id`, `system`, `type`,`filter`)
VALUES ('details_providing_medicine', '9911', 'Codes', NULL);
#EndIf

#IfNotRow manage_templates_letters letter_name letter_x_ray
INSERT INTO `manage_templates_letters` (`id`, `letter_name`, `letter_class`, `letter_class_action`, `active`, `letter_post_json`) VALUES
(1, 'letter_x_ray', 'EmergencyMedicine\\Controller\\xrayLetterController', 'pdf', 1, '\n{"facility": "required","encounter": "required","owner": "optional","patient": "optional"}');
#EndIf

#IfNotRow2D code_types ct_key Sensitivities ct_id 9920
DELETE FROM `code_types` WHERE  ct_id="9920";
INSERT INTO `code_types` (`ct_key`, `ct_id`, `ct_seq`, `ct_mod`, `ct_just`, `ct_mask`, `ct_fee`, `ct_rel`, `ct_nofs`, `ct_diag`, `ct_active`, `ct_label`, `ct_external`, `ct_claim`, `ct_proc`, `ct_term`, `ct_problem`, `ct_drug`) VALUES
('Sensitivities', 9920, 9920, 12, 'Sensitivities', '', 1, 0, 1, 1, 1, 'Sensitivities', 0, 1, 0, 1, 0, 0);
#EndIf

#IfRow2D manage_templates_letters letter_name xray letter_class_action pdf
UPDATE manage_templates_letters SET letter_name = 'letter_x_ray' WHERE letter_name = 'xray';
#EndIf

#IfNotRow2D code_types ct_id 9921 ct_key BK Diseases
DELETE FROM `code_types` WHERE  ct_id="9921";
INSERT INTO `code_types` (`ct_key`, `ct_id`, `ct_seq`, `ct_mod`, `ct_just`, `ct_mask`, `ct_fee`, `ct_rel`, `ct_nofs`, `ct_diag`, `ct_active`, `ct_label`, `ct_external`, `ct_claim`, `ct_proc`, `ct_term`, `ct_problem`, `ct_drug`) VALUES
('BK Diseases', 9921, 9921, 12, 'BK Diseases', '', 1, 0, 1, 0, 1, 'Background Diseases', 0, 1, 0, 1, 1, 0);
#EndIf

