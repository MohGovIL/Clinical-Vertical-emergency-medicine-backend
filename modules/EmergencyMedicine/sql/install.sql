-- setting for Isreali emergency medicine clinics
REPLACE INTO `globals` (`gl_name`, `gl_index`, `gl_value`) VALUES ('date_display_format', '0', '2'),('language_default', '0', 'Hebrew'),('gbl_time_zone', '0', 'Asia/Jerusalem');

-- update menu for the admin user
UPDATE `users` SET `main_menu_role` = 'clinikal-emergency.json' WHERE `users`.`id` = 1;

-- setting for client side app
INSERT INTO `globals` (`gl_name`, `gl_index`, `gl_value`) VALUES
('clinikal_react_vertical', 0, 'emergency');

INSERT INTO `globals` (`gl_name`, `gl_index`, `gl_value`) VALUES
('clinikal_hide_appoitments', 0, '1');

INSERT INTO `globals` (`gl_name`, `gl_index`, `gl_value`) VALUES
('clinikal_pa_commitment_form', 0, '0');


INSERT INTO `globals` (`gl_name`, `gl_index`, `gl_value`) VALUES
('clinikal_pa_arrival_way', 0, '1');

INSERT INTO `globals` (`gl_name`, `gl_index`, `gl_value`) VALUES
('clinikal_pa_next_enc_status', 0, 'arrived');



INSERT INTO fhir_value_sets (id, title, status) VALUES
('identifier_type_list', 'Identifier Type List', 'active');

INSERT INTO `fhir_value_set_systems` (`vs_id`, `system`, `type`, `filter`)
VALUES
('identifier_type_list', 'userlist3', 'All', NULL);

-- default FHIR statuses for non-block development
DELETE FROM `list_options` WHERE `list_id` = 'clinikal_enc_statuses';
INSERT INTO `list_options` (`list_id`, `option_id`, `title`, `seq`, `is_default`, `option_value`, `mapping`, `notes`, `codes`, `toggle_setting_1`, `toggle_setting_2`, `activity`, `subtype`, `edit_options`) VALUES
('clinikal_enc_statuses', 'planned', 'Planned', 10, 0, 0, '', '', '', 0, 0, 1, '', 1),
('clinikal_enc_statuses', 'arrived', 'Arrived', 20, 0, 0, '', '', '', 0, 0, 1, '', 1),
('clinikal_enc_statuses', 'triaged', 'Triaged', 30, 0, 0, '', '', '', 0, 0, 1, '', 1),
('clinikal_enc_statuses', 'in-progress', 'In Progress', 40, 0, 0, '', '', '', 0, 0, 1, '', 1),
('clinikal_enc_statuses', 'finished', 'Finished', 60, 0, 0, '', '', '', 0, 0, 1, '', 1),
('clinikal_enc_statuses', 'cancelled', 'Cancelled', 15, 0, 0, '', '', '', 0, 0, 1, '', 1);

INSERT INTO `fhir_value_sets` (`id`, `title`) VALUES
 ('encounter_statuses', 'Encounter Statuses');

INSERT INTO `fhir_value_set_systems` (`vs_id`, `system`, `type`) VALUES
('encounter_statuses', 'clinikal_enc_statuses', 'All');


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



-- --------------------------------------------------------
DELETE FROM categories WHERE id > 1;
INSERT INTO `categories` (`id`, `name`, `value`, `parent`, `lft`, `rght`, `aco_spec`) VALUES
('2', 'Commitment', '', '1', '1', '2', 'patients|docs'),
('3', 'Referral', '', '1', '3', '4', 'patients|docs'),
('4', 'Referral for X-ray', '', '1', '5', '10', 'patients|docs'),
('5', 'Summary letter', '', '1', '6', '7', 'patients|docs'),
('6', 'Other', '', '1', '11', '18', 'patients|docs'),
('7', 'Patient Photo', '', '1', '12', '13', 'patients|docs'),
('8', 'Prescriptions', '', '1', '14', '15', 'patients|docs');

DELETE FROM `categories_seq`;
INSERT INTO `categories_seq` (`id`) VALUES('9');

