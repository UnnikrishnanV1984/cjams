-- CIDM-7181 - Contact Support: Remove the duplicate records with the same support number from supportlog table.
/*
-- Issue Description: 
    To Remove the duplicate records with the same support number from supportlog table
	
-- Category/ Module: Contact Support Ticket
-- Root cause: Code was having a flaw, which is fixed now.
-- Fix Provided: Datafix was promoted to CJAMS ticket Number in the supportlog table for Approved Tickets.
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- To Remove the duplicate records with the same support number from supportlog table (CIDM-7181)


-- Before 
-- defecttracking
select supportno, 
	count(*) 
from defecttracking.supportlog 
where activeflag = 1
	and supportno  
		in (
			'S20200209011093', 'S20210270033284', 'S20200338021018', 'S20220278044567', 'S20200227013544',
			'S20200304019547', 'S2021026023359', 'S2022090039481', 'S20200284018110', 'S2020014908225',
			'S20230118049831', 'S20220258044017', 'S202009206488', 'S2020012107132', 'S20200300019088',
			'S2020015708631', 'S20210235032257', 'S2020017409202', 'S20210306034706', 'S20210307034816',
			'S20220325045812', 'S202005105791', 'S20200253015821', 'S2020011306829', 'S2023019047325',
			'S20210270033278', 'S20200209011086', 'S20200212011710', 'S20210193030724', 'S2020013907612',
			'S20230125050093', 'S20200295018801', 'S2023019047333', 'S2022075038994', 'S202007806351',
			'S20210279033711', 'S2021040024273', 'S20200247015481', 'S20230129050184', 'S20200253015909',
			'S202001704537', 'S2023019047323', 'S2021026023357', 'S20210270033281', 'S20210306034678',
			'S2023055048293', 'S20210309034931', 'S20200281017788', 'S2019030402996', 'S20220161041520',
			'S20220291044887', 'S20230122049905', 'S20230104049414', 'S2020015008285', 'S202005605880',
			'S20210306034719', 'S2020011306820', 'S20200317020083', 'S2020011806987', 'S20200237014485',
			'S20200240014817', 'S2020011306828', 'S20210307034803', 'S20200304019547'  
			-- APS
			,'S20210306034683', 'S2022095039594', 'S2021074026061', 'S20210189030620', 'S20210300034458',
			'S20220285044717', 'S20210335035735', 'S20200293018608', 'S20210155029454', 'S20210152029248',
			'S20200310019736', 'S2021054025003', 'S20200356021943', 'S20210200031021', 'S20200345021362'
		)
group by supportno;

-- cjams
select supportno, 
	count(*) 
from cjams.supportlog 
where activeflag = 1
	and supportno  
		in (
			'S20200209011093', 'S20210270033284', 'S20200338021018', 'S20220278044567', 'S20200227013544',
			'S20200304019547', 'S2021026023359', 'S2022090039481', 'S20200284018110', 'S2020014908225',
			'S20230118049831', 'S20220258044017', 'S202009206488', 'S2020012107132', 'S20200300019088',
			'S2020015708631', 'S20210235032257', 'S2020017409202', 'S20210306034706', 'S20210307034816',
			'S20220325045812', 'S202005105791', 'S20200253015821', 'S2020011306829', 'S2023019047325',
			'S20210270033278', 'S20200209011086', 'S20200212011710', 'S20210193030724', 'S2020013907612',
			'S20230125050093', 'S20200295018801', 'S2023019047333', 'S2022075038994', 'S202007806351',
			'S20210279033711', 'S2021040024273', 'S20200247015481', 'S20230129050184', 'S20200253015909',
			'S202001704537', 'S2023019047323', 'S2021026023357', 'S20210270033281', 'S20210306034678',
			'S2023055048293', 'S20210309034931', 'S20200281017788', 'S2019030402996', 'S20220161041520',
			'S20220291044887', 'S20230122049905', 'S20230104049414', 'S2020015008285', 'S202005605880',
			'S20210306034719', 'S2020011306820', 'S20200317020083', 'S2020011806987', 'S20200237014485',
			'S20200240014817', 'S2020011306828', 'S20210307034803', 'S20200304019547'  
			-- APS
			,'S20210306034683', 'S2022095039594', 'S2021074026061', 'S20210189030620', 'S20210300034458',
			'S20220285044717', 'S20210335035735', 'S20200293018608', 'S20210155029454', 'S20210152029248',
			'S20200310019736', 'S2021054025003', 'S20200356021943', 'S20210200031021', 'S20200345021362'
		)
group by supportno;


-- Delete from defecttracking
update defecttracking.supportlog set activeflag = 0, updatedby = 'CIDM-7181', updatedon = now() where supportlogid = '21b4f536-4935-45fc-942f-ed35c468f48b'and activeflag = 1;
update defecttracking.supportlog set activeflag = 0, updatedby = 'CIDM-7181', updatedon = now() where supportlogid = 'cf16b675-b3c5-421a-8589-dea04068f19b'and activeflag = 1;
update defecttracking.supportlog set activeflag = 0, updatedby = 'CIDM-7181', updatedon = now() where supportlogid = 'f739ce2c-97af-4e90-b9a4-ec1fe90a31d6'and activeflag = 1;
update defecttracking.supportlog set activeflag = 0, updatedby = 'CIDM-7181', updatedon = now() where supportlogid = '85d5f660-8b1a-4dbc-b2e9-3e29dbcc3ac8'and activeflag = 1;
update defecttracking.supportlog set activeflag = 0, updatedby = 'CIDM-7181', updatedon = now() where supportlogid = '5d064569-6d70-4a61-a8e6-33b7e6561592'and activeflag = 1;
update defecttracking.supportlog set activeflag = 0, updatedby = 'CIDM-7181', updatedon = now() where supportlogid = '0894e6ea-839b-4870-900e-94eb8f9efc32'and activeflag = 1;
update defecttracking.supportlog set activeflag = 0, updatedby = 'CIDM-7181', updatedon = now() where supportlogid = '4c90a604-2b99-4929-ab2f-adf668ffaf41'and activeflag = 1;
update defecttracking.supportlog set activeflag = 0, updatedby = 'CIDM-7181', updatedon = now() where supportlogid = 'e293e704-3810-4d90-8173-02fcf78b90b4'and activeflag = 1;
update defecttracking.supportlog set activeflag = 0, updatedby = 'CIDM-7181', updatedon = now() where supportlogid = '71ee13cd-1474-4f2f-ba67-d509a6952298'and activeflag = 1;
update defecttracking.supportlog set activeflag = 0, updatedby = 'CIDM-7181', updatedon = now() where supportlogid = '2de89a5e-3006-48ba-ae5d-deb761da065e'and activeflag = 1;
update defecttracking.supportlog set activeflag = 0, updatedby = 'CIDM-7181', updatedon = now() where supportlogid = '7eb05bb4-3157-4d0e-ac18-d1230e88af35'and activeflag = 1;
update defecttracking.supportlog set activeflag = 0, updatedby = 'CIDM-7181', updatedon = now() where supportlogid = 'cb5c126d-6b89-43b7-a2ed-f1311732944d'and activeflag = 1;
update defecttracking.supportlog set activeflag = 0, updatedby = 'CIDM-7181', updatedon = now() where supportlogid = '8620adda-088a-4c47-8433-de95cb63b987'and activeflag = 1;
update defecttracking.supportlog set activeflag = 0, updatedby = 'CIDM-7181', updatedon = now() where supportlogid = 'f6b5c252-1608-411e-9615-f5c6d9f4931c'and activeflag = 1;
update defecttracking.supportlog set activeflag = 0, updatedby = 'CIDM-7181', updatedon = now() where supportlogid = 'fb2a4f5e-c51b-42c4-a93b-5856b325355d'and activeflag = 1;
update defecttracking.supportlog set activeflag = 0, updatedby = 'CIDM-7181', updatedon = now() where supportlogid = '8ac08515-df2b-4947-a456-92bbffae99ba'and activeflag = 1;
update defecttracking.supportlog set activeflag = 0, updatedby = 'CIDM-7181', updatedon = now() where supportlogid = 'f33cd886-922c-4090-a28a-e7635da38190'and activeflag = 1;
update defecttracking.supportlog set activeflag = 0, updatedby = 'CIDM-7181', updatedon = now() where supportlogid = '2bdf72ce-e816-45ae-a4dc-c0573cfd2f74'and activeflag = 1;
update defecttracking.supportlog set activeflag = 0, updatedby = 'CIDM-7181', updatedon = now() where supportlogid = 'dc1f0606-3e34-425c-a19f-2464a0765572'and activeflag = 1;
update defecttracking.supportlog set activeflag = 0, updatedby = 'CIDM-7181', updatedon = now() where supportlogid = '7b834983-5308-407a-8d2b-a7057907f57b'and activeflag = 1;
update defecttracking.supportlog set activeflag = 0, updatedby = 'CIDM-7181', updatedon = now() where supportlogid = 'defac587-40c2-4bc1-8a2f-6755dfd6abc5'and activeflag = 1;
update defecttracking.supportlog set activeflag = 0, updatedby = 'CIDM-7181', updatedon = now() where supportlogid = 'e946002b-789b-4589-bf36-c21b4c666871'and activeflag = 1;
update defecttracking.supportlog set activeflag = 0, updatedby = 'CIDM-7181', updatedon = now() where supportlogid = '8e558970-7593-4662-8407-4b4c7e515d97'and activeflag = 1;
update defecttracking.supportlog set activeflag = 0, updatedby = 'CIDM-7181', updatedon = now() where supportlogid = '6123acd2-f00c-455b-900a-f0cc8e3681b1'and activeflag = 1;
update defecttracking.supportlog set activeflag = 0, updatedby = 'CIDM-7181', updatedon = now() where supportlogid = '22afb36b-1483-47f6-a27d-fe02fed7cd41'and activeflag = 1;
update defecttracking.supportlog set activeflag = 0, updatedby = 'CIDM-7181', updatedon = now() where supportlogid = 'ed9877e6-1968-4e08-ba6b-b7104ec08ba0'and activeflag = 1;
update defecttracking.supportlog set activeflag = 0, updatedby = 'CIDM-7181', updatedon = now() where supportlogid = '0f9b805f-950c-4c50-8bb8-a0d3dba2b828'and activeflag = 1;
update defecttracking.supportlog set activeflag = 0, updatedby = 'CIDM-7181', updatedon = now() where supportlogid = 'c99031fa-7109-4545-90cc-a42be2ef48b3'and activeflag = 1;
update defecttracking.supportlog set activeflag = 0, updatedby = 'CIDM-7181', updatedon = now() where supportlogid = '6280a4ae-1b0b-4550-9e4a-62551eee8d52'and activeflag = 1;
update defecttracking.supportlog set activeflag = 0, updatedby = 'CIDM-7181', updatedon = now() where supportlogid = '9c7491ca-d322-4529-8dd2-8305c1b45a6f'and activeflag = 1;
update defecttracking.supportlog set activeflag = 0, updatedby = 'CIDM-7181', updatedon = now() where supportlogid = 'fadd6ca7-ce60-4c0f-959d-f784b38fcfce'and activeflag = 1;
update defecttracking.supportlog set activeflag = 0, updatedby = 'CIDM-7181', updatedon = now() where supportlogid = '8aed4bda-fcd5-4691-b851-da6e6384c465'and activeflag = 1;
update defecttracking.supportlog set activeflag = 0, updatedby = 'CIDM-7181', updatedon = now() where supportlogid = '8e676853-ed73-4b8c-943c-360451862941'and activeflag = 1;
update defecttracking.supportlog set activeflag = 0, updatedby = 'CIDM-7181', updatedon = now() where supportlogid = 'cb3f15e8-f4a7-4467-90a3-149d03aa45db'and activeflag = 1;
update defecttracking.supportlog set activeflag = 0, updatedby = 'CIDM-7181', updatedon = now() where supportlogid = '679b2c51-56e4-44bc-a6e7-9d7b18fc4b3c'and activeflag = 1;
update defecttracking.supportlog set activeflag = 0, updatedby = 'CIDM-7181', updatedon = now() where supportlogid = 'aaabc52d-7f1a-4417-b2fa-11362b5a783d'and activeflag = 1;
update defecttracking.supportlog set activeflag = 0, updatedby = 'CIDM-7181', updatedon = now() where supportlogid = 'a1c08aae-684c-4d03-b629-b5b5f06d09f3'and activeflag = 1;
update defecttracking.supportlog set activeflag = 0, updatedby = 'CIDM-7181', updatedon = now() where supportlogid = '5083f974-81f9-4d36-a05c-15fd45d22fbe'and activeflag = 1;
update defecttracking.supportlog set activeflag = 0, updatedby = 'CIDM-7181', updatedon = now() where supportlogid = 'f6afb1a5-a2c6-4ab3-8e4a-59a6ba5b0faa'and activeflag = 1;
update defecttracking.supportlog set activeflag = 0, updatedby = 'CIDM-7181', updatedon = now() where supportlogid = '4d0908ee-6e74-4d99-8adc-3db11c51698d'and activeflag = 1;
update defecttracking.supportlog set activeflag = 0, updatedby = 'CIDM-7181', updatedon = now() where supportlogid = 'a8a0a46c-e9d8-47b7-86bb-7af97abdcf80'and activeflag = 1;
update defecttracking.supportlog set activeflag = 0, updatedby = 'CIDM-7181', updatedon = now() where supportlogid = '03a3ca3c-0f62-47dd-9112-fbfce05ee2cf'and activeflag = 1;
update defecttracking.supportlog set activeflag = 0, updatedby = 'CIDM-7181', updatedon = now() where supportlogid = '0e5e52ee-5867-4a02-b0eb-34c2137c13ba'and activeflag = 1;
update defecttracking.supportlog set activeflag = 0, updatedby = 'CIDM-7181', updatedon = now() where supportlogid = '38cbe7ac-6d96-497d-aebf-34f10a92acfa'and activeflag = 1;
update defecttracking.supportlog set activeflag = 0, updatedby = 'CIDM-7181', updatedon = now() where supportlogid = '56c61134-3c5e-497c-b06e-a3f91794e6cd'and activeflag = 1;
update defecttracking.supportlog set activeflag = 0, updatedby = 'CIDM-7181', updatedon = now() where supportlogid = '4bcf8b50-56a5-466e-be4a-5b3bbe149274'and activeflag = 1;
update defecttracking.supportlog set activeflag = 0, updatedby = 'CIDM-7181', updatedon = now() where supportlogid = 'c8682cf2-35e8-40be-956e-f571d93c4aa4'and activeflag = 1;
update defecttracking.supportlog set activeflag = 0, updatedby = 'CIDM-7181', updatedon = now() where supportlogid = '21551333-1ac5-46f7-92da-7eb2f5177812'and activeflag = 1;
update defecttracking.supportlog set activeflag = 0, updatedby = 'CIDM-7181', updatedon = now() where supportlogid = '90253194-d578-490a-8f89-583a86e64503'and activeflag = 1;
update defecttracking.supportlog set activeflag = 0, updatedby = 'CIDM-7181', updatedon = now() where supportlogid = '387d5091-5bb7-43c3-8f92-9f65110b5430'and activeflag = 1;
update defecttracking.supportlog set activeflag = 0, updatedby = 'CIDM-7181', updatedon = now() where supportlogid = '56f1c8de-7041-4f0d-b0da-518c5cf1f03f'and activeflag = 1;
update defecttracking.supportlog set activeflag = 0, updatedby = 'CIDM-7181', updatedon = now() where supportlogid = '4f5137e8-cdff-4d1c-aea7-d71ae26e1dbf'and activeflag = 1;
update defecttracking.supportlog set activeflag = 0, updatedby = 'CIDM-7181', updatedon = now() where supportlogid = '062892a6-1877-4b98-b302-42fff1e15322'and activeflag = 1;
update defecttracking.supportlog set activeflag = 0, updatedby = 'CIDM-7181', updatedon = now() where supportlogid = '64991d2c-430e-4bc7-b237-09dd4461f4e7'and activeflag = 1;
update defecttracking.supportlog set activeflag = 0, updatedby = 'CIDM-7181', updatedon = now() where supportlogid = '89e6e43b-baff-430b-9748-de12631ab495'and activeflag = 1;
update defecttracking.supportlog set activeflag = 0, updatedby = 'CIDM-7181', updatedon = now() where supportlogid = '8b19458e-d1e7-4371-a193-0c59786e7ba4'and activeflag = 1;
update defecttracking.supportlog set activeflag = 0, updatedby = 'CIDM-7181', updatedon = now() where supportlogid = 'cd284307-2a8f-44bb-9ecb-5c4918445474'and activeflag = 1;
update defecttracking.supportlog set activeflag = 0, updatedby = 'CIDM-7181', updatedon = now() where supportlogid = 'b3ca1e8d-4a65-42db-98d4-7fc29cddfa08'and activeflag = 1;
update defecttracking.supportlog set activeflag = 0, updatedby = 'CIDM-7181', updatedon = now() where supportlogid = '0af4e912-f6af-4dfa-83c5-a8e962c3e992'and activeflag = 1;
update defecttracking.supportlog set activeflag = 0, updatedby = 'CIDM-7181', updatedon = now() where supportlogid = 'd5802b0e-d50b-4df6-819c-153803e42666'and activeflag = 1;
update defecttracking.supportlog set activeflag = 0, updatedby = 'CIDM-7181', updatedon = now() where supportlogid = '07dd1e46-c021-4c20-8b02-66df4f1283ab'and activeflag = 1;
update defecttracking.supportlog set activeflag = 0, updatedby = 'CIDM-7181', updatedon = now() where supportlogid = '6bd3d079-6bf4-4026-9d4c-acad1644a8d2'and activeflag = 1;
update defecttracking.supportlog set activeflag = 0, updatedby = 'CIDM-7181', updatedon = now() where supportlogid = '33d803dc-2d6b-4864-87fb-80f8c0daa3ed'and activeflag = 1;
update defecttracking.supportlog set activeflag = 0, updatedby = 'CIDM-7181', updatedon = now() where supportlogid = '32916314-6fa0-4302-a0ed-760ca392f3ac'and activeflag = 1;
update defecttracking.supportlog set activeflag = 0, updatedby = 'CIDM-7181', updatedon = now() where supportlogid = '3cba2e42-f2c8-4270-8084-36d0ca3f89fa'and activeflag = 1;
update defecttracking.supportlog set activeflag = 0, updatedby = 'CIDM-7181', updatedon = now() where supportlogid = '52d3367e-c85a-4a88-8ef0-d8f2ac6cfb1e'and activeflag = 1;
update defecttracking.supportlog set activeflag = 0, updatedby = 'CIDM-7181', updatedon = now() where supportlogid = 'bfcb7e8e-a6da-4da1-8082-f3402deaf45d'and activeflag = 1;
update defecttracking.supportlog set activeflag = 0, updatedby = 'CIDM-7181', updatedon = now() where supportlogid = 'd671ec76-06ef-435c-8e9b-2d30cf2a598e'and activeflag = 1;
update defecttracking.supportlog set activeflag = 0, updatedby = 'CIDM-7181', updatedon = now() where supportlogid = '158e5588-125b-4c3a-ab47-694e455b37ab'and activeflag = 1;
update defecttracking.supportlog set activeflag = 0, updatedby = 'CIDM-7181', updatedon = now() where supportlogid = '32230086-7388-4e48-8507-76b76f0fc34f'and activeflag = 1;
update defecttracking.supportlog set activeflag = 0, updatedby = 'CIDM-7181', updatedon = now() where supportlogid = 'fd6e09e8-e53c-43f9-a50d-4e9e127891ef'and activeflag = 1;
update defecttracking.supportlog set activeflag = 0, updatedby = 'CIDM-7181', updatedon = now() where supportlogid = '901c0b62-74a8-45c2-88ad-e120f9b603d0'and activeflag = 1;
update defecttracking.supportlog set activeflag = 0, updatedby = 'CIDM-7181', updatedon = now() where supportlogid = '2e895906-29c3-45ef-b5cf-4c5849085e24'and activeflag = 1;
update defecttracking.supportlog set activeflag = 0, updatedby = 'CIDM-7181', updatedon = now() where supportlogid = 'd9110302-f535-4270-97bd-38ce43fa0148'and activeflag = 1;
update defecttracking.supportlog set activeflag = 0, updatedby = 'CIDM-7181', updatedon = now() where supportlogid = 'd2ed79bf-cf4c-4372-ac02-c6e787e61e8f'and activeflag = 1;
update defecttracking.supportlog set activeflag = 0, updatedby = 'CIDM-7181', updatedon = now() where supportlogid = 'bdb00e85-40cf-4537-b919-ec1fafbe752e'and activeflag = 1;
update defecttracking.supportlog set activeflag = 0, updatedby = 'CIDM-7181', updatedon = now() where supportlogid = 'd48d0522-7d7a-4dbb-b761-1c62d97b72af'and activeflag = 1;


-- Delete APS
/*
5074aad9-bda0-4410-aa6d-147d61f29a18	S20200293018608	CJAMS-9548	1 - Keep
d9ec2c1d-6eff-454b-8128-6529c58af9a1	S20200293018608	CJAMS-9633	2
63dd5a0a-f05d-47f3-b81b-1fa283065308	S20200293018608	CJAMS-9634	3

37fd036c-b77d-4663-bbf5-9f05d3e555c2	S20200345021362	CJAMS-11971	1
d9bb9802-b36f-4e77-91cb-53e2ea0bb6c4	S20200345021362	CJAMS-11972	2 - Keep

70b07c68-5525-4617-8913-151f381e602b	S20200356021943	CJAMS-15349	1 - Keep
a2cbf7a4-b4a9-42b3-91e4-db86b1f8a7af	S20200356021943	CJAMS-15347	2

a79c187e-5f3a-41b7-a8fe-2b05185eafae	S2021054025003	CJAMS-15599	1 - Keep
205ce89d-6e46-403a-92c9-966246e60cd9	S2021054025003	CJAMS-15147	2

*/


