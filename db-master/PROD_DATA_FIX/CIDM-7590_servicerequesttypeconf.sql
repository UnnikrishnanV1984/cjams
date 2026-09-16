/*
   Issue Description: CIDM-7590
   Category/ Module  : Information and referral recommendation dropdown changes
   Root cause: 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/

Delete from cjams.servicerequesttypeconfigdispositioncode 
where servicerequesttypeconfigid = 'c4004efc-3ec2-4048-9f81-81c22a21e21c' and dispositioncode = 'Closed' and
intakeserreqstatustypeid = '642f18b0-ef6e-4d4b-9871-acc0734f3f5a' and description = 'Close Case' and insertedby = 'CIDM-7590';

INSERT INTO cjams.servicerequesttypeconfigdispositioncode
(servicerequesttypeconfigid, dispositioncode, description, intakeserreqstatustypeid, activeflag, effectivedate, expirationdate, insertedby, insertedon, updatedby, updatedon, "timestamp", isallowappeal, appealdurationdays, recommendationtype, old_id, roletypekey)
VALUES('c4004efc-3ec2-4048-9f81-81c22a21e21c', 'Closed', 'Close Case', '642f18b0-ef6e-4d4b-9871-acc0734f3f5a', 1, now(), NULL, 'CIDM-7590', now(), 'CIDM-7590', now(), NULL, false, NULL, 'Final', NULL, NULL);

UPDATE cjams.servicerequesttypeconfigdispositioncode
SET  activeflag=0, updatedby = 'CIDM-7590' , updatedon = now()
WHERE servicerequesttypeconfigid='c4004efc-3ec2-4048-9f81-81c22a21e21c' and intakeserreqstatustypeid='642f18b0-ef6e-4d4b-9871-acc0734f3f5a' and 
servicerequesttypeconfigiddispostionid in ('322daad0-67a2-4bdc-b604-c29337d1b7fd', '2d759173-aaf8-467c-9f98-5222773631ab',
'43936ccb-87eb-4903-9d3c-bb9be0016ba1','87b4a53a-08ea-41d8-9c06-1dd35fe85850', '340dd8b8-2954-48ca-ad69-b5c5ed22a69c',
'abad981c-54de-4904-86b8-42baab2b6826', '475550ad-2f63-4fe8-80b3-2c941ef840c7', '40240cdc-c0ee-4e3b-9fac-b9595d365deb');

UPDATE cjams.servicerequesttypeconfigdispositioncode
SET  activeflag=0, updatedby = 'CIDM-7590' , updatedon = now()
WHERE servicerequesttypeconfigid='c4004efc-3ec2-4048-9f81-81c22a21e21c' and intakeserreqstatustypeid='0fb08074-540f-47a6-87ed-1622288996d1' and 
servicerequesttypeconfigiddispostionid in ('8b6cf242-f63f-42e6-9dc4-0e6db64ef541', 'f70fa8f6-5436-40f5-bbc3-d3cb55e9acee',
'4f72d610-5489-48e7-9443-8edf79c05e9d','d19c0f69-c1e9-4d37-82cc-43e9a21aba9e', '31533d00-2435-4717-8a65-d9e08df3a45a',
'700d130f-2158-4732-ac65-8fbbaeeb8276', '8e0632a5-1c0e-44ed-a2f5-ab992970fe33');


