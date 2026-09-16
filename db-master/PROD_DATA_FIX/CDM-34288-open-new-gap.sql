/*
   Issue Description: CDM-34288
   Category/ Module  : Child Removal
   Root cause: user requested to remove child removal enddate.
   Pull request# for code fix: 8735
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Data fix is required.
*/
update intakeservreqchildremoval
set
    exitdate = Null,
    returntransts =null,
    updatedby = 'CDM-34288',
    updatedon = now()
where intakeservreqchildremovalid = '65b7a1b4-a183-4b29-8d09-d859ec314acb';


update tb_client_eligibility
set
   end_dt = null,
   update_user_id = 'CDM-34288',
   update_ts = now()
where removal_id = '191463';

update personprogramarea
set
   enddate = null,
   updatedby = 'CDM-34288',
   updatedon = now()
where personprogramid = 'b6d39287-2e7a-4de7-8e8a-f66fb2a29b6a';

UPDATE placement 
SET enddatetime = null, 
    endtime = null,
    updatedby = 'CDM-34288',
    updatedon = now()
WHERE placementid = 'bbd7292e-3396-446e-a94f-4575d24b129f';

UPDATE placementrevision 
SET exittime = null, 
    exitdate = null,
    updatedby = 'CDM-34288',
    updatedon = now()
WHERE placementid = 'bbd7292e-3396-446e-a94f-4575d24b129f' ;