-- from cjams
update cjams.supportlog set activeflag = 0, updatedby = 'CIDM-7181', updatedon = now() where supportlogid = 'd9ec2c1d-6eff-454b-8128-6529c58af9a1'and activeflag = 1;
update cjams.supportlog set activeflag = 0, updatedby = 'CIDM-7181', updatedon = now() where supportlogid = '63dd5a0a-f05d-47f3-b81b-1fa283065308'and activeflag = 1;
update cjams.supportlog set activeflag = 0, updatedby = 'CIDM-7181', updatedon = now() where supportlogid = '9e1b251d-bcf1-4b20-9261-669a0e64e78c'and activeflag = 1;
update cjams.supportlog set activeflag = 0, updatedby = 'CIDM-7181', updatedon = now() where supportlogid = '37fd036c-b77d-4663-bbf5-9f05d3e555c2'and activeflag = 1;
update cjams.supportlog set activeflag = 0, updatedby = 'CIDM-7181', updatedon = now() where supportlogid = 'a2cbf7a4-b4a9-42b3-91e4-db86b1f8a7af'and activeflag = 1;
update cjams.supportlog set activeflag = 0, updatedby = 'CIDM-7181', updatedon = now() where supportlogid = '20b345fe-231f-47bf-9d45-8960a8bd4208'and activeflag = 1;
update cjams.supportlog set activeflag = 0, updatedby = 'CIDM-7181', updatedon = now() where supportlogid = '7ebfc827-2a99-4da6-b05d-4351288966bf'and activeflag = 1;
update cjams.supportlog set activeflag = 0, updatedby = 'CIDM-7181', updatedon = now() where supportlogid = '86c80dc9-7fa0-4b41-bd64-e86b5ecf17a4'and activeflag = 1;
update cjams.supportlog set activeflag = 0, updatedby = 'CIDM-7181', updatedon = now() where supportlogid = '19b0b97d-d9f9-4a02-83a0-a5fee4a66f28'and activeflag = 1;
update cjams.supportlog set activeflag = 0, updatedby = 'CIDM-7181', updatedon = now() where supportlogid = '6473554d-9fae-4646-982b-67cdf8d2e9fd'and activeflag = 1;
update cjams.supportlog set activeflag = 0, updatedby = 'CIDM-7181', updatedon = now() where supportlogid = 'e644ef10-5df0-4434-ba85-297cf1deb7bd'and activeflag = 1;
update cjams.supportlog set activeflag = 0, updatedby = 'CIDM-7181', updatedon = now() where supportlogid = '474676ce-92a4-4d85-8c6a-785ca746550c'and activeflag = 1;
update cjams.supportlog set activeflag = 0, updatedby = 'CIDM-7181', updatedon = now() where supportlogid = 'e862ef7e-4b04-45e0-867a-cfe4a7a5df8a'and activeflag = 1;
update cjams.supportlog set activeflag = 0, updatedby = 'CIDM-7181', updatedon = now() where supportlogid = '7e76ffbf-9ba1-41e4-aef1-64aee6fea878'and activeflag = 1;
update cjams.supportlog set activeflag = 0, updatedby = 'CIDM-7181', updatedon = now() where supportlogid = '205ce89d-6e46-403a-92c9-966246e60cd9'and activeflag = 1;
update cjams.supportlog set activeflag = 0, updatedby = 'CIDM-7181', updatedon = now() where supportlogid = '3e3af488-9238-4205-adc6-9b1664a04204'and activeflag = 1;
update cjams.supportlog set activeflag = 0, updatedby = 'CIDM-7181', updatedon = now() where supportlogid = '111c56ec-f3e3-4a21-b62a-919daa491a28'and activeflag = 1;
update cjams.supportlog set activeflag = 0, updatedby = 'CIDM-7181', updatedon = now() where supportlogid = 'af0efae6-724f-4e7c-a778-9dff530357f9'and activeflag = 1;