CREATE TABLE form_medical_admission_questionnaire(
    encounter int(11) DEFAULT NULL,
    form_id bigint(20) NOT NULL,
    question_id int(11) NOT NULL,
    answer text,
    PRIMARY KEY (`encounter`, `form_id`, `question_id`)
);

INSERT INTO `fhir_questionnaire` (`name`, `directory`, `state`, `aco_spec`) VALUES
('Medical admission questionnaire', 'medical_admission_questionnaire', '1', 'encounters|notes');


INSERT INTO `questionnaires_schemas` (`qid`, `form_name`,`form_table`, `column_type`, `question`)
VALUES
('1', 'medical_admission_questionnaire','form_medical_admission_questionnaire', 'boolean', 'Insulation required'),
('2', 'medical_admission_questionnaire','form_medical_admission_questionnaire', 'string', 'Insulation instructions'),
('3', 'medical_admission_questionnaire','form_medical_admission_questionnaire', 'string', 'Nursing anamnesis'),
('4', 'medical_admission_questionnaire','form_medical_admission_questionnaire', 'boolean', 'Pregnancy'),
('5', 'medical_admission_questionnaire','form_medical_admission_questionnaire', 'boolean', 'Sensitivities'),
('6', 'medical_admission_questionnaire','form_medical_admission_questionnaire', 'boolean', 'Background diseases'),
('7', 'medical_admission_questionnaire','form_medical_admission_questionnaire', 'boolean', 'Chronic medications');


/* INSERT LISTS*/
DELETE FROM list_options where list_id="clinikal_service_types" OR option_id="clinikal_service_types";
INSERT INTO `list_options` (`list_id`, `option_id`, `title`, `seq`, `is_default`, `option_value`, `mapping`, `notes`, `codes`, `toggle_setting_1`, `toggle_setting_2`, `activity`, `subtype`, `edit_options`) VALUES
('lists', 'clinikal_service_types', 'Clinikal Service Types', 0, 0, 0, '', '', '', 0, 0, 1, '', 1),
('clinikal_service_types', '1', 'Emergency Medicine', 10, 0, 0, '', '', '', 0, 0, 1, '', 1);

INSERT INTO `fhir_value_sets` (`id`, `title`) VALUES
('service_types', 'Service Types');

INSERT INTO `fhir_value_set_systems` (`vs_id`, `system`, `type`) VALUES
('service_types', 'clinikal_service_types', 'All');


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


INSERT INTO `code_types` (`ct_key`, `ct_id`, `ct_seq`, `ct_mod`, `ct_just`, `ct_mask`, `ct_fee`, `ct_rel`, `ct_nofs`, `ct_diag`, `ct_active`, `ct_label`, `ct_external`, `ct_claim`, `ct_proc`, `ct_term`, `ct_problem`, `ct_drug`) VALUES
('Sensitivities', 9920, 9920, 12, 'Sensitivities', '', 1, 0, 1, 1, 1, 'Sensitivities', 0, 1, 0, 1, 0, 0),
('BK Diseases', 9921, 9921, 12, 'BK Diseases', '', 1, 0, 1, 0, 1, 'Background Diseases', 0, 1, 0, 1, 1, 0);


INSERT INTO `codes` (`code_text`, `code_text_short`, `code`, `code_type`, `modifier`, `units`, `fee`, `superbill`, `related_code`, `taxrates`, `cyp_factor`, `active`, `reportable`, `financial_reporting`) VALUES
-- Sensitivities
('Eggs', '', '10', 9920, '', 0, '0.00', '', '', '', 0, 1, 0, 0),
('IodineI', '', '20', 9920, '', 0, '0.00', '', '', '', 0, 1, 0, 0),
('Lactose', '', '30', 9920, '', 0, '0.00', '', '', '', 0, 1, 0, 0),
('Neomycin', '', '40', 9920, '', 0, '0.00', '', '', '', 0, 1, 0, 0),
('Latex', '', '50', 9920, '', 0, '0.00', '', '', '', 0, 1, 0, 0),
('Penicillin', '', '60', 9920, '', 0, '0.00', '', '', '', 0, 1, 0, 0),
--  Background Diseases
("Alzheimer's", '', '10', 9921, '', 0, '0.00', '', '', '', 0, 1, 0, 0),
('Asthma', '', '20', 9921, '', 0, '0.00', '', '', '', 0, 1, 0, 0),
('High blood pressure', '', '30', 9921, '', 0, '0.00', '', '', '', 0, 1, 0, 0),
('Heart disease', '', '40', 9921, '', 0, '0.00', '', '', '', 0, 1, 0, 0),
('Diabetes', '', '50', 9921, '', 0, '0.00', '', '', '', 0, 1, 0, 0),
('Cancer', '', '60', 9921, '', 0, '0.00', '', '', '', 0, 1, 0, 0),
('Tuberculosis', '', '70', 9921, '', 0, '0.00', '', '', '', 0, 1, 0, 0);


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

