

SET @current_date = '2020-08-27';
SET @current_date_time = '2020-08-27 12:00:00';
SET @bod = '1993-08-02';
SET @fname = 'בדיקה';
SET @lname = 'שניה';
SET @ss = '301190385';
SET @gender = 'Female';
SET @user_id = 1;
SET @pid = (select (MAX(id) + 1) From patient_data);
SET @uuid = '0x91626ecbe35f4b66bb85e5bc795b0991';
SET @facility = 15;
--
-- Dumping data for table `patient_data`
--

INSERT INTO `patient_data` (`pid`, `uuid`, `title`, `language`, `financial`, `fname`, `lname`, `mname`, `DOB`, `street`, `postal_code`, `city`, `state`, `country_code`, `drivers_license`, `ss`, `occupation`, `phone_home`, `phone_biz`, `phone_contact`, `phone_cell`, `pharmacy_id`, `status`, `contact_relationship`, `date`, `sex`, `referrer`, `referrerID`, `providerID`, `ref_providerID`, `email`, `email_direct`, `ethnoracial`, `race`, `ethnicity`, `religion`, `interpretter`, `migrantseasonal`, `family_size`, `monthly_income`, `billing_note`, `homeless`, `financial_review`, `genericname1`, `genericval1`, `genericname2`, `genericval2`, `hipaa_mail`, `hipaa_voice`, `hipaa_notice`, `hipaa_message`, `hipaa_allowsms`, `hipaa_allowemail`, `squad`, `fitness`, `referral_source`, `usertext1`, `usertext2`, `usertext3`, `usertext4`, `usertext5`, `usertext6`, `usertext7`, `usertext8`, `userlist1`, `userlist2`, `userlist3`, `userlist4`, `userlist5`, `userlist6`, `userlist7`, `pricelevel`, `regdate`, `contrastart`, `completed_ad`, `ad_reviewed`, `vfc`, `mothersname`, `guardiansname`, `allow_imm_reg_use`, `allow_imm_info_share`, `allow_health_info_ex`, `allow_patient_portal`, `deceased_date`, `deceased_reason`, `soap_import_status`, `cmsportal_login`, `care_team`, `county`, `industry`, `imm_reg_status`, `imm_reg_stat_effdate`, `publicity_code`, `publ_code_eff_date`, `protect_indicator`, `prot_indi_effdate`, `guardianrelationship`, `guardiansex`, `guardianaddress`, `guardiancity`, `guardianstate`, `guardianpostalcode`, `guardiancountry`, `guardianphone`, `guardianworkphone`, `guardianemail`, `mh_house_no`, `mh_pobox`, `mh_type_id`, `mh_english_name`, `mh_insurance_organiz`) VALUES
(@pid, @uuid, '', '', '', @fname, @lname, '', @bod, '', '', '', '', '', '', @ss, NULL, '', '', '', '0523441345', 0, '', '', NULL, @gender, '', '', NULL, NULL, '', '', '', '', '', '', '', '', '', '', NULL, '', NULL, '', '', '', '', '', '', '', '', 'NO', 'NO', '', 0, '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', 'standard', NULL, NULL, 'NO', NULL, '', '', NULL, '', '', '', '', '0000-00-00 00:00:00', '', NULL, '', NULL, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '', '', 'teudat_zehut', '', '7');


--
-- Dumping data for table `form_encounter`
--

INSERT INTO `form_encounter` (`date`, `reason`, `facility`, `facility_id`, `pid`, `encounter`, `onset_date`, `sensitivity`, `billing_note`, `pc_catid`, `last_level_billed`, `last_level_closed`, `last_stmt_date`, `stmt_count`, `provider_id`, `supervisor_id`, `invoice_refno`, `referral_source`, `billing_facility`, `external_id`, `pos_code`, `parent_encounter_id`, `status`, `priority`, `service_type`, `escort_id`, `eid`, `arrival_way`, `reason_codes_details`, `secondary_status`, `status_update_date`) VALUES
(@current_date_time, NULL, NULL, @facility, @pid, NULL, NULL, NULL, NULL, 5, 0, 0, NULL, 0, @user_id, 0, '', '', 0, NULL, NULL, NULL, 'in-progress', 211, 1, 1, 0, 'Independent', 'פירוט פירוט פירוט', 'waiting_for_release', @current_date_time);

