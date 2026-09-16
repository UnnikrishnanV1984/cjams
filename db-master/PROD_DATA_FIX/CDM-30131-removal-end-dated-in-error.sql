
/*
   Issue Description: CDM-30131
   Category/ Module  : Prod data fix to Remove Child Removal end date
   Root cause: 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/

update
    intakeservreqchildremoval
set
    exitdate = Null,
    updatedby = 'CDM-30131',
    updatedon = now()
where
    intakeservreqchildremovalid = '10279d29-2567-45f8-8e40-440740305eea';

update
    tb_client_eligibility
set
    end_dt = null,
    update_user_id = 'CDM-30131',
    update_ts = now()
where
    removal_id = '193017';

update
    personprogramarea
set
    enddate = null,
    updatedby = 'CDM-30131',
    updatedon = now()
where
    personprogramid = 'f453b354-0cd6-41cb-b0fd-a4337f333d29';