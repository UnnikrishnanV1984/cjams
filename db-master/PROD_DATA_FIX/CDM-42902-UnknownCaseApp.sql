/*
Issue: Service case created without connected to an intake and no person available under the Person tab.
Category/Module:data Error
Root cause: This case was created on 10/28/2024 by user wanda.collins@maryland.gov, but am unsure about how it was created. Possibly a data glitch.
Fix provided: DB queries to deactivate service case
Data/Code fix ticket#: CDM-42902
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: data Error
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/

--Deactivating in servicecase
update servicecase
set activeflag = 0, updatedby = 'CDM-42902', updatedon = now()
where servicecaseid = 'c678236a-d800-4b5c-96b6-316bd8905892' and activeflag = 1;

--Deactivating in servicecasedisposition
update servicecasedisposition
set activeflag = 0, updatedby = 'CDM-42902', updatedon = now()
where servicecasedispositionid = '569beb89-f9e0-4eeb-a49d-389eb00a4b71' and activeflag = 1;

--Deactivating in caseassignment
update caseassignment
set activeflag = 0, updatedby = 'CDM-42902', updatedon = now()
where objectid = 'c678236a-d800-4b5c-96b6-316bd8905892' and activeflag = 1;

--Deactivating in routing
update routing
set activeflag = 0, updatedby = 'CDM-42902', updatedon = now()
where objectid = 'c678236a-d800-4b5c-96b6-316bd8905892' and activeflag = 1;