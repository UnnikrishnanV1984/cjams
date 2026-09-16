-- CIDM-8010 - Removals/Placements Data Cleanup (AFCARS 2.0 2023A submission)
/*
-- Issue Description: 
	Datafixes:
	1) Provider placements associated with the wrong person's removal (sibling from the same case).
	2) Provider placements associated with the prior old child removal.
	3) Provider placement is associated with the soft-deleted removal.
	4) Active Child Removals with returntransts* column NOT Null
		* System date when the child removal was exited in CJAMS

-- Category/ Module: AFCARS (AFCARS Federal reporting) 
-- Root cause: CJAMS Child Removal & Provider Placement Data Issues. 
-- Fix Provided: Datafix has been promoted to fix the Child Removal & Provider Placement Data Issues.
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- Fixes
-- Active Child Removals with returntransts NOT Null
select intakeservreqchildremovalid, removalid, 
	removaldate, removaltransts, exitdate, returntransts,
	activeflag, updatedby, updatedon  
from intakeservreqchildremoval 
where activeflag = 1
	and exitdate is null
	and returntransts is not null ;
	
update intakeservreqchildremoval
set returntransts = NULL,
	updatedby = 'CIDM-8010',
	updatedon = now()
where activeflag = 1
	and exitdate is null
	and returntransts is not null ;
	

-- Provider placement is associated with the soft-deleted removal.	

-- Active Removal Found - START

update placement set intakeservreqchildremovalid = 'e84ff2a5-ebd1-44ce-9136-5276c3eae13b', updatedby = 'CIDM-8010', updatedon = now() where alternateid = 46201 and activeflag = 1 ;
update placement set intakeservreqchildremovalid = '8f4b1d17-90ae-45f2-b44a-1192c8940934', updatedby = 'CIDM-8010', updatedon = now() where alternateid = 226017 and activeflag = 1 ;
update placement set intakeservreqchildremovalid = 'bb51ef2e-7f8f-436e-b3c2-dc864912a65a', updatedby = 'CIDM-8010', updatedon = now() where alternateid = 226016 and activeflag = 1 ;
update placement set intakeservreqchildremovalid = '8f4b1d17-90ae-45f2-b44a-1192c8940934', updatedby = 'CIDM-8010', updatedon = now() where alternateid = 226018 and activeflag = 1 ;
update placement set intakeservreqchildremovalid = '8ea44dd4-c96b-47e8-bfff-85843c841a64', updatedby = 'CIDM-8010', updatedon = now() where alternateid = 245941 and activeflag = 1 ;
update placement set intakeservreqchildremovalid = '1d692927-e959-4497-8f88-367f02514d31', updatedby = 'CIDM-8010', updatedon = now() where alternateid = 240041 and activeflag = 1 ;
update placement set intakeservreqchildremovalid = 'cb3205a1-338a-43d4-aed6-f4cf5aa72ed0', updatedby = 'CIDM-8010', updatedon = now() where alternateid = 231081 and activeflag = 1 ;
update placement set intakeservreqchildremovalid = '40c5593d-1f07-4eea-bb4c-bea019905b21', updatedby = 'CIDM-8010', updatedon = now() where alternateid = 247244 and activeflag = 1 ;
update placement set intakeservreqchildremovalid = '40c5593d-1f07-4eea-bb4c-bea019905b21', updatedby = 'CIDM-8010', updatedon = now() where alternateid = 247241 and activeflag = 1 ;
update placement set intakeservreqchildremovalid = '40c5593d-1f07-4eea-bb4c-bea019905b21', updatedby = 'CIDM-8010', updatedon = now() where alternateid = 247243 and activeflag = 1 ;
update placement set intakeservreqchildremovalid = '43dc998a-d413-4525-b0c9-e9debcbd11d4', updatedby = 'CIDM-8010', updatedon = now() where alternateid = 237922 and activeflag = 1 ;
update placement set intakeservreqchildremovalid = '7251ca5d-ae94-4c5c-9329-6d0d3722ec71', updatedby = 'CIDM-8010', updatedon = now() where alternateid = 1558790 and activeflag = 1 ;
update placement set intakeservreqchildremovalid = 'ac3e3958-a075-4853-8368-fed74da34c73', updatedby = 'CIDM-8010', updatedon = now() where alternateid = 237923 and activeflag = 1 ;
update placement set intakeservreqchildremovalid = '43234790-d0cd-43ec-9606-064224641efd', updatedby = 'CIDM-8010', updatedon = now() where alternateid = 335351 and activeflag = 1 ;
update placement set intakeservreqchildremovalid = '43234790-d0cd-43ec-9606-064224641efd', updatedby = 'CIDM-8010', updatedon = now() where alternateid = 329296 and activeflag = 1 ;
update placement set intakeservreqchildremovalid = '43234790-d0cd-43ec-9606-064224641efd', updatedby = 'CIDM-8010', updatedon = now() where alternateid = 329852 and activeflag = 1 ;
update placement set intakeservreqchildremovalid = '27af110b-056f-4c9b-9b9d-65ce69e3b3b7', updatedby = 'CIDM-8010', updatedon = now() where alternateid = 245727 and activeflag = 1 ;
update placement set intakeservreqchildremovalid = '46989b22-ec26-4b5c-9201-a11ecca4722f', updatedby = 'CIDM-8010', updatedon = now() where alternateid = 247702 and activeflag = 1 ;
update placement set intakeservreqchildremovalid = '7f66016c-91a8-4d2c-b0a2-44422882e1ae', updatedby = 'CIDM-8010', updatedon = now() where alternateid = 247701 and activeflag = 1 ;
update placement set intakeservreqchildremovalid = '2ef87e7b-aabd-4479-a543-e1f0f10f8123', updatedby = 'CIDM-8010', updatedon = now() where alternateid = 339901 and activeflag = 1 ;
update placement set intakeservreqchildremovalid = '6f1eccad-8921-44be-84dd-6dc236d16128', updatedby = 'CIDM-8010', updatedon = now() where alternateid = 1557619 and activeflag = 1 ;
update placement set intakeservreqchildremovalid = '7b02ed6b-2a2d-44d6-9d4f-b73eb39465db', updatedby = 'CIDM-8010', updatedon = now() where alternateid = 1560606 and activeflag = 1 ;
update placement set intakeservreqchildremovalid = 'fadc4c49-7ae3-4e27-844c-32471a85ab72', updatedby = 'CIDM-8010', updatedon = now() where alternateid = 339357 and activeflag = 1 ;
update placement set intakeservreqchildremovalid = '1bc7a4b9-aa27-41f9-840e-95a9b5cdde37', updatedby = 'CIDM-8010', updatedon = now() where alternateid = 340040 and activeflag = 1 ;
update placement set intakeservreqchildremovalid = '1bc7a4b9-aa27-41f9-840e-95a9b5cdde37', updatedby = 'CIDM-8010', updatedon = now() where alternateid = 340864 and activeflag = 1 ;
update placement set intakeservreqchildremovalid = '099f56a7-d2b3-4133-9a9d-f431645753bd', updatedby = 'CIDM-8010', updatedon = now() where alternateid = 1557116 and activeflag = 1 ;
update placement set intakeservreqchildremovalid = '61c51b87-97f3-4966-b026-f2654d178086', updatedby = 'CIDM-8010', updatedon = now() where alternateid = 1560088 and activeflag = 1 ;
update placement set intakeservreqchildremovalid = 'efe5dd31-6b45-4058-b924-665473370f93', updatedby = 'CIDM-8010', updatedon = now() where alternateid = 330380 and activeflag = 1 ;
update placement set intakeservreqchildremovalid = 'efe5dd31-6b45-4058-b924-665473370f93', updatedby = 'CIDM-8010', updatedon = now() where alternateid = 1401070 and activeflag = 1 ;
update placement set intakeservreqchildremovalid = 'ebfca9f3-d831-46e1-b292-c326f2b45f22', updatedby = 'CIDM-8010', updatedon = now() where alternateid = 1533664 and activeflag = 1 ;
update placement set intakeservreqchildremovalid = 'ebfca9f3-d831-46e1-b292-c326f2b45f22', updatedby = 'CIDM-8010', updatedon = now() where alternateid = 1533663 and activeflag = 1 ;
update placement set intakeservreqchildremovalid = '064ed1da-2daa-49ff-8f83-6946d950eb51', updatedby = 'CIDM-8010', updatedon = now() where alternateid = 328448 and activeflag = 1 ;
update placement set intakeservreqchildremovalid = '1663f735-adc8-4ca0-ae85-fddb51da6b85', updatedby = 'CIDM-8010', updatedon = now() where alternateid = 319708 and activeflag = 1 ;
update placement set intakeservreqchildremovalid = '8d40c858-ff8a-41f7-8889-c5fa61655fb6', updatedby = 'CIDM-8010', updatedon = now() where alternateid = 1559132 and activeflag = 1 ;
update placement set intakeservreqchildremovalid = '5e4cf945-6889-482e-b068-a16d5a507e59', updatedby = 'CIDM-8010', updatedon = now() where alternateid = 338791 and activeflag = 1 ;
update placement set intakeservreqchildremovalid = '98137a86-8ef9-4e4b-9cca-4718c47d79f1', updatedby = 'CIDM-8010', updatedon = now() where alternateid = 1533638 and activeflag = 1 ;

-- Active Removal Found - End


-- Placement Start date is before Removal Entry or 	Placement End date is after Removal Exit - START

update placement set intakeservreqchildremovalid = 'c7ac6dac-c35f-4ec0-be1f-28fd0f44f4df', updatedby = 'CIDM-8010', updatedon = now() where alternateid = 85100 and activeflag = 1 ;
update placement set intakeservreqchildremovalid = '72dc55e5-b1ff-4eb2-b7f8-56cad808d8f7', updatedby = 'CIDM-8010', updatedon = now() where alternateid = 84219 and activeflag = 1 ;
update placement set intakeservreqchildremovalid = 'd95bdf8f-55e1-4523-9998-a0d72f41eec4', updatedby = 'CIDM-8010', updatedon = now() where alternateid = 84613 and activeflag = 1 ;
update placement set intakeservreqchildremovalid = '513910f7-d31b-48c2-9dcb-86d5044c6e26', updatedby = 'CIDM-8010', updatedon = now() where alternateid = 203967 and activeflag = 1 ;
update placement set intakeservreqchildremovalid = 'a45e00e7-b07a-44e8-952b-6308a7681403', updatedby = 'CIDM-8010', updatedon = now() where alternateid = 205385 and activeflag = 1 ;
update placement set intakeservreqchildremovalid = '78af3798-2bb6-42cd-b0bd-37a4976eb471', updatedby = 'CIDM-8010', updatedon = now() where alternateid = 223602 and activeflag = 1 ;
update placement set intakeservreqchildremovalid = '38e21b8d-34d0-4067-beef-e83cc1fa7c4a', updatedby = 'CIDM-8010', updatedon = now() where alternateid = 235242 and activeflag = 1 ;
update placement set intakeservreqchildremovalid = '38e21b8d-34d0-4067-beef-e83cc1fa7c4a', updatedby = 'CIDM-8010', updatedon = now() where alternateid = 237213 and activeflag = 1 ;
update placement set intakeservreqchildremovalid = 'feb7f93a-558d-40de-83b6-d45c88de2b1c', updatedby = 'CIDM-8010', updatedon = now() where alternateid = 195536 and activeflag = 1 ;
update placement set intakeservreqchildremovalid = 'e150e90a-511b-4194-be4f-3a734f5fdfd8', updatedby = 'CIDM-8010', updatedon = now() where alternateid = 204973 and activeflag = 1 ;
update placement set intakeservreqchildremovalid = '730f64ea-e709-42b5-8cbb-3121beff0578', updatedby = 'CIDM-8010', updatedon = now() where alternateid = 254912 and activeflag = 1 ;
update placement set intakeservreqchildremovalid = 'fa94abed-ac25-4d57-8565-e7974b1dbd0d', updatedby = 'CIDM-8010', updatedon = now() where alternateid = 339507 and activeflag = 1 ;
update placement set intakeservreqchildremovalid = '4463ab75-3abd-4e04-8e90-58d9570dd0d5', updatedby = 'CIDM-8010', updatedon = now() where alternateid = 1571652 and activeflag = 1 ;
update placement set intakeservreqchildremovalid = 'b8e94fb8-f2e2-4cd1-bde4-7c6873b281bf', updatedby = 'CIDM-8010', updatedon = now() where alternateid = 234008 and activeflag = 1 ;
update placement set intakeservreqchildremovalid = 'b2154a68-b854-4ef9-84bf-262ec80b4b6e', updatedby = 'CIDM-8010', updatedon = now() where alternateid = 1572666 and activeflag = 1 ;
update placement set intakeservreqchildremovalid = '2a066b27-4018-44fa-b973-43e716e6f7c2', updatedby = 'CIDM-8010', updatedon = now() where alternateid = 1623777 and activeflag = 1 ;
update placement set intakeservreqchildremovalid = '59c81145-6a4c-4c00-a07d-3a514b0e2802', updatedby = 'CIDM-8010', updatedon = now() where alternateid = 339100 and activeflag = 1 ;
update placement set intakeservreqchildremovalid = '518e2708-9b0e-4d4c-bd10-4dd080ab9022', updatedby = 'CIDM-8010', updatedon = now() where alternateid = 1568024 and activeflag = 1 ;
update placement set intakeservreqchildremovalid = '0da6aa62-e0a2-4427-a606-2da1c15247fe', updatedby = 'CIDM-8010', updatedon = now() where alternateid = 1562394 and activeflag = 1 ;
update placement set intakeservreqchildremovalid = 'f1cfa750-13df-4faf-a6da-7a99e2473be4', updatedby = 'CIDM-8010', updatedon = now() where alternateid = 1568023 and activeflag = 1 ;
update placement set intakeservreqchildremovalid = 'dcbb76b1-a466-46e3-8705-faaee9260d3e', updatedby = 'CIDM-8010', updatedon = now() where alternateid = 1562402 and activeflag = 1 ;
update placement set intakeservreqchildremovalid = '01b6ed01-5d7b-461d-ba2e-07e9239020db', updatedby = 'CIDM-8010', updatedon = now() where alternateid = 1558541 and activeflag = 1 ;
update placement set intakeservreqchildremovalid = 'f7d168bc-fc0d-413c-a998-7788200b7a9b', updatedby = 'CIDM-8010', updatedon = now() where alternateid = 1573428 and activeflag = 1 ;
update placement set intakeservreqchildremovalid = '0707d8ad-b994-4378-bbd6-361be1d969c0', updatedby = 'CIDM-8010', updatedon = now() where alternateid = 1572452 and activeflag = 1 ;

-- Placement Start date is before Removal Entry or 	Placement End date is after Removal Exit - END	

-- Placement & Removal Person ID mismatch error - START 

update placement set intakeservreqchildremovalid = 'dc5eb587-98c2-4e5f-82e3-fe91288eab08', updatedby = 'CIDM-8010', updatedon = now() where alternateid = 1566162 and activeflag = 1 ;
update placement set intakeservreqchildremovalid = 'dc5eb587-98c2-4e5f-82e3-fe91288eab08', updatedby = 'CIDM-8010', updatedon = now() where alternateid = 1566161 and activeflag = 1 ;
update placement set intakeservreqchildremovalid = '8c7c6ddc-48c3-4bde-b309-5c77f3b08d6e', updatedby = 'CIDM-8010', updatedon = now() where alternateid = 1567333 and activeflag = 1 ;
update placement set intakeservreqchildremovalid = '76fab922-1c02-4faf-b012-246df0d24936', updatedby = 'CIDM-8010', updatedon = now() where alternateid = 1567372 and activeflag = 1 ;
update placement set intakeservreqchildremovalid = '78fedddb-eb6e-4c99-ab17-aece285eda27', updatedby = 'CIDM-8010', updatedon = now() where alternateid = 1565938 and activeflag = 1 ;
update placement set intakeservreqchildremovalid = '322e0049-25d5-4d21-aca4-b5972a8bf08b', updatedby = 'CIDM-8010', updatedon = now() where alternateid = 1565004 and activeflag = 1 ;
update placement set intakeservreqchildremovalid = '12ef83fa-dd3b-40a3-9bf9-7851760f0f8f', updatedby = 'CIDM-8010', updatedon = now() where alternateid = 1566463 and activeflag = 1 ;
update placement set intakeservreqchildremovalid = 'f24a7492-356d-4f1e-b3aa-a75e95a97e5f', updatedby = 'CIDM-8010', updatedon = now() where alternateid = 1565211 and activeflag = 1 ;
update placement set intakeservreqchildremovalid = '9917d918-a0bb-4522-a53d-5453c21912bf', updatedby = 'CIDM-8010', updatedon = now() where alternateid = 1565303 and activeflag = 1 ;
update placement set intakeservreqchildremovalid = '0a711b90-aec9-4dd8-8fab-43bd3c377ad8', updatedby = 'CIDM-8010', updatedon = now() where alternateid = 1564512 and activeflag = 1 ;
update placement set intakeservreqchildremovalid = '0a711b90-aec9-4dd8-8fab-43bd3c377ad8', updatedby = 'CIDM-8010', updatedon = now() where alternateid = 1564511 and activeflag = 1 ;
update placement set intakeservreqchildremovalid = '0a711b90-aec9-4dd8-8fab-43bd3c377ad8', updatedby = 'CIDM-8010', updatedon = now() where alternateid = 1564510 and activeflag = 1 ;
update placement set intakeservreqchildremovalid = '0a711b90-aec9-4dd8-8fab-43bd3c377ad8', updatedby = 'CIDM-8010', updatedon = now() where alternateid = 1564690 and activeflag = 1 ;
update placement set intakeservreqchildremovalid = '607eba14-bd74-4cb4-b303-9219a1655b27', updatedby = 'CIDM-8010', updatedon = now() where alternateid = 1566040 and activeflag = 1 ;
update placement set intakeservreqchildremovalid = '203f416a-462a-4d91-980c-8615e999ab7f', updatedby = 'CIDM-8010', updatedon = now() where alternateid = 1564908 and activeflag = 1 ;
update placement set intakeservreqchildremovalid = '203f416a-462a-4d91-980c-8615e999ab7f', updatedby = 'CIDM-8010', updatedon = now() where alternateid = 1564907 and activeflag = 1 ;
update placement set intakeservreqchildremovalid = '408b3111-b25d-4915-ad4b-d1a26b1f5332', updatedby = 'CIDM-8010', updatedon = now() where alternateid = 1565125 and activeflag = 1 ;
update placement set intakeservreqchildremovalid = '89095f24-7b3a-45c1-9e57-7b961e1669e4', updatedby = 'CIDM-8010', updatedon = now() where alternateid = 1564343 and activeflag = 1 ;
update placement set intakeservreqchildremovalid = 'b9ac59d6-0a0a-46b3-8733-2e129bacaff3', updatedby = 'CIDM-8010', updatedon = now() where alternateid = 1565955 and activeflag = 1 ;
update placement set intakeservreqchildremovalid = '77cc8566-b4b3-4dc7-b0c1-87be344b0783', updatedby = 'CIDM-8010', updatedon = now() where alternateid = 1564501 and activeflag = 1 ;
update placement set intakeservreqchildremovalid = 'd3e93dce-3c50-4fff-80e4-36280c08c37b', updatedby = 'CIDM-8010', updatedon = now() where alternateid = 1567833 and activeflag = 1 ;
update placement set intakeservreqchildremovalid = '94c5bd02-b756-45a1-9bed-15e05cb6ada6', updatedby = 'CIDM-8010', updatedon = now() where alternateid = 1563916 and activeflag = 1 ;
update placement set intakeservreqchildremovalid = '2ebe421a-152e-4a64-8bdc-87e2cd3c36d2', updatedby = 'CIDM-8010', updatedon = now() where alternateid = 1564006 and activeflag = 1 ;
update placement set intakeservreqchildremovalid = 'c5cdf02e-98d5-47e8-81ab-c3ef16f23037', updatedby = 'CIDM-8010', updatedon = now() where alternateid = 1566192 and activeflag = 1 ;
update placement set intakeservreqchildremovalid = 'c5cdf02e-98d5-47e8-81ab-c3ef16f23037', updatedby = 'CIDM-8010', updatedon = now() where alternateid = 1566193 and activeflag = 1 ;
update placement set intakeservreqchildremovalid = '80f0c2f0-5ed9-4da4-a747-2ea88f93d92e', updatedby = 'CIDM-8010', updatedon = now() where alternateid = 1564569 and activeflag = 1 ;
update placement set intakeservreqchildremovalid = '3f6a3cdc-530d-4c05-ac8b-0b0cb970e375', updatedby = 'CIDM-8010', updatedon = now() where alternateid = 1567507 and activeflag = 1 ;
update placement set intakeservreqchildremovalid = '76a01997-1c8f-41d8-93cb-07b22d85c675', updatedby = 'CIDM-8010', updatedon = now() where alternateid = 1567873 and activeflag = 1 ;
update placement set intakeservreqchildremovalid = 'fc988294-de61-4817-ab6b-6aced46c1c21', updatedby = 'CIDM-8010', updatedon = now() where alternateid = 1565510 and activeflag = 1 ;
update placement set intakeservreqchildremovalid = 'bb329548-3678-4896-82a2-353a580fcf5a', updatedby = 'CIDM-8010', updatedon = now() where alternateid = 1566919 and activeflag = 1 ;
update placement set intakeservreqchildremovalid = '6bf565e7-bbd3-460e-b7fe-e5e2deee60e2', updatedby = 'CIDM-8010', updatedon = now() where alternateid = 1563838 and activeflag = 1 ;
update placement set intakeservreqchildremovalid = 'a0d732fd-309f-486c-87f9-0df2498e51ea', updatedby = 'CIDM-8010', updatedon = now() where alternateid = 1567065 and activeflag = 1 ;
update placement set intakeservreqchildremovalid = 'ef977238-f755-46ba-ae28-666b3a87851f', updatedby = 'CIDM-8010', updatedon = now() where alternateid = 1566323 and activeflag = 1 ;
update placement set intakeservreqchildremovalid = 'a0f70add-0150-4aff-97b0-a8e48b2432c0', updatedby = 'CIDM-8010', updatedon = now() where alternateid = 1565760 and activeflag = 1 ;

-- Placement & Removal Person ID mismatch error - END

-- Manual Fixes
-- 251860	2021-04-01 	2021-04-13
update placement 
set intakeservreqchildremovalid = 'fb5db60e-3d56-4ddc-b54b-b245d3c2054b', 
	updatedby = 'CIDM-8010', 
	updatedon = now() 
where alternateid = 1562350
	and activeflag = 1 ;
	
update intakeservreqchildremoval
set activeflag = 1,
	updatedby = 'CIDM-8010',
	updatedon = now()
where intakeservreqchildremovalid = 'fb5db60e-3d56-4ddc-b54b-b245d3c2054b'
	and activeflag = 0 ;
	

-- 154717	2012-05-24 00:00:00	2014-04-01 00:00:00
update intakeservreqchildremoval
set activeflag = 1,
	updatedby = 'CIDM-8010',
	updatedon = now()
where intakeservreqchildremovalid = '23e31608-c1f4-4b71-8056-28a5e156b6bf'
	and activeflag = 0 ;
	
-- 121839	2009-10-23 00:00:00	2011-10-31 00:00:00	
update intakeservreqchildremoval
set activeflag = 1,
	updatedby = 'CIDM-8010',
	updatedon = now()
where intakeservreqchildremovalid = 'd9e4fe6c-530f-452a-9306-685e74c89c2d'
	and activeflag = 0 ;