INSERT INTO `list_options` (`list_id`, `option_id`, `title`, `seq`, `activity`,`notes`) VALUES
('lists', 'x_ray_types', 'X-Ray Types', 0, 1,''),
('x_ray_types', 'chest', 'Chest', 10, 1,''),
('x_ray_types', 'palm', 'Palm', 20, 1,''),
('x_ray_types', 'sole', 'sole', 30, 1,''),
('x_ray_types', 'shoulder', 'Shoulder', 40, 1,''),
('x_ray_types', 'neck', 'Neck', 50, 1,''),
('x_ray_types', 'ankle', 'Ankle', 60, 1,'');

INSERT INTO `registry` (`name`, `state`, `directory`, `sql_run`, `unpackaged`, `date`, `priority`, `category`, `nickname`, `patient_encounter`, `therapy_group_encounter`, `aco_spec`,`component_name`)
VALUES
('Medical Admission', 1, 'medical_admission', 1, 1, '2020-03-14 00:00:00', 1, 'React form', '', 0, 0, 'client_app|MedicalAdmissionForm','MedicalAdmission'),
('Tests and Treatments', 1, 'tests_and_treatments', 1, 1, '2020-03-14 00:00:00', 2, 'React form', '', 0, 0, 'client_app|TestsAndTreatmentsForm','TestsAndTreatments'),
('Diagnosis and Recommendations', 1, 'diagnosis_and_recommendations', 1, 1, '2020-03-14 00:00:00', 3, 'React form', '', 0, 0, 'client_app|DiagnosisAndRecommendationsForm','DiagnosisAndRecommendations');


INSERT INTO `form_context_map` (`form_id`, `context_type`, `context_id`)
SELECT id,'service_type','1'
FROM registry
WHERE directory = 'medical_admission';

INSERT INTO `form_context_map` (`form_id`, `context_type`, `context_id`)
SELECT id,'service_type','1'
FROM registry
WHERE directory = 'tests_and_treatments';

INSERT INTO `form_context_map` (`form_id`, `context_type`, `context_id`)
SELECT id,'service_type','1'
FROM registry
WHERE directory = 'diagnosis_and_recommendations';

-- ValueSets

INSERT INTO `fhir_value_sets` (`id`, `title`)
VALUES ('reason_codes_1', 'Emergency Medicine Reason Codes');

INSERT INTO `fhir_value_set_systems` (`vs_id`, `system`, `type`,`filter`)
VALUES ('reason_codes_1', 'clinikal_reason_codes', 'Filter', '1');

INSERT INTO `fhir_value_sets` (`id`, `title`)
VALUES ('sensitivities', 'Sensitivities');

INSERT INTO `fhir_value_set_systems` (`vs_id`, `system`, `type`,`filter`)
VALUES ('sensitivities', '9920', 'Codes', NULL);

INSERT INTO `fhir_value_sets` (`id`, `title`)
VALUES ('bk_diseases', 'BK Diseases');

INSERT INTO `fhir_value_set_systems` (`vs_id`, `system`, `type`,`filter`)
VALUES ('bk_diseases', '9921', 'Codes', NULL);

INSERT INTO `fhir_value_sets` (`id`, `title`)
VALUES ('tests_and_treatments', 'Tests And Treatments');

