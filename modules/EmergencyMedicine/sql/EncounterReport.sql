delimiter $$

drop procedure if exists `EncounterReport` $$

create procedure EncounterReport(
    in p_current_user int,
    in p_from_date date,
    in p_to_date date,
    in p_branch_name int,
    in p_service_type int,
    in p_hmo int,
    in p_offset int,
    in p_limit int
)
begin
	select
	count(*) over (partition by null) as count,
    ifnull(pdy.date,'') as encounter_date,
    ifnull(pdy.fname,'') as patient_name,
    ifnull(pdy.id,'') as id,
    ifnull(pdy.ad_reviewed,'') as insurance_body,
    ifnull(pdy.billing_note,'') as branch,
    ifnull(pdy.status,'') as service_type,
    ifnull(pdy.squad,'') as decision,
    ifnull(pdy.squad,'') as release_way

   	from patient_data pdy
    where (1=1)
	limit p_limit offset p_offset ;

end $$