SET @enc_id = LAST_INSERT_ID();

--
-- Dumping data for table `encounter_reasoncode_map`
--

INSERT INTO `encounter_reasoncode_map` (`eid`, `reason_code`) VALUES(@enc_id, 1);
INSERT INTO `encounter_reasoncode_map` (`eid`, `reason_code`) VALUES(@enc_id, 2);
INSERT INTO `encounter_reasoncode_map` (`eid`, `reason_code`) VALUES(@enc_id, 11);


-- Dumping data for table `fhir_service_request`
--

INSERT INTO `fhir_service_request` (`category`, `encounter`, `reason_code`, `patient`, `instruction_code`, `order_detail_code`, `order_detail_system`, `patient_instruction`, `requester`, `authored_on`, `status`, `intent`, `note`, `performer`, `occurrence_datetime`, `reason_reference_doc_id`) VALUES
('1', @enc_id, '1', @pid, 'providing_medicine', '1000978', 'details_providing_medicine', NULL, @user_id, @current_date_time, 'completed', 'order', NULL, @user_id,  @current_date_time, 0);

INSERT INTO `fhir_service_request` (`category`, `encounter`, `reason_code`, `patient`, `instruction_code`, `order_detail_code`, `order_detail_system`, `patient_instruction`, `requester`, `authored_on`, `status`, `intent`, `note`, `performer`, `occurrence_datetime`, `reason_reference_doc_id`) VALUES
('1', @enc_id, '1', @pid, 'inhalation', NULL, 'details_inhalation', 'זהירות רבה', @user_id,  @current_date_time, 'active', 'order', 'המטופל לא רגוע', NULL, '0000-00-00 00:00:00', 0);


INSERT INTO `questionnaire_response` (`form_name`, `encounter`, `subject`, `subject_type`, `create_date`, `update_date`, `create_by`, `update_by`, `source`, `source_type`, `status`) VALUES
('commitment_questionnaire', @enc_id, @pid, 'Patient', @current_date_time, @current_date_time, 0, 0, @pid, 'Patient', 'completed');
SET @form_commitment_questionnaire_id = LAST_INSERT_ID();
--
-- Dumping data for table `form_commitment_questionnaire`
--
INSERT INTO `form_commitment_questionnaire` (`encounter`, `form_id`, `question_id`, `answer`) VALUES(@enc_id, @form_commitment_questionnaire_id, 1, NULL);
INSERT INTO `form_commitment_questionnaire` (`encounter`, `form_id`, `question_id`, `answer`) VALUES(@enc_id, @form_commitment_questionnaire_id, 2, NULL);
INSERT INTO `form_commitment_questionnaire` (`encounter`, `form_id`, `question_id`, `answer`) VALUES(@enc_id, @form_commitment_questionnaire_id, 3, NULL);
INSERT INTO `form_commitment_questionnaire` (`encounter`, `form_id`, `question_id`, `answer`) VALUES(@enc_id, @form_commitment_questionnaire_id, 4, '');
INSERT INTO `form_commitment_questionnaire` (`encounter`, `form_id`, `question_id`, `answer`) VALUES(@enc_id, @form_commitment_questionnaire_id, 5, '');
INSERT INTO `form_commitment_questionnaire` (`encounter`, `form_id`, `question_id`, `answer`) VALUES(@enc_id, @form_commitment_questionnaire_id, 6, '');
INSERT INTO `form_commitment_questionnaire` (`encounter`, `form_id`, `question_id`, `answer`) VALUES(@enc_id, @form_commitment_questionnaire_id, 7, '');
INSERT INTO `form_commitment_questionnaire` (`encounter`, `form_id`, `question_id`, `answer`) VALUES(@enc_id, @form_commitment_questionnaire_id, 8, '');


--
-- Dumping data for table `questionnaire_response`
--

