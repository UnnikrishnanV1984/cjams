/*
Issue Description: Please remove the Client ID #202902092 only from Service Case # 241030325539 and make sure the case number is not available in the person search for the respective client ID.
Category/Module: Error
Root cause: CPS referral was incorrectly connected with service case
Fix provided: DB queries remove person from the service case
Data/Code fix ticket#: CDM-38988
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: User Error
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/

--Removing person from servicecase in actor
update actor 
set servicecaseid = null, updatedby = 'CDM-38988', updatedon = now()
where actorid = 'eb45fdaf-ea07-410d-8590-6c6f83db0a13' and activeflag = 1;

--Removing person from servicecase in intakeservicerequestactor
update intakeservicerequestactor 
set servicecaseid = null, updatedby = 'CDM-38988', updatedon = now()
where actorid = 'eb45fdaf-ea07-410d-8590-6c6f83db0a13' and activeflag = 1;

--Removing person from servicecase in personrole
update personrole 
set servicecaseid = null, updatedby = 'CDM-38988', updatedon = now()
where personroleid = 'cf02fd54-2522-48de-a1a7-b2e8617308ed' and activeflag = 1;