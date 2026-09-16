/*
   Issue Description: CDM-31940
   Category/ Module  :Placement 
   Root cause: user requested to edit placement enddate and entrydate
   Pull request# for code fix: 
   Reason why no related code fix: 
   requested a data fix to resolve:
   
*/
update placement  
set enddatetime = '2021-04-14 07:00:00',
    endtime ='07:00',
	updatedon = now(), 
	updatedby = 'CDM-31940'
where placementid = 'cef467b5-ee1b-40bc-8ff0-d9d92221ed69'
	and activeflag = 1 ;
	

update placement  
set startdatetime = '2021-04-14 08:00:00', 
    starttime ='08:00',
	updatedon = now(), 
	updatedby = 'CDM-31940'
where placementid = 'c11e78f0-c1ee-4afd-8285-386283715b9a'
	and activeflag = 1 ;
	
update placementrevision  
set exitdate = '2021-04-14 07:00:00',
exittime ='07:00',
	updatedon = now(), 
	updatedby = 'CDM-31940'
where placementrevisionid = '90952ed1-1c7a-48cc-99f0-74c3a5c86d5e'
	and exitdate is not null ;

update placementrevision  
set entrydate = '2021-04-14 08:00:00', 
	updatedon = now(), 
	updatedby = 'CDM-31940'
where placementrevisionid= 'b84c60df-3aec-4385-9b56-e90b59e59cf5' ;

update tb_placement_validation set placement_exit_dt = '2021-04-14',
	update_ts = now(),
	update_user_id = 'CDM-31940'
where placement_id = 1561103 and delete_sw = 'N';