INSERT INTO `questionnaire_response` (`form_name`, `encounter`, `subject`, `subject_type`, `create_date`, `update_date`, `create_by`, `update_by`, `source`, `source_type`, `status`) VALUES
('diagnosis_and_recommendations_questionnaire', @enc_id, @pid, 'Patient', @current_date_time, @current_date_time, 0, 0, @pid, 'Patient', 'completed');
SET @diagnosis_and_recommendations_id = LAST_INSERT_ID();
--
-- Dumping data for table `form_diagnosis_and_recommendations_questionnaire`
--

INSERT INTO `form_diagnosis_and_recommendations_questionnaire` (`encounter`, `form_id`, `question_id`, `answer`) VALUES(@enc_id, @diagnosis_and_recommendations_id, 1, ' טקסט 1 לשדה פירוט הממצאים בהתייבשות\nטקסט 2 לשדה פירוט הממצאים בהתייבשות\n');
INSERT INTO `form_diagnosis_and_recommendations_questionnaire` (`encounter`, `form_id`, `question_id`, `answer`) VALUES(@enc_id, @diagnosis_and_recommendations_id, 2, ' \n טקסט 1 לשדה פירוט האבחנה בהתייבשות\n');
INSERT INTO `form_diagnosis_and_recommendations_questionnaire` (`encounter`, `form_id`, `question_id`, `answer`) VALUES(@enc_id, @diagnosis_and_recommendations_id, 3, 'פרטים חשויבם');
INSERT INTO `form_diagnosis_and_recommendations_questionnaire` (`encounter`, `form_id`, `question_id`, `answer`) VALUES(@enc_id, @diagnosis_and_recommendations_id, 4, ' טקסט 1 לשדה הוראות להמשך טיפול בהתייבשות\n');
INSERT INTO `form_diagnosis_and_recommendations_questionnaire` (`encounter`, `form_id`, `question_id`, `answer`) VALUES(@enc_id, @diagnosis_and_recommendations_id, 5, 'Release to home');
INSERT INTO `form_diagnosis_and_recommendations_questionnaire` (`encounter`, `form_id`, `question_id`, `answer`) VALUES(@enc_id, @diagnosis_and_recommendations_id, 6, 'Independent');
INSERT INTO `form_diagnosis_and_recommendations_questionnaire` (`encounter`, `form_id`, `question_id`, `answer`) VALUES(@enc_id, @diagnosis_and_recommendations_id, 7, '7');
INSERT INTO `form_diagnosis_and_recommendations_questionnaire` (`encounter`, `form_id`, `question_id`, `answer`) VALUES(@enc_id, @diagnosis_and_recommendations_id, 1, ' טקסט 1 לשדה פירוט הממצאים בהתייבשות\nטקסט 2 לשדה פירוט הממצאים בהתייבשות\n');
INSERT INTO `form_diagnosis_and_recommendations_questionnaire` (`encounter`, `form_id`, `question_id`, `answer`) VALUES(@enc_id, @diagnosis_and_recommendations_id, 2, ' \n טקסט 1 לשדה פירוט האבחנה בהתייבשות\n');
INSERT INTO `form_diagnosis_and_recommendations_questionnaire` (`encounter`, `form_id`, `question_id`, `answer`) VALUES(@enc_id, @diagnosis_and_recommendations_id, 3, 'פרטים חשויבם');
INSERT INTO `form_diagnosis_and_recommendations_questionnaire` (`encounter`, `form_id`, `question_id`, `answer`) VALUES(@enc_id, @diagnosis_and_recommendations_id, 4, ' טקסט 1 לשדה הוראות להמשך טיפול בהתייבשות\n');
INSERT INTO `form_diagnosis_and_recommendations_questionnaire` (`encounter`, `form_id`, `question_id`, `answer`) VALUES(@enc_id, @diagnosis_and_recommendations_id, 5, 'Release to home');
INSERT INTO `form_diagnosis_and_recommendations_questionnaire` (`encounter`, `form_id`, `question_id`, `answer`) VALUES(@enc_id, @diagnosis_and_recommendations_id, 6, 'Independent');
INSERT INTO `form_diagnosis_and_recommendations_questionnaire` (`encounter`, `form_id`, `question_id`, `answer`) VALUES(@enc_id, @diagnosis_and_recommendations_id, 7, '7');


