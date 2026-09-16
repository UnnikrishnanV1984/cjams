/*
   Issue Description: CDM-20320
   Category/ Module  : changing End date
   Root cause: user requeseted to  change end date
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

update placement set enddatetime = '2021-09-01 07:59:00',endtime ='07:59', updatedby = 'CDM-20320', updatedon = now()
where placementid = 'b8e7e58c-efbd-4844-b021-c32e608aee20';


update placementrevision
set exitdate = '2021-09-01 07:59:00', exittime ='07:59',
	updatedby = 'CDM-20320', 
	updatedon = now()
where placementid = 'b8e7e58c-efbd-4844-b021-c32e608aee20'
and exitdate is not null;

update tb_placement_validation set placement_exit_dt = '2021-09-01', update_user_id = 'CDM-20320', update_ts = now() 
where placement_id = '1565241' and placement_validation_id in ('1970551','1970550','1973834');
