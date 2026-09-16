/*
   Issue Description: CDM-15889
   Category/ Module  : placement removal
   Root cause: user wants to remove a placement end date
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/


update placement set enddatetime = '2021-05-06 00:00:00', updatedby = 'CDM-15889', updatedon = now()
where placementid = '5a53874c-03ed-45dc-b208-a8cd6f77cabb';


Update tb_placement_validation 
set delete_sw = 'Y',
	update_ts = now(),
	update_user_id = 'CDM-15889'
where placement_id = 1561628
	and placement_validation_id = 1966082
	and delete_sw = 'N' ;

Update tb_placement_validation 
set placement_exit_dt = '2021-05-06'::date,
	update_ts = now(),
	update_user_id = 'CDM-15889'
where placement_id = 1561628
	and delete_sw = 'N' ;

	update placementrevision
set exitdate = '2021-05-06 00:00:00', 
	updatedby = 'CDM-15889', 
	updatedon = now()
where placementid = '5a53874c-03ed-45dc-b208-a8cd6f77cabb'
and exitdate is not null;