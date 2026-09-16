/*
Issue Description: Need technical investigation to remove the duplicate subsidy rate without a subsidy rate in DB, and remove the 2025 - 2026 subsidy rate slab as requested.
Category/Module: Glitch
Root cause: Data glitch caused a duplicate subsidy rate approval record to appear
Fix provided: DB queries to deactivate duplicate the subsidy rate approval record
Data/Code fix ticket#: CDM-42969
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: Data error, cannot replicate the issue
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/

--Deactivating duplicate record in adoptionagreementrate
update adoptionagreementrate
set activeflag = 0, updatedby = 'CDM-42969', updatedon = now()
where adoptionagreementrateid = '860c4532-30c4-4514-a990-21b3629032b0' and activeflag = 1;

--Deactivating duplicate record in adoptionagreementraterevision
update adoptionagreementraterevision
set activeflag = 0, updatedby = 'CDM-42969', updatedon = now()
where adoptionagreementraterevisionid = 'c02eaf09-54fa-45f4-ac0d-cbfc1bb9bcb8' and activeflag = 1;

--Deactivating duplicate record in routing
update routing
set activeflag = 0, updatedby = 'CDM-42969', updatedon = now()
where routingid = 'd4b2a3ce-b917-40aa-8c65-be60494c4b9a' and activeflag = 1;