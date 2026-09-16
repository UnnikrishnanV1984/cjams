/*
   Issue Description: CDM-30317
   Category/ Module  : Prod data fix to Remove Child Removal end date
   Root cause: 
   Pull request# for code fix: 
   Status of the code fix if already submitted and expected prod fix date: Need to do data fix
*/

update
    intakeservreqchildremoval
set
    exitdate = Null,
    updatedby = 'CDM-30317',
    updatedon = now()
where
    intakeservreqchildremovalid = 'f6828234-17a0-428e-8945-f160d916aafa';


update
   tb_client_eligibility
set
   end_dt = null,
   update_user_id = 'CDM-30317',
   update_ts = now()
where
   removal_id = '200038';

update
   personprogramarea
set
   enddate = null,
   updatedby = 'CDM-30317',
   updatedon = now()
where
   personprogramid = '8839ebb4-63c9-4440-bd2c-c3a39da84aea';