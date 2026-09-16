/*
Issue Description: Need to delete / remove MIFRA as shown in screenshots
Category/Module: Support
Root cause: Closed cases do not allow deletion of assessments
Fix provided: DB queries to remove duplicate assessment
Data/Code fix ticket#: CDM-42981
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: Support ticket
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/

--Remove duplicate in assessment
update assessment
set activeflag = 0, updatedby = 'CDM-42981', updatedon = now()
where assessmentid = '8683899e-773e-48de-a690-ab78ca722005' and activeflag = 1;

--Remove duplicate in assessmentactor
update assessmentactor
set activeflag = 0, updatedby = 'CDM-42981', updatedon = now()
where assessmentid = '8683899e-773e-48de-a690-ab78ca722005' and activeflag = 1;

--Remove duplicate in assessmentcomments
update assessmentcomments
set activeflag = 0, updatedby = 'CDM-42981', updatedon = now()
where assessmentid = '8683899e-773e-48de-a690-ab78ca722005' and activeflag = 1;

--Remove duplicate in assessment_history
update assessment_history
set activeflag = 0, updatedby = 'CDM-42981', updatedon = now()
where assessmentid = '8683899e-773e-48de-a690-ab78ca722005' and activeflag = 1;

--Remove duplicate in assessmentsubmission
update assessmentsubmission
set activeflag = 0, updatedby = 'CDM-42981', updatedon = now()
where assessmentid = '8683899e-773e-48de-a690-ab78ca722005' and activeflag = 1;

--Remove routing record
update routing
set activeflag = 0, updatedby = 'CDM-42981', updatedon = now()
where routingid = '9aabde25-81c3-43a3-8e74-d8297027fbf5' and activeflag = 1;