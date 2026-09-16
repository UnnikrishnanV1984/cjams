/*
   Issue Description: CJAMS-65394
   Category/ Module  : Prod data fix to update the removal end date
   Root cause: User requested to update the end date
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/


update cjams.personprogramarea set enddate ='2026-02-19 00:00:00.000', updatedon = now ()
where personprogramid ='6493645e-1284-47e1-8217-d96dea9cca18' and activeflag=1;


update cjams.Intakeservreqchildremoval set exitdate ='2026-02-19 00:00:00.000', updatedby ='CJAMS-65394', updatedon = now ()
where intakeservreqchildremovalid='5676a5f4-5007-40ea-8805-38be896704b9' and activeflag=1;

update tb_client_eligibility set end_dt = '2026-02-19 00:00:00.000',
update_user_id = 'CJAMS-65394',update_ts = now() where removal_id = 199445;