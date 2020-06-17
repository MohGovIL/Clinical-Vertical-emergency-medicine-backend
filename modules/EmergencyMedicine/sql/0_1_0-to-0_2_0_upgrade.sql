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
('clinikal_pa_next_enc_status', 0, 'waiting_for_triage');



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




#IfNotRow registry directory medical_admission
INSERT INTO `registry` (`name`, `state`, `directory`, `sql_run`, `unpackaged`, `date`, `priority`, `category`, `nickname`, `patient_encounter`, `therapy_group_encounter`, `aco_spec`)
VALUES
('Medical Admission', 1, 'medical_admission', 1, 1, '2020-03-14 00:00:00', 1, 'Clinical', '', 0, 0, 'client_app|MedicalAdmissionForm');
#EndIf

#IfNotRow registry directory tests_and_treatments
INSERT INTO `registry` (`name`, `state`, `directory`, `sql_run`, `unpackaged`, `date`, `priority`, `category`, `nickname`, `patient_encounter`, `therapy_group_encounter`, `aco_spec`)
VALUES
('Tests and Treatments', 1, 'tests_and_treatments', 1, 1, '2020-03-14 00:00:00', 2, 'Clinical', '', 0, 0, 'client_app|TestsandTreatmentsForm');
#EndIf

#IfNotRow registry directory diagnosis_and_recommendations
INSERT INTO `registry` (`name`, `state`, `directory`, `sql_run`, `unpackaged`, `date`, `priority`, `category`, `nickname`, `patient_encounter`, `therapy_group_encounter`, `aco_spec`)
VALUES
('Diagnosis and Recommendations', 1, 'diagnosis_and_recommendations', 1, 1, '2020-03-14 00:00:00', 3, 'Clinical', '', 0, 0, 'client_app|DiagnosisandRecommendationsForm');
#EndIf


REPLACE INTO `form_context_map` (`form_id`, `context_type`, `context_id`)
SELECT id,'service_type','1'
FROM registry
WHERE directory = 'medical_admission';


REPLACE INTO `form_context_map` (`form_id`, `context_type`, `context_id`)
SELECT id,'service_type','1'
FROM registry
WHERE directory = 'tests_and_treatments';

REPLACE INTO `form_context_map` (`form_id`, `context_type`, `context_id`)
SELECT id,'service_type','1'
FROM registry
WHERE directory = 'diagnosis_and_recommendations';