-- from defecttracking
update defecttracking.supportlog set activeflag = 0, updatedby = 'CIDM-7181', updatedon = now() where supportlogid = 'd9ec2c1d-6eff-454b-8128-6529c58af9a1'and activeflag = 1;
update defecttracking.supportlog set activeflag = 0, updatedby = 'CIDM-7181', updatedon = now() where supportlogid = '63dd5a0a-f05d-47f3-b81b-1fa283065308'and activeflag = 1;
update defecttracking.supportlog set activeflag = 0, updatedby = 'CIDM-7181', updatedon = now() where supportlogid = '9e1b251d-bcf1-4b20-9261-669a0e64e78c'and activeflag = 1;
update defecttracking.supportlog set activeflag = 0, updatedby = 'CIDM-7181', updatedon = now() where supportlogid = '37fd036c-b77d-4663-bbf5-9f05d3e555c2'and activeflag = 1;
update defecttracking.supportlog set activeflag = 0, updatedby = 'CIDM-7181', updatedon = now() where supportlogid = 'a2cbf7a4-b4a9-42b3-91e4-db86b1f8a7af'and activeflag = 1;
update defecttracking.supportlog set activeflag = 0, updatedby = 'CIDM-7181', updatedon = now() where supportlogid = '20b345fe-231f-47bf-9d45-8960a8bd4208'and activeflag = 1;
update defecttracking.supportlog set activeflag = 0, updatedby = 'CIDM-7181', updatedon = now() where supportlogid = '7ebfc827-2a99-4da6-b05d-4351288966bf'and activeflag = 1;
update defecttracking.supportlog set activeflag = 0, updatedby = 'CIDM-7181', updatedon = now() where supportlogid = '86c80dc9-7fa0-4b41-bd64-e86b5ecf17a4'and activeflag = 1;
update defecttracking.supportlog set activeflag = 0, updatedby = 'CIDM-7181', updatedon = now() where supportlogid = '19b0b97d-d9f9-4a02-83a0-a5fee4a66f28'and activeflag = 1;
update defecttracking.supportlog set activeflag = 0, updatedby = 'CIDM-7181', updatedon = now() where supportlogid = '6473554d-9fae-4646-982b-67cdf8d2e9fd'and activeflag = 1;
update defecttracking.supportlog set activeflag = 0, updatedby = 'CIDM-7181', updatedon = now() where supportlogid = 'e644ef10-5df0-4434-ba85-297cf1deb7bd'and activeflag = 1;
update defecttracking.supportlog set activeflag = 0, updatedby = 'CIDM-7181', updatedon = now() where supportlogid = '474676ce-92a4-4d85-8c6a-785ca746550c'and activeflag = 1;
update defecttracking.supportlog set activeflag = 0, updatedby = 'CIDM-7181', updatedon = now() where supportlogid = 'e862ef7e-4b04-45e0-867a-cfe4a7a5df8a'and activeflag = 1;
update defecttracking.supportlog set activeflag = 0, updatedby = 'CIDM-7181', updatedon = now() where supportlogid = '7e76ffbf-9ba1-41e4-aef1-64aee6fea878'and activeflag = 1;
update defecttracking.supportlog set activeflag = 0, updatedby = 'CIDM-7181', updatedon = now() where supportlogid = '205ce89d-6e46-403a-92c9-966246e60cd9'and activeflag = 1;
update defecttracking.supportlog set activeflag = 0, updatedby = 'CIDM-7181', updatedon = now() where supportlogid = '3e3af488-9238-4205-adc6-9b1664a04204'and activeflag = 1;
update defecttracking.supportlog set activeflag = 0, updatedby = 'CIDM-7181', updatedon = now() where supportlogid = '111c56ec-f3e3-4a21-b62a-919daa491a28'and activeflag = 1;
update defecttracking.supportlog set activeflag = 0, updatedby = 'CIDM-7181', updatedon = now() where supportlogid = 'af0efae6-724f-4e7c-a778-9dff530357f9'and activeflag = 1;