--
-- Dumping data for table `questionnaire_response`
--

INSERT INTO `questionnaire_response` (`form_name`, `encounter`, `subject`, `subject_type`, `create_date`, `update_date`, `create_by`, `update_by`, `source`, `source_type`, `status`) VALUES
('medical_admission_questionnaire', @enc_id, @pid, 'Patient', @current_date_time, @current_date_time, 0, 0, @pid, 'Patient', 'completed');
SET @medical_admission_id = LAST_INSERT_ID();

--
-- Dumping data for table `form_medical_admission_questionnaire`
--

INSERT INTO `form_medical_admission_questionnaire` (`encounter`, `form_id`, `question_id`, `answer`) VALUES(@enc_id, @medical_admission_id, 1, '1');
INSERT INTO `form_medical_admission_questionnaire` (`encounter`, `form_id`, `question_id`, `answer`) VALUES(@enc_id, @medical_admission_id, 2, 'לא לצאת מהחדר');
INSERT INTO `form_medical_admission_questionnaire` (`encounter`, `form_id`, `question_id`, `answer`) VALUES(@enc_id, @medical_admission_id, 3, ' \n טקסט 1 לשדה אנמנזה סיעודית בהתייבשות\nטקסט 2 לשדה אנמנזה סיעודית בהתייבשות\n');
INSERT INTO `form_medical_admission_questionnaire` (`encounter`, `form_id`, `question_id`, `answer`) VALUES(@enc_id, @medical_admission_id, 4, 'Yes');
INSERT INTO `form_medical_admission_questionnaire` (`encounter`, `form_id`, `question_id`, `answer`) VALUES(@enc_id, @medical_admission_id, 1, '1');
INSERT INTO `form_medical_admission_questionnaire` (`encounter`, `form_id`, `question_id`, `answer`) VALUES(@enc_id, @medical_admission_id, 2, 'לא לצאת מהחדר');
INSERT INTO `form_medical_admission_questionnaire` (`encounter`, `form_id`, `question_id`, `answer`) VALUES(@enc_id, @medical_admission_id, 3, ' \n טקסט 1 לשדה אנמנזה סיעודית בהתייבשות\nטקסט 2 לשדה אנמנזה סיעודית בהתייבשות\n');
INSERT INTO `form_medical_admission_questionnaire` (`encounter`, `form_id`, `question_id`, `answer`) VALUES(@enc_id, @medical_admission_id, 4, 'Yes');
INSERT INTO `form_medical_admission_questionnaire` (`encounter`, `form_id`, `question_id`, `answer`) VALUES(@enc_id, @medical_admission_id, 1, '1');

--
-- Dumping data for table `form_vitals`
--

INSERT INTO `form_vitals` (`date`, `pid`, `user`, `groupname`, `authorized`, `activity`, `bps`, `bpd`, `weight`, `height`, `temperature`, `temp_method`, `pulse`, `respiration`, `note`, `BMI`, `BMI_status`, `waist_circ`, `head_circ`, `oxygen_saturation`, `external_id`, `glucose`, `pain_severity`, `eid`, `category`) VALUES
(@current_date_time, @pid, @user_id, NULL, 0, 0, NULL, NULL, 78.00, 180.00, 0.00, NULL, 0.00, 0.00, NULL, 0.0, NULL, 0.00, 0.00, 0.00, NULL, NULL, NULL, 2, 'exam');
INSERT INTO `form_vitals` (`date`, `pid`, `user`, `groupname`, `authorized`, `activity`, `bps`, `bpd`, `weight`, `height`, `temperature`, `temp_method`, `pulse`, `respiration`, `note`, `BMI`, `BMI_status`, `waist_circ`, `head_circ`, `oxygen_saturation`, `external_id`, `glucose`, `pain_severity`, `eid`, `category`) VALUES
(@current_date_time, @pid, @user_id, NULL, 0, 0, '56_', '78_', 0.00, 0.00, 0.00, NULL, 87.00, 50.00, NULL, 0.0, NULL, 0.00, 0.00, 0.00, NULL, 0, 8, 2, 'vital-signs');

