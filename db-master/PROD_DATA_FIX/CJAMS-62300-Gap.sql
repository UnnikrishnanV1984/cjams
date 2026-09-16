/*
Issue Description: For Client ID: 3469336 (ISABELLA WALLACE)Provider ID: 5054980 (Dana Hunt) a duplicate GAP subsidy rate slab was created.This resulted in a GAP payment being entered twice  leading to duplicate billing.
Category/Module: Bug
Root cause: Duplicate GAP subsidy rate slab was active due to missing validation, causing the system to generate duplicate GAP payments.
Fix provided: DB queries  update gapagreementrate tables
Data/Code fix ticket#: CJAMS-62300
Regression Impacts: N/A 
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: User Error
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/


update gapagreementrate
set activeflag = 0, updatedby ='CJAMS-62300',updatedon=now()
where gapagreementrateid ='dc1ed3b0-2b02-42fb-8f7c-cf2a2b30ddd0' and activeflag=1;


update gapratesrevision
set activeflag = 0, updatedby ='CJAMS-62300',updatedon=now()
where gapratesrevisionid in('d2441fcd-d932-4e7c-b867-366c1e068d4e',
'd76c60ed-ccc8-4797-9ad1-7b8d670ad98d') and activeflag=1;

update routing
set activeflag = 0, updatedby ='CJAMS-62300',updatedon=now()
where routingid in ('5ffa8df0-2f47-47d8-8b62-e672c90c9368','af4f5692-8af7-425e-832f-8434c8ab50f7') and activeflag=1;