-- After
-- defecttracking
select supportno, 
	count(*) 
from defecttracking.supportlog 
where activeflag = 1
	and supportno  
		in (
			'S20200209011093', 'S20210270033284', 'S20200338021018', 'S20220278044567', 'S20200227013544',
			'S20200304019547', 'S2021026023359', 'S2022090039481', 'S20200284018110', 'S2020014908225',
			'S20230118049831', 'S20220258044017', 'S202009206488', 'S2020012107132', 'S20200300019088',
			'S2020015708631', 'S20210235032257', 'S2020017409202', 'S20210306034706', 'S20210307034816',
			'S20220325045812', 'S202005105791', 'S20200253015821', 'S2020011306829', 'S2023019047325',
			'S20210270033278', 'S20200209011086', 'S20200212011710', 'S20210193030724', 'S2020013907612',
			'S20230125050093', 'S20200295018801', 'S2023019047333', 'S2022075038994', 'S202007806351',
			'S20210279033711', 'S2021040024273', 'S20200247015481', 'S20230129050184', 'S20200253015909',
			'S202001704537', 'S2023019047323', 'S2021026023357', 'S20210270033281', 'S20210306034678',
			'S2023055048293', 'S20210309034931', 'S20200281017788', 'S2019030402996', 'S20220161041520',
			'S20220291044887', 'S20230122049905', 'S20230104049414', 'S2020015008285', 'S202005605880',
			'S20210306034719', 'S2020011306820', 'S20200317020083', 'S2020011806987', 'S20200237014485',
			'S20200240014817', 'S2020011306828', 'S20210307034803', 'S20200304019547'  
			-- APS
			,'S20210306034683', 'S2022095039594', 'S2021074026061', 'S20210189030620', 'S20210300034458',
			'S20220285044717', 'S20210335035735', 'S20200293018608', 'S20210155029454', 'S20210152029248',
			'S20200310019736', 'S2021054025003', 'S20200356021943', 'S20210200031021', 'S20200345021362'
		)