INSERT INTO `fhir_value_set_systems` (`vs_id`, `system`, `type`,`filter`)
VALUES ('tests_and_treatments', 'tests_and_treatments', 'All', NULL);

INSERT INTO `fhir_value_sets` (`id`, `title`)
VALUES ('details_x_ray', 'Xray Type');

INSERT INTO `fhir_value_set_systems` (`vs_id`, `system`, `type`,`filter`)
VALUES ('details_x_ray', 'x_ray_types', 'All', NULL);

INSERT INTO `fhir_value_sets` (`id`, `title`)
VALUES ('details_providing_medicine', 'Drug name');

INSERT INTO `fhir_value_set_systems` (`vs_id`, `system`, `type`,`filter`)
VALUES ('details_providing_medicine', '9911', 'Codes', NULL);



INSERT INTO `list_options` (`list_id`, `option_id`, `title`, `seq`, `is_default`, `option_value`, `mapping`, `notes`, `codes`, `toggle_setting_1`, `toggle_setting_2`, `activity`, `subtype`, `edit_options`)
VALUES
('clinikal_enc_secondary_statuses', 'waiting_for_nurse', 'Waiting for Nurse', 10, 0, 0, '', 'In Progress ', '', 0, 0, 1, '', 1),
('clinikal_enc_secondary_statuses', 'waiting_for_doctor', 'Waiting for Doctor', 20, 0, 0, '', 'In Progress ', '', 0, 0, 1, '', 1),
('clinikal_enc_secondary_statuses', 'waiting_for_xray', 'Waiting for X-ray', 30, 0, 0, '', 'In Progress ', '', 0, 0, 1, '', 1),
('clinikal_enc_secondary_statuses', 'waiting_for_release', 'Waiting for Release', 40, 0, 0, '', 'In Progress ', '', 0, 0, 1, '', 1),
('clinikal_enc_secondary_statuses', 'during_treatment', 'During treatment', 40, 0, 0, '', 'In Progress', '', 0, 0, 1, '', 1);


-- More Valuesets

INSERT INTO `fhir_value_sets` (`id`, `title`)
VALUES ('encounter_secondary_statuses', 'Encounter Secondary Statuses');

INSERT INTO `fhir_value_set_systems` (`vs_id`, `system`, `type`,`filter`)
VALUES ('encounter_secondary_statuses', 'clinikal_enc_secondary_statuses', 'All', NULL);


INSERT INTO `fhir_value_sets` (`id`, `title`)
VALUES ('waiting_for_xray_statuses', 'Waiting For Xray Statuses');

INSERT INTO `fhir_value_set_systems` (`vs_id`, `system`, `type`,`filter`)
VALUES ('waiting_for_xray_statuses', 'clinikal_enc_secondary_statuses', 'Partial', NULL);

INSERT INTO `fhir_value_set_codes` (`vss_id`, `code`) VALUES
((SELECT id FROM fhir_value_set_systems WHERE vs_id = 'waiting_for_xray_statuses' AND system = 'clinikal_enc_secondary_statuses' AND type = 'Partial'), 'waiting_for_nurse'),
((SELECT id FROM fhir_value_set_systems WHERE vs_id = 'waiting_for_xray_statuses' AND system = 'clinikal_enc_secondary_statuses' AND type = 'Partial'), 'waiting_for_doctor'),
((SELECT id FROM fhir_value_set_systems WHERE vs_id = 'waiting_for_xray_statuses' AND system = 'clinikal_enc_secondary_statuses' AND type = 'Partial'), 'waiting_for_xray');


INSERT INTO `fhir_value_sets` (`id`, `title`)
VALUES ('waiting_for_release_statuses', 'Waiting For Release Statuses');

INSERT INTO `fhir_value_set_systems` (`vs_id`, `system`, `type`,`filter`)
VALUES ('waiting_for_release_statuses', 'clinikal_enc_secondary_statuses', 'Partial', NULL);

