/*
   Issue Description: CDM-15952
   Category/ Module  : placement
   Root cause: user wants to change
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
   
*/

update placement 
	set enddatetime = '2021-02-26 00:00:00', updatedon = now(), updatedby = 'CDM-15952' 
	where placementid = 'd901ec42-c2e9-46be-80d8-00b5f572c613';
	
	update placementrevision
	set exitdate = '2021-02-26 00:00:00',                   
		updatedby = 'CDM-15952', 
		updatedon = now()
	where placementid = 'd901ec42-c2e9-46be-80d8-00b5f572c613'
	and exitdate is not null;

	------------------updating placementvalidation table as well with the same exit date-----------

	update tb_placement_validation 
set placement_exit_dt = '2021-02-26 00:00:00', update_ts = now(), update_user_id = 'CDM-15952' 
where placement_id = 1559476;

