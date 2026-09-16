/*
Issue Description:User has requested to do a data fix to remove the Child removal with Draft status in Case # 241030332837.
Category/Module: Bug
Root cause: data fix to remove the Child removal with Draft status in Case # 241030332837.
Fix provided: DB queries to do a data fix  to remove the Child removal with Draft status in Case # 241030332837.
Data/Code fix ticket#: CJAMS-58352
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: Data error
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
*/

update
    intakeservreqchildremoval
set
    activeflag = 0,
    updatedby = 'CJAMS-58352',
    updatedon = now()
where
    intakeservreqchildremovalid = '1119ca0d-709c-4070-9a1b-63515a36fadc'
   and personid = 'fe9a68a4-6fef-4f71-a304-62d0ff4c71a1';
   
      
  update
    intakeservreqchildremoval_history
set
    activeflag = 0,
    updatedby = 'CJAMS-58352',
    updatedon = now()
where
    intakeservreqchildremovalid = '1119ca0d-709c-4070-9a1b-63515a36fadc'
   and personid = 'fe9a68a4-6fef-4f71-a304-62d0ff4c71a1'
   and intakeservreqchildremovalhistoryid = '00c81248-343a-4fe1-96c4-093a2af9bb49';
