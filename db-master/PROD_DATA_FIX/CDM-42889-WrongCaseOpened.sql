/*
Issue Description: Need data fix: Close the Service case # 231030147746 and remove the related data from the intake, then connected the Intake # I24101317671 to service case# 241030284461.
Root cause: User opened a wrong servicecase in error and connected it to the intake
Fix provided: DB queries to close the servicecase and connect the intake to the correct case
Data/Code fix ticket#: CDM-42889
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: User error
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/

--Closing servicecase
update servicecase
set statustypekey = 'Closed', updatedby = 'CDM-42889', updatedon = now()
where servicecaseid = 'c669078a-3d4a-4ebd-9bd6-3ece4df9792a' and activeflag = 1;

--Updating servicecasedisposition
update servicecasedisposition
set activeflag = 0, updatedby = 'CDM-42889', updatedon = now()
where servicecasedispositionid = '091d4a9b-f357-42bb-8b7d-6370cdf51655' and activeflag = 1;

--Updating caseassignment
update caseassignment
set activeflag = 0, updatedby = 'CDM-42889', updatedon = now()
where caseassignmentid = '45264682-c85a-4acd-ab0b-bd331029a2ca' and activeflag = 1;

--Disconnecting wrong servieccase from intake and connecting it to the other servicecase
update intakeservicerequest
set servicecaseid = '7d0de276-360d-4401-8c43-5f0f1fce6c82', updatedby = 'CDM-42889', updatedon = now()
where intakeserviceid = 'f3108a1f-e534-4277-92c0-53c09e6bd823';