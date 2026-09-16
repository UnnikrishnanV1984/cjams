/*
Issue Description: For client 4460148 (ROSALEAH MONGEBURGAMY) and provider 6002642 (BLANCA DIAZ), a duplicate GAP subsidy rate slab was created.This resulted in a GAP payment being entered twice (Case ID: 3299362), leading to duplicate billing.
Category/Module: Bug
Root cause: Duplicate GAP subsidy rate slab was active due to missing validation, causing the system to generate duplicate GAP payments.
Fix provided: DB queries  update gapagreementrate tables
Data/Code fix ticket#: CJAMS-62301
Regression Impacts: N/A 
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: User Error
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/

update gapagreementrate
set activeflag = 0, updatedby ='CJAMS-62301',updatedon=now()
where gapagreementrateid ='139ff14f-9171-4304-93fc-7435465b4084' and activeflag=1;


update gapratesrevision
set activeflag = 0, updatedby ='CJAMS-62301',updatedon=now()
where gapratesrevisionid in ('b7f267e6-63b0-4c2e-9529-02d668764adf',
'f765a40b-068c-4631-b72e-56d9935467ae') and activeflag=1;

update routing
set activeflag = 0, updatedby ='CJAMS-62301',updatedon=now()
where routingid in ('a55b40de-6eeb-4afc-a9c9-f33898739f49','97ad52d2-ea4d-44a0-a733-42fe2c1484d6') and activeflag=1;