--
-- Dumping data for table `lists`
--

INSERT INTO `lists` (`date`, `type`, `subtype`, `title`, `begdate`, `enddate`, `returndate`, `occurrence`, `classification`, `referredby`, `extrainfo`, `diagnosis`, `diagnosis_valueset`, `activity`, `comments`, `pid`, `user`, `groupname`, `outcome`, `destination`, `reinjury_id`, `injury_part`, `injury_type`, `injury_grade`, `reaction`, `external_allergyid`, `erx_source`, `erx_uploaded`, `modifydate`, `severity_al`, `external_id`, `list_option_id`) VALUES
(@current_date_time, 'sensitive', '', NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, 'Sensitivities:40', 'sensitivities', NULL, '', @pid, @user_id, NULL, 0, NULL, 0, '', '', '', '', NULL, '0', '0', @current_date_time, NULL, NULL, NULL);
INSERT INTO `lists` (`date`, `type`, `subtype`, `title`, `begdate`, `enddate`, `returndate`, `occurrence`, `classification`, `referredby`, `extrainfo`, `diagnosis`, `diagnosis_valueset`, `activity`, `comments`, `pid`, `user`, `groupname`, `outcome`, `destination`, `reinjury_id`, `injury_part`, `injury_type`, `injury_grade`, `reaction`, `external_allergyid`, `erx_source`, `erx_uploaded`, `modifydate`, `severity_al`, `external_id`, `list_option_id`) VALUES
(@current_date_time, 'medical_problem', '', NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, 'BK Diseases:10', 'bk_diseases', NULL, '', @pid, @user_id, NULL, 0, NULL, 0, '', '', '', '', NULL, '0', '0', @current_date_time, NULL, NULL, NULL);
INSERT INTO `lists` (`date`, `type`, `subtype`, `title`, `begdate`, `enddate`, `returndate`, `occurrence`, `classification`, `referredby`, `extrainfo`, `diagnosis`, `diagnosis_valueset`, `activity`, `comments`, `pid`, `user`, `groupname`, `outcome`, `destination`, `reinjury_id`, `injury_part`, `injury_type`, `injury_grade`, `reaction`, `external_allergyid`, `erx_source`, `erx_uploaded`, `modifydate`, `severity_al`, `external_id`, `list_option_id`) VALUES
(@current_date_time, 'medical_problem', '', NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, 'BK Diseases:20', 'bk_diseases', NULL, '', @pid, @user_id, NULL, 0, NULL, 0, '', '', '', '', NULL, '0', '0', @current_date_time, NULL, NULL, NULL);
INSERT INTO `lists` (`date`, `type`, `subtype`, `title`, `begdate`, `enddate`, `returndate`, `occurrence`, `classification`, `referredby`, `extrainfo`, `diagnosis`, `diagnosis_valueset`, `activity`, `comments`, `pid`, `user`, `groupname`, `outcome`, `destination`, `reinjury_id`, `injury_part`, `injury_type`, `injury_grade`, `reaction`, `external_allergyid`, `erx_source`, `erx_uploaded`, `modifydate`, `severity_al`, `external_id`, `list_option_id`) VALUES
(@current_date_time, 'sensitive', '', NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, 'Sensitivities:30', 'sensitivities', NULL, '', @pid, @user_id, NULL, 0, NULL, 0, '', '', '', '', NULL, '0', '0', @current_date_time, NULL, NULL, NULL);
INSERT INTO `lists` (`date`, `type`, `subtype`, `title`, `begdate`, `enddate`, `returndate`, `occurrence`, `classification`, `referredby`, `extrainfo`, `diagnosis`, `diagnosis_valueset`, `activity`, `comments`, `pid`, `user`, `groupname`, `outcome`, `destination`, `reinjury_id`, `injury_part`, `injury_type`, `injury_grade`, `reaction`, `external_allergyid`, `erx_source`, `erx_uploaded`, `modifydate`, `severity_al`, `external_id`, `list_option_id`) VALUES
(NULL, 'medication', '', NULL, NULL, NULL, NULL, 0, 0, NULL, NULL, 'MOH_DRUGS:1002300', NULL, NULL, '', @pid, '', NULL, 1, NULL, 0, '', '', '', '', NULL, '0', '0', @current_date_time, NULL, NULL, NULL);
INSERT INTO `lists` (`date`, `type`, `subtype`, `title`, `begdate`, `enddate`, `returndate`, `occurrence`, `classification`, `referredby`, `extrainfo`, `diagnosis`, `diagnosis_valueset`, `activity`, `comments`, `pid`, `user`, `groupname`, `outcome`, `destination`, `reinjury_id`, `injury_part`, `injury_type`, `injury_grade`, `reaction`, `external_allergyid`, `erx_source`, `erx_uploaded`, `modifydate`, `severity_al`, `external_id`, `list_option_id`) VALUES
(NULL, 'medication', '', NULL, NULL, NULL, NULL, 0, 0, NULL, NULL, 'MOH_DRUGS:646461', NULL, NULL, '', @pid, '', NULL, 1, NULL, 0, '', '', '', '', NULL, '0', '0', @current_date_time, NULL, NULL, NULL);



