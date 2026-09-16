/*
   Issue Description: CDM-36914
   Category/ Module  :  Child Removal
   Root cause: User error
   Pull request# for code fix: 
   Reason why no related code fix: 
   this is a defect raised from person merge 
*/
-- Person ID: (64ac02f3-d5bf-48ac-8170-31fd001e9a40 - 200007769)
-- Case#: 231020575530

update intakeservreqchildremoval r
set activeflag = 0, updatedon = now(), updatedby = 'CDM-36914'
where intakeservreqchildremovalid = '828b6a3b-31fb-43a4-930a-6759036acab6' and personid = '64ac02f3-d5bf-48ac-8170-31fd001e9a40';

update intakeservreqchildremoval_history r
set activeflag = 0, updatedon = now(), updatedby = 'CDM-36914'
where activeflag = 1 and intakeservreqchildremovalid = '828b6a3b-31fb-43a4-930a-6759036acab6' and personid = '64ac02f3-d5bf-48ac-8170-31fd001e9a40';