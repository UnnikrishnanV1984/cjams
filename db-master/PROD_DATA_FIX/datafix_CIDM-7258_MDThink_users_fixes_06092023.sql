-- CIDM-7258 - Contact Support Ticket Clean Up
/*
Contact Support Ticket Clean Up

-- Contact Support Ticket Clean Up to 
1) To fix the Team IDs for MD Think team members 
	
-- Category/ Module: Contact Support Ticket
-- Root cause: User Setup Issue 
-- Fix Provided: Datafix to update correct Team IDs for MD Think team members 
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- 1) CW To update correct Team IDs for MD Think team members 
/*
14662	ac56d651-8281-4754-8225-b322744b9351	Chandra Ramasamy		1	f09aa4a5-aa94-4413-8f92-c83ab5414f31	AS	MDTHINK CJAMS	452febf8-428b-4836-b8e2-9125ace6307b
13312	b941f03b-b08d-4434-83d3-d75f332f5227	Sakthi Rajan			1	171a0bef-fb3e-4675-a9eb-c7ec03e382b1	AS	MDTHINK CJAMS	452febf8-428b-4836-b8e2-9125ace6307b
14663	8f19386b-e57a-403b-a545-6557a5bf562b	Anshul Sharma			1	5ea25587-c946-4b95-9a8d-094dbd4bf3e7	AS	MDTHINK CJAMS	452febf8-428b-4836-b8e2-9125ace6307b
14664	666ea1e8-62b4-45c9-8915-23fc864305d7	Yogeswari Udhayarajan	1	b19ad743-878d-4c64-8b56-09c56c5b7094	AS	MDTHINK CJAMS	452febf8-428b-4836-b8e2-9125ace6307b
12150	90b6d637-dac7-4c60-ad73-77db847a6727	Priya Gunasekaran		0	3351243e-4032-4ffc-bb66-4ce1419cf65a	AS	MDTHINK CJAMS	452febf8-428b-4836-b8e2-9125ace6307b
12148	59c096d0-2863-447e-b391-0835c8531ff7	Vinod Erakkat			1	d76819eb-a161-4895-b452-d37407e9d923	AS	MDTHINK CJAMS	452febf8-428b-4836-b8e2-9125ace6307b
14568	45d0efc3-3220-4910-994d-b158f8bb9bd2	Madhuri Mandaloju		0	436d122a-fba3-4504-8cb3-56daf4cd5238	AS	MDTHINK CJAMS	452febf8-428b-4836-b8e2-9125ace6307b
14562	9df19efb-3082-45eb-8bd2-e75f3554524f	Feby Yanviery			1	d04704a4-1544-49ca-ac4d-292ba8a674f3	AS	MDTHINK CJAMS	452febf8-428b-4836-b8e2-9125ace6307b
14563	28e0043e-1d87-4368-a662-919698fd5ae5	Kurt Thorne				1	eae946c2-f269-4698-b35f-a2385d3b1371	AS	MDTHINK CJAMS	452febf8-428b-4836-b8e2-9125ace6307b
14565	df440102-add3-4369-8111-34a1f6a30b87	Pardha Mulakalapalli	1	08272007-fd89-4c26-9bd0-5bac61d22224	AS	MDTHINK CJAMS	452febf8-428b-4836-b8e2-9125ace6307b
15062	4e698f12-e815-44be-b28d-c5d35cabe5d6	Revathi Gundavelli		0	2fccc689-15ef-44dc-b871-f3d0083c5e21	AS	MDTHINK CJAMS	452febf8-428b-4836-b8e2-9125ace6307b
17521	b66fc456-ab70-4702-b698-db7041a4c529	Tamilarasi Sukumaran	1	99c6d9c8-bcba-43f2-805a-5d55b7db1a4f	AS	MDTHINK CJAMS	308c1de6-be27-45ee-94d8-09172c1f590f
17522	69a1eb41-f16d-4d12-b584-b6ba62c7c46a	KrishnaMohan Sankala	1	162cf961-b2f8-4a97-8869-464b23615062	AS	MDTHINK CJAMS	452febf8-428b-4836-b8e2-9125ace6307b
17523	0bca5645-47a5-4825-b693-b458c62a8ddc	Tameka Porter			1	fc536b04-bb1f-4cdf-888a-1f5428a2ed24	AS	MDTHINK CJAMS	d41dc26f-805e-4464-9228-6556b00f0cb5
23178	39ca0aee-4423-49f4-96ec-8c5807d1c07a	Srinivas Pisupati		1	faf536c8-13b5-4001-8aee-e7d3f46bbe0f	AS	MDTHINK CJAMS	452febf8-428b-4836-b8e2-9125ace6307b
*/

select teammemberid, teamid, updatedby, updatedon
from teammember 
where teammemberid 
	in ( 
			'f09aa4a5-aa94-4413-8f92-c83ab5414f31',
			'171a0bef-fb3e-4675-a9eb-c7ec03e382b1',
			'3351243e-4032-4ffc-bb66-4ce1419cf65a',
			'd76819eb-a161-4895-b452-d37407e9d923',
			'436d122a-fba3-4504-8cb3-56daf4cd5238',
			'd04704a4-1544-49ca-ac4d-292ba8a674f3',
			-- 'cc6ca081-bc35-4789-80a9-2c0cf5ed22ff',
			'99c6d9c8-bcba-43f2-805a-5d55b7db1a4f',
			'162cf961-b2f8-4a97-8869-464b23615062',
			'fc536b04-bb1f-4cdf-888a-1f5428a2ed24',
			'faf536c8-13b5-4001-8aee-e7d3f46bbe0f'
  	   )
  	 and activeflag = 1 ;

-- CW - MDTHINK CJAMS - 5da74401-a9a3-4ff3-81df-66d49be88e1c
update teammember
set teamid = '5da74401-a9a3-4ff3-81df-66d49be88e1c',
	updatedby = 'CIDM-7258-11', 
	updatedon = now() 
where teammemberid 
	in ( 
			'f09aa4a5-aa94-4413-8f92-c83ab5414f31',
			'171a0bef-fb3e-4675-a9eb-c7ec03e382b1',
			'3351243e-4032-4ffc-bb66-4ce1419cf65a',
			'd76819eb-a161-4895-b452-d37407e9d923',
			'436d122a-fba3-4504-8cb3-56daf4cd5238',
			'd04704a4-1544-49ca-ac4d-292ba8a674f3',
			-- 'cc6ca081-bc35-4789-80a9-2c0cf5ed22ff',
			'99c6d9c8-bcba-43f2-805a-5d55b7db1a4f',
			'162cf961-b2f8-4a97-8869-464b23615062',
			'fc536b04-bb1f-4cdf-888a-1f5428a2ed24',
			'faf536c8-13b5-4001-8aee-e7d3f46bbe0f'
  	   )
  	 and activeflag = 1 ;
