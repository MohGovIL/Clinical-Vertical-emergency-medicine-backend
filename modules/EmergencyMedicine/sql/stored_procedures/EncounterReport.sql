delimiter $$

drop procedure if exists `EncounterReport` $$

create procedure EncounterReport(
    in p_current_user int,
    in p_branch_name int,
    in p_service_type int,
    in p_hmo int,
    in p_from_date date,
    in p_to_date date,
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

end $$



DELIMITER $$






DROP FUNCTION IF EXISTS FormatDate $$

CREATE FUNCTION FormatDate (p_date DATE) RETURNS VARCHAR(255) READS SQL DATA
BEGIN
    DECLARE return_date VARCHAR(255);
    DECLARE date_format TINYINT(1);

    SELECT gl_value
    INTO date_format
    FROM globals WHERE gl_name = 'date_display_format';

    SELECT
        CASE
        WHEN date_format = 0 THEN CAST(p_date AS CHAR)
        WHEN date_format = 1 THEN DATE_FORMAT(p_date, '%m/%d/%Y')
        WHEN date_format = 2 THEN DATE_FORMAT(p_date, '%d/%m/%Y')
        END
    INTO return_date;

    RETURN return_date;


END $$

DELIMITER ;




CALL EncounterReport(1,-1,-1,-1,'2020-09-01','2020-09-14',0,50)
