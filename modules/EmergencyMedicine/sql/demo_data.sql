


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


-- DATA FOR DEVELOPMENT ENV
INSERT INTO `patient_data` (`uuid`, `title`, `language`, `financial`, `fname`, `lname`, `mname`, `DOB`, `street`, `postal_code`, `city`, `state`, `country_code`, `drivers_license`, `ss`, `occupation`, `phone_home`, `phone_biz`, `phone_contact`, `phone_cell`, `pharmacy_id`, `status`, `contact_relationship`, `date`, `sex`, `referrer`, `referrerID`, `providerID`, `ref_providerID`, `email`, `email_direct`, `ethnoracial`, `race`, `ethnicity`, `religion`, `interpretter`, `migrantseasonal`, `family_size`, `monthly_income`, `billing_note`, `homeless`, `financial_review`, `pubpid`, `genericname1`, `genericval1`, `genericname2`, `genericval2`, `hipaa_mail`, `hipaa_voice`, `hipaa_notice`, `hipaa_message`, `hipaa_allowsms`, `hipaa_allowemail`, `squad`, `fitness`, `referral_source`, `usertext1`, `usertext2`, `usertext3`, `usertext4`, `usertext5`, `usertext6`, `usertext7`, `usertext8`, `userlist1`, `userlist2`, `userlist3`, `userlist4`, `userlist5`, `userlist6`, `userlist7`, `pricelevel`, `regdate`, `contrastart`, `completed_ad`, `ad_reviewed`, `vfc`, `mothersname`, `guardiansname`, `allow_imm_reg_use`, `allow_imm_info_share`, `allow_health_info_ex`, `allow_patient_portal`, `deceased_date`, `deceased_reason`, `soap_import_status`, `cmsportal_login`, `care_team`, `county`, `industry`, `imm_reg_status`, `imm_reg_stat_effdate`, `publicity_code`, `publ_code_eff_date`, `protect_indicator`, `prot_indi_effdate`, `guardianrelationship`, `guardiansex`, `guardianaddress`, `guardiancity`, `guardianstate`, `guardianpostalcode`, `guardiancountry`, `guardianphone`, `guardianworkphone`, `guardianemail`, `mh_house_no`, `mh_pobox`, `mh_type_id`, `mh_english_name`, `mh_insurance_organiz`)
 VALUES (0x90b7181d6edb4fcab91e3800a1a4703a, '', '', '', 'בדיקה', 'ראשונה', '', '2012-06-27', '', '', '', '', '', '', '300846367', NULL, '', '', '', '0525112396', '0', '', '', NULL, 'Female', '', '', NULL, NULL, '', '', '', '', '', '', '', '', '', '', NULL, '', NULL, '', '', '', '', '', '', '', '', '', 'NO', 'NO', '', '0', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', 'standard', NULL, NULL, 'NO', NULL, '', '', NULL, '', '', '', '', '0000-00-00 00:00:00', '', NULL, '', NULL, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '', '', 'teudat_zehut', '', '6');

SET @pid = LAST_INSERT_ID();

INSERT INTO `form_encounter` (`date`, `reason`, `facility`, `facility_id`, `pid`, `encounter`, `onset_date`, `sensitivity`, `billing_note`, `pc_catid`, `last_level_billed`, `last_level_closed`, `last_stmt_date`, `stmt_count`, `provider_id`, `supervisor_id`, `invoice_refno`, `referral_source`, `billing_facility`, `external_id`, `pos_code`, `parent_encounter_id`, `status`, `eid`, `priority`, `service_type`, `escort_id`) VALUES
('2020-02-18 00:00:00', 'dfssfd', 'Your Clinic Name Here', 3, @pid, 2, '0000-00-00 00:00:00', 'normal', NULL, 17, 0, 0, NULL, 0, 1, 0, '', '', 3, '', 0, NULL, 'no', 1, 1, NULL, NULL);
SET @enc_id = LAST_INSERT_ID();

INSERT INTO `encounter_reasoncode_map` (`eid`, `reason_code`) VALUES
(@enc_id, 1),
(@enc_id, 2);

--
-- Dumping data for table `event_codeReason_map`
--


INSERT INTO `openemr_postcalendar_events` (`pc_catid`, `pc_multiple`, `pc_aid`, `pc_pid`, `pc_title`, `pc_time`, `pc_hometext`, `pc_comments`, `pc_counter`, `pc_topic`, `pc_informant`, `pc_eventDate`, `pc_endDate`, `pc_duration`, `pc_recurrtype`, `pc_recurrspec`, `pc_recurrfreq`, `pc_startTime`, `pc_endTime`, `pc_alldayevent`, `pc_location`, `pc_conttel`, `pc_contname`, `pc_contemail`, `pc_website`, `pc_fee`, `pc_eventstatus`, `pc_sharing`, `pc_language`, `pc_apptstatus`, `pc_prefcatid`, `pc_facility`, `pc_sendalertsms`, `pc_sendalertemail`, `pc_billing_location`, `pc_room`, `pc_gid`, `pc_priority`, `pc_service_type`, `pc_healthcare_service_id`) VALUES
(17, 1, '1', @pid, 'ביקור שגרתי - רופא', '2020-02-17 15:21:58', '', 0, 0, 1, '1', '2020-02-17', '0000-00-00', 900, 0, 'a:6:{s:17:"event_repeat_freq";s:1:"0";s:22:"event_repeat_freq_type";s:1:"0";s:19:"event_repeat_on_num";s:1:"1";s:19:"event_repeat_on_day";s:1:"0";s:20:"event_repeat_on_freq";s:1:"0";s:6:"exdate";s:0:"";}', 0, '09:15:00', '09:30:00', 0, 'a:6:{s:14:"event_location";s:0:"";s:13:"event_street1";s:0:"";s:13:"event_street2";s:0:"";s:10:"event_city";s:0:"";s:11:"event_state";s:0:"";s:12:"event_postal";s:0:"";}', NULL, NULL, NULL, NULL, NULL, 1, 1, NULL, 'booked', 0, 3, 'NO', 'NO', 3, '', 0, 0, 2, 1);

SET @event_id = LAST_INSERT_ID();

INSERT INTO `event_codeReason_map` (`event_id`, `option_id`) VALUES
(@event_id, '2'),
(@event_id, '3');

--
-- Dumping data for table `form_encounter`
--


--
-- Dumping data for table `openemr_postcalendar_events`
--

--
-- Dumping data for table `patient_data`
--


/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