--
-- Dumping data for table `related_person`
--

INSERT INTO `related_person` (`identifier`, `identifier_type`, `active`, `pid`, `relationship`, `phone_home`, `phone_cell`, `email`, `gender`, `full_name`) VALUES
(NULL, NULL, 0, @pid, NULL, '', '0524675567', '', NULL, 'משה ');


--
-- Dumping data for table `prescriptions`
--

INSERT INTO `prescriptions` (`patient_id`, `filled_by_id`, `pharmacy_id`, `date_added`, `date_modified`, `provider_id`, `encounter`, `start_date`, `drug`, `drug_id`, `rxnorm_drugcode`, `form`, `dosage`, `quantity`, `size`, `unit`, `route`, `interval`, `substitute`, `refills`, `per_refill`, `filled_date`, `medication`, `note`, `active`, `datetime`, `user`, `site`, `prescriptionguid`, `erx_source`, `erx_uploaded`, `drug_info_erx`, `external_id`, `end_date`, `indication`, `prn`, `ntx`, `rtx`, `txDate`) VALUES
(@pid, NULL, NULL, NULL, NULL, @user_id, @enc_id, @current_date, 'PILOCARPINE HYDROCHLORIDE 10 MG/ML OPHTHALMIC SOLUTION', 1000647, NULL, 5, '6', NULL, NULL, NULL, 3, 2, NULL, NULL, NULL, NULL, NULL, '', 1, @current_date_time, '1', NULL, NULL, 0, 0, NULL, NULL, '2021-11-01', NULL, NULL, NULL, NULL, '0000-00-00');
INSERT INTO `prescriptions` (`patient_id`, `filled_by_id`, `pharmacy_id`, `date_added`, `date_modified`, `provider_id`, `encounter`, `start_date`, `drug`, `drug_id`, `rxnorm_drugcode`, `form`, `dosage`, `quantity`, `size`, `unit`, `route`, `interval`, `substitute`, `refills`, `per_refill`, `filled_date`, `medication`, `note`, `active`, `datetime`, `user`, `site`, `prescriptionguid`, `erx_source`, `erx_uploaded`, `drug_info_erx`, `external_id`, `end_date`, `indication`, `prn`, `ntx`, `rtx`, `txDate`) VALUES
(@pid, NULL, NULL, NULL, NULL, @user_id, @enc_id, @current_date, 'MEDROXYPROGESTERONE ACETATE 5 MG ORAL TABLET', 1000141, NULL, 3, '6', NULL, NULL, NULL, 3, 13, NULL, NULL, NULL, NULL, NULL, '', 1, @current_date_time, '1', NULL, NULL, 0, 0, NULL, NULL, '2021-11-01', NULL, NULL, NULL, NULL, '0000-00-00');
