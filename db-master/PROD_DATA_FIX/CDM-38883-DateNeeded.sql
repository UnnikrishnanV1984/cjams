
/*
Issue Description:CHILD'S NAME: Anderson SandovalcortezIV-E Specialist NAME:Jasmine HuddlestonCLIENT ID: 3580012AGENCY : DHSJURISDICTION: Prince George'sCASE NUMBER: 3229626Dated of 01/13/2014 needed for 2nd parent signature
Category/Module: Bug
Root cause: user could not abe to update  child removal records, they can only create.
Fix provided: DB queries  update intakeservreqchildremoval table.
Data/Code fix ticket#: CDM-38883
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: Support
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/





update intakeservreqchildremoval
set parent2signeddate = '2014-01-13' , parent1id = '3580006', parent2id = '3580016', updatedby = 'CDM-38883' , updatedon = now()
where intakeservreqchildremovalid = '75987d0f-6f9a-45c5-aa46-be92ef1c24e1' and activeflag = 1;

--no records found
--update intakeservreqchildremoval_history
--set parent2signeddate = '2014-01-13' ,updatedby = , updatedon = now()
--where intakeservreqchildremovalhistoryid =   and activeflag = 1;