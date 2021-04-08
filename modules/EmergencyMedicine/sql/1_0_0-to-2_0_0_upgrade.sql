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


#IfNotRow2D list_options list_id clinikal_enc_secondary_statuses option_id during_treatment
INSERT INTO `list_options` (`list_id`, `option_id`, `title`, `seq`, `is_default`, `option_value`, `mapping`, `notes`, `codes`, `toggle_setting_1`, `toggle_setting_2`, `activity`, `subtype`, `edit_options`)
VALUES
('clinikal_enc_secondary_statuses', 'during_treatment', 'During treatment', 40, 0, 0, '', 'In Progress', '', 0, 0, 1, '', 1);
#EndIf

#IfNotRow2D fhir_value_sets id gender language he
UPDATE fhir_value_sets SET language = 'he' where id NOT IN ('drugs_list','details_providing_medicine');
#EndIf

/* changes in the Diagnosis and recommendations form */
#IfNotRow2D questionnaires_schemas  form_name diagnosis_and_recommendations_questionnaire qid 8
UPDATE questionnaires_schemas SET  question = 'Medical anamnesis' WHERE qid = '1';
UPDATE questionnaires_schemas SET  question = 'Physical examination' WHERE qid = '2';

INSERT INTO `questionnaires_schemas` (`qid`, `form_name`,`form_table`, `column_type`, `question`)
VALUES
('8', 'diagnosis_and_recommendations_questionnaire','form_diagnosis_and_recommendations_questionnaire', 'string', 'Diagnisis');
#EndIf

#IfNotRow2D list_options list_id clinikal_form_fields_templates option_id medical_anamnesis
INSERT INTO `list_options` (`list_id`, `option_id`, `title`, `seq`, `activity`, `notes`) VALUES
('clinikal_form_fields_templates', 'medical_anamnesis', 'Medical anamnesis', 10, 1, 'diagnosis_and_recommendations'),
('clinikal_form_fields_templates', 'physical_examination', 'Physical examination', 10, 1, 'diagnosis_and_recommendations');

DELETE FROM list_options WHERE list_id = 'clinikal_form_fields_templates' AND option_id = 'findings_details';
DELETE FROM list_options WHERE list_id = 'clinikal_form_fields_templates' AND option_id = 'diagnosis_details';
DELETE FROM list_options WHERE list_id = 'clinikal_form_fields_templates' AND option_id = 'treatment_details';
#EndIf


#IfNotRow2D questionnaires_schemas form_name medical_admission_questionnaire qid 8
INSERT INTO `questionnaires_schemas` (`qid`, `form_name`,`form_table`, `column_type`, `question`)
VALUES
('8', 'medical_admission_questionnaire','form_medical_admission_questionnaire', 'string', 'Medical Background Comments');
#EndIf

#IfNotRow2D fhir_value_sets id bk_diseases language en
UPDATE fhir_value_sets SET language = 'en' where id = 'bk_diseases';
#EndIf

#IfNotRow2D fhir_value_set_systems vs_id bk_diseases system 9910
UPDATE `fhir_value_set_systems` SET `system` = '9910' WHERE `vs_id` = 'bk_diseases';
#EndIf
