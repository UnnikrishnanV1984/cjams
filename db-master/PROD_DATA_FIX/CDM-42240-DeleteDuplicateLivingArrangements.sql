/*
Issue Description: User requested the Living Arrangement records in the red box
Category/Module: Bug
Root cause: A glitch caused multiple duplicate Living Arrangement requests
Fix provided: DB queries to deactivate duplicate living arrangement requests
Data/Code fix ticket#: CDM-42240
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: Data glitch
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/

--Deactivating in placement
update placement
set activeflag = 0, updatedby = 'CDM-42240', updatedon = now()
where activeflag = 1 and placementid in (
'7ac47a62-69ca-4c48-81b2-1356643f46a1',
'f5dc32b1-5e48-4217-bc65-ee5cd3a54847',
'e2d043b4-13d6-43c3-805a-0993380d786e',
'8c2417d9-008a-45bc-ab3e-31e317752e5b',
'd92187dd-92e5-4e66-9ff7-7d83bb4d40b7',
'9d0a05a6-2dd7-4adb-abde-f10da4090675');

--Deactivating in routing
update routing
set activeflag = 0, updatedby = 'CDM-42240', updatedon = now()
where activeflag = 1 and routingid in (
'45b6c856-b6f7-4403-a8c5-807db103269c',
'aff5577a-f69f-4480-a551-3e1d1ca075ce',
'b90c141f-3e3e-40f1-a59e-394c3b84ab81',
'c0737f1e-a548-426c-abeb-dc3e04cb2594',
'00138f3c-00d4-4dfb-8c5a-6e7081727803',
'336dc95f-bb34-4d93-959f-af7a5ff01042',
'f30ee990-8c0a-4202-9a01-3e53e60f48dd');