INSERT INTO `fhir_value_set_codes` (`vss_id`, `code`) VALUES
((SELECT id FROM fhir_value_set_systems WHERE vs_id = 'waiting_for_release_statuses' AND system = 'clinikal_enc_secondary_statuses' AND type = 'Partial'), 'waiting_for_release');

INSERT INTO `fhir_value_set_systems` (`vs_id`, `system`, `type`,`filter`)
VALUES ('waiting_for_release_statuses', 'clinikal_enc_statuses', 'Partial', NULL);

INSERT INTO `fhir_value_set_codes` (`vss_id`, `code`) VALUES
((SELECT id FROM fhir_value_set_systems WHERE vs_id = 'waiting_for_release_statuses' AND system = 'clinikal_enc_statuses' AND type = 'Partial'), 'finished');


CREATE TABLE form_diagnosis_and_recommendations_questionnaire(
    encounter int(11) NOT NULL,
    form_id bigint(20) NOT NULL,
    question_id int(11) NOT NULL,
    answer text,
    PRIMARY KEY (encounter, form_id, question_id)
);

INSERT INTO `fhir_questionnaire` (`name`, `directory`, `state`, `aco_spec`) VALUES
('Diagnosis and recommendations questionnaire', 'diagnosis_and_recommendations_questionnaire', '1', 'encounters|notes');


INSERT INTO `questionnaires_schemas` (`qid`, `form_name`,`form_table`, `column_type`, `question`)
VALUES
('1', 'diagnosis_and_recommendations_questionnaire','form_diagnosis_and_recommendations_questionnaire', 'string', 'Findings details'),
('2', 'diagnosis_and_recommendations_questionnaire','form_diagnosis_and_recommendations_questionnaire', 'string', 'Diagnosis details'),
('3', 'diagnosis_and_recommendations_questionnaire','form_diagnosis_and_recommendations_questionnaire', 'string', 'Treatment details'),
('4', 'diagnosis_and_recommendations_questionnaire','form_diagnosis_and_recommendations_questionnaire', 'string', 'Instructions for further treatment'),
('5', 'diagnosis_and_recommendations_questionnaire','form_diagnosis_and_recommendations_questionnaire', 'string', 'Decision'),
('6', 'diagnosis_and_recommendations_questionnaire','form_diagnosis_and_recommendations_questionnaire', 'string', 'Evacuation way'),
('7', 'diagnosis_and_recommendations_questionnaire','form_diagnosis_and_recommendations_questionnaire', 'integer', 'Sick leave');


INSERT INTO `manage_templates_letters` (`id`, `letter_name`, `letter_class`, `letter_class_action`, `active`, `letter_post_json`) VALUES
(1, 'letter_x_ray', 'EmergencyMedicine\\Controller\\xrayLetterController', 'pdf', 1, '\n{"facility": "required","encounter": "required","owner": "optional","patient": "optional"}');

INSERT INTO `manage_templates_letters` (`letter_name`, `letter_class`, `letter_class_action`, `active`, `letter_post_json`) VALUES
('summary_letter', 'EmergencyMedicine\\Controller\\summaryLetterController', 'pdf', '1', '{\"facility\": \"required\",\"encounter\": \"required\",\"owner\": \"optional\",\"patient\": \"optional\"}');

#SpecialSql
create procedure EncounterReport(
    in p_current_user int,
    in p_branch_name int,
    in p_service_type int,
    in p_hmo int,
    in p_from_date datetime,
    in p_to_date datetime,
    in p_offset int,
    in p_limit int
)
begin
	select
	count(*) over (partition by null) as count,
    FormatDate(fe.date) as encounter_date,
    concat(pd.lname, ' ', pd.fname) as patient_name,
    ifnull(pd.ss,'') as id,
    ifnull(fpd.name,'') as insurance_body,
    ifnull(ffe.name,'') as branch_name,
    GetHebTitle(GetOptionTitle('clinikal_service_types', fe.service_type)) as service_type,
    ifnull(darqd.answer,'-') as decision,
    ifnull(darqr.answer,'-') as release_way

   	from form_encounter fe
   	join patient_data pd on  fe.pid = pd.pid
   	join facility ffe on  fe.facility_id = ffe.id
   	join facility fpd on  pd.mh_insurance_organiz = fpd.id
   	left join form_diagnosis_and_recommendations_questionnaire darqd on (darqd.encounter = fe.id and darqd.question_id=5)
    left join form_diagnosis_and_recommendations_questionnaire darqr on (darqr.encounter = fe.id and darqr.question_id=6)

    where (
     (p_branch_name = -1  OR  p_branch_name = ffe.id) AND
     (p_service_type = -1 OR  p_service_type = fe.service_type) AND
     (p_hmo = -1          OR  p_hmo = fpd.id) AND
     (fe.date BETWEEN p_from_date AND p_to_date)

    )
	limit p_limit offset p_offset ;
