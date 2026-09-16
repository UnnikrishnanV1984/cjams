/*
  Issue Description:  CJAMS-58010
   Category/ Module  :  child removal
   Root cause: Data fix needs to be promoted as OOH program assignment has ended
   Pull request# for code fix: 
   Reason why no related code fix:NA 
*/


update cjams.intakeservreqchildremoval
set exitdate = Null,
returndate = Null,
returntime = Null,
returntransts = NULL,
removalexitreason = NULL,
updatedby = 'CJAMS-58010',
updatedon = now()
where intakeservreqchildremovalid ='53106d88-fd8c-4a1d-864f-0d52afedb2f3' and activeflag =1;

update tb_client_eligibility
 set end_dt =null,
 update_user_id ='CJAMS-58010', update_ts=now()
 where eligibility_id = 10108311 and removal_id = 326180;

update placement 
set exittypekey ='CIPS',
updatedby ='CJAMS-58010',
updatedon =now()
where placementid ='1624b8da-c2cf-461c-a20c-6b89dd7c5f25' and activeflag =1;

update placementrevision 
set exittypekey ='CIPS',
updatedby ='CJAMS-58010',
updatedon =now()
where placementid ='1624b8da-c2cf-461c-a20c-6b89dd7c5f25' and activeflag =1;

update personprogramarea 
set enddate =null,
updatedby ='CJAMS-58010',
updatedon =now()
where personprogramid ='3d82a655-0bbd-4720-a906-8c1efb7e47f9' and activeflag =1;