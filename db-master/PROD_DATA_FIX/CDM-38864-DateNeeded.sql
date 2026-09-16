/*
Issue Description:CHILD'S NAME: Corey KingIV-E Specialist NAME:Jasmine HuddlestonCLIENT ID: 1880482AGENCY : DHSJURISDICTION: Prince George'sCASE NUMBER: 3216491Dated of 12/09/2013 needed for 2nd parent signature on VPA 
Category/Module: Bug
Root cause: user could not abe to update  child removal records, they can only create.
Fix provided: DB queries  update intakeservreqchildremoval table.
Data/Code fix ticket#: CDM-38864
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: Support
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/


update intakeservreqchildremoval
set parent2signeddate = '2013-12-09' , parent1id = '3532606', parent2id = '1341039',updatedby = 'CDM-38864' , updatedon = now()
where intakeservreqchildremovalid = '4c3930e0-4886-4d2e-9596-d7e6267ceac0' and activeflag = 1;

--no records found
--update intakeservreqchildremoval_history
--set parent2signeddate = '2014-01-13' ,updatedby = , updatedon = now()
--where intakeservreqchildremovalhistoryid =   and activeflag = 1;