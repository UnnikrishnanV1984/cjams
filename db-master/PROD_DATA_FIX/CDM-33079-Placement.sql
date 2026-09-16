/*
   Issue Description: CDM-33079
   Category/ Module  : Placement, child removal 
   Root cause: User requested to change the exit date 
  Fix Provided: Did data fix to update the exit date  
*/


update cjams.intakeservreqchildremoval set exitdate ='2023-02-10 09:00:00', updatedon = now(), updatedby = 'CDM-33079'
where intakeservreqchildremovalid ='cbf51b7b-3bfe-4448-81be-dd7cfc267d27';

update tb_client_eligibility set end_dt = '2023-02-10',update_ts = now(), update_user_id = 'CDM-33079' where removal_id = 250786; 

---provider placement 
UPDATE placement 
SET enddatetime = '2023-02-10 00:00:00', 
    updatedby = 'CDM-33079',
    updatedon = now()
where placementid ='8c0d02c8-6726-4432-be99-94391a80ad28';

UPDATE placementrevision 
SET exitdate = '2023-02-10 00:00:00', 
    updatedby = 'CDM-33079',
    updatedon = now()
where placementid ='8c0d02c8-6726-4432-be99-94391a80ad28' and activeflag =1;


update cjams.personprogramarea set enddate ='2023-02-10 00:00:00', updatedon = now(), updatedby = 'CDM-33079'
where personprogramid ='08221af5-4bb1-4307-8bfd-d809090d919c';


Update 	cjams.tb_placement_validation 
set 	
		placement_exit_dt = '2023-02-10'::date,
		update_ts = now(),
		update_user_id = 'CDM-33079'
where 	placement_id = 1566003 and delete_sw = 'N';