group by supportno;


-- cjams
select supportno, 
	count(*) 
from cjams.supportlog 
where activeflag = 1
	and supportno  
		in (
			'S20200209011093', 'S20210270033284', 'S20200338021018', 'S20220278044567', 'S20200227013544',
			'S20200304019547', 'S2021026023359', 'S2022090039481', 'S20200284018110', 'S2020014908225',
			'S20230118049831', 'S20220258044017', 'S202009206488', 'S2020012107132', 'S20200300019088',
			'S2020015708631', 'S20210235032257', 'S2020017409202', 'S20210306034706', 'S20210307034816',
			'S20220325045812', 'S202005105791', 'S20200253015821', 'S2020011306829', 'S2023019047325',
			'S20210270033278', 'S20200209011086', 'S20200212011710', 'S20210193030724', 'S2020013907612',
			'S20230125050093', 'S20200295018801', 'S2023019047333', 'S2022075038994', 'S202007806351',
			'S20210279033711', 'S2021040024273', 'S20200247015481', 'S20230129050184', 'S20200253015909',
			'S202001704537', 'S2023019047323', 'S2021026023357', 'S20210270033281', 'S20210306034678',
			'S2023055048293', 'S20210309034931', 'S20200281017788', 'S2019030402996', 'S20220161041520',
			'S20220291044887', 'S20230122049905', 'S20230104049414', 'S2020015008285', 'S202005605880',
			'S20210306034719', 'S2020011306820', 'S20200317020083', 'S2020011806987', 'S20200237014485',
			'S20200240014817', 'S2020011306828', 'S20210307034803', 'S20200304019547'  
			-- APS
			,'S20210306034683', 'S2022095039594', 'S2021074026061', 'S20210189030620', 'S20210300034458',
			'S20220285044717', 'S20210335035735', 'S20200293018608', 'S20210155029454', 'S20210152029248',
			'S20200310019736', 'S2021054025003', 'S20200356021943', 'S20210200031021', 'S20200345021362'
		)
group by supportno;

-- S20200304019547
-- Delete 38c64ecb-b0c7-43ea-9299-73dca729052b

select application, 
	supportno, 
	supportlogid, 
	insertedon,
	jirarequestno,
	activeflag, 
	updatedby,
	updatedon 
from defecttracking.supportlog
where supportlogid = '38c64ecb-b0c7-43ea-9299-73dca729052b'
	and activeflag  = 1 ; 

update defecttracking.supportlog 
set activeflag = 0, 
	updatedby = 'CIDM-7181',
	updatedon = now()
where supportlogid = '38c64ecb-b0c7-43ea-9299-73dca729052b'
	and activeflag = 1 ; 