end;
#EndSpecialSql

#SpecialSql
create procedure EncounterReportExetended(
    in p_current_user int,
    in p_branch_name int,
    in p_service_type int,
    in p_hmo int,
    in p_from_date datetime,
    in p_to_date datetime,
    in p_offset int,
    in p_limit int
)
begin
	select
	count(*) over (partition by null) as count,
	-- extra columns and different order then regular encounter report
    FormatDate(fe.date) as encounter_date,
    pd.fname as first_name,
    pd.lname as last_name,
    GetHebTitle(GetOptionTitle('userlist3', pd.mh_type_id)) as type_id,
    ifnull(pd.ss,'') as id,
    ifnull(fpd.name,'') as insurance_body,
    ifnull(ffe.name,'') as branch_name,
    GetHebTitle(GetOptionTitle('clinikal_service_types', fe.service_type)) as service_type,
    ifnull(darqd.answer,'-') as decision,
    ifnull(darqr.answer,'-') as release_way,
    GROUP_CONCAT(GetHebTitle(GetOptionTitle('clinikal_reason_codes', er.reason_code))) AS reason_titles,
    concat(us.lname, ' ', us.fname) as doc_name,
    ifnull(us.state_license_number, '') as doc_number,
    ifnull(GetHebTitle(cques2.answer),'-') as payment_way,
    ifnull(cques1.answer,'-') as payment_amount,
    ifnull(cques3.answer,'-') as reception_num,
    FormatDate(pd.DOB) as birth_date,
    pd.phone_cell as phone_cell,
    GetHebTitle(GetOptionTitle('mh_cities', pd.city)) as city,
    GetHebTitle(GetOptionTitle('mh_streets', pd.street)) as street,
    pd.mh_house_no as house_num,
    pd.postal_code as postal_code

   	from form_encounter fe
   	join patient_data pd on  fe.pid = pd.pid
   	join facility ffe on  fe.facility_id = ffe.id
   	join facility fpd on  pd.mh_insurance_organiz = fpd.id
   	left join questionnaire_response qres on (qres.encounter = fe.id and qres.form_name = 'diagnosis_and_recommendations_questionnaire')
   	left join users us on qres.update_by = us.id
   	left join form_diagnosis_and_recommendations_questionnaire darqd on (darqd.encounter = fe.id and darqd.question_id=5)
    left join form_diagnosis_and_recommendations_questionnaire darqr on (darqr.encounter = fe.id and darqr.question_id=6)
    -- join more tables for extended reports
    left join encounter_reasoncode_map as er on er.eid = fe.id
    left join form_commitment_questionnaire cques1 on (cques1.encounter = fe.id and cques1.question_id=6)
    left join form_commitment_questionnaire cques2 on (cques2.encounter = fe.id and cques2.question_id=7)
    left join form_commitment_questionnaire cques3 on (cques3.encounter = fe.id and cques3.question_id=8)

    where (
     (p_branch_name = -1  OR  p_branch_name = ffe.id) AND
     (p_service_type = -1 OR  p_service_type = fe.service_type) AND
     (p_hmo = -1          OR  p_hmo = fpd.id) AND
     (fe.date BETWEEN p_from_date AND p_to_date)

    )

    group by fe.id

	limit p_limit offset p_offset ;
end;
#EndSpecialSql

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
('clinikal_form_fields_templates', 'instructions_drug', 'Instructions for providing medicine', 10, 1, 'diagnosis_and_recommendations');
