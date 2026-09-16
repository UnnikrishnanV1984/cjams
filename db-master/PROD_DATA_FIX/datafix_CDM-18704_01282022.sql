-- CDM-18704 - Wrong Kid
/*
-- Issue Description: 
   Cjams is adding permanency plan under wrong kid... 
   Correct kid is check before completing permanency plan.
   
-- Case ID: 3277242 - 10801b7c-ec64-445f-afca-49ca4c9b3690
-- Correct Client ID: 3625223 (STEVEN C	JONES) - 221120f1-0cf1-402e-b8ed-105273b43eea
-- Wrong Client ID: 4093584 (BELLA SKYE OWENS) - e6b3ea23-7dac-4ce3-8f84-c2bf21c816a7
   
-- Category/ Module: Permanency Plan (Case Management)
-- Root cause: TBD
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: TBD
*/

-- update intakeservicerequestactorid as 26dc9ca2-5c39-44c3-939c-8fa792ce3aed
-- permanencyplanid
-- 0ec2c8e4-ea5b-458a-9cb2-62f87f172307
select permanencyplanid, intakeservicerequestactorid, updatedby, updatedon, servicecaseid
	from cjams.permanencyplan
where permanencyplanid = '0ec2c8e4-ea5b-458a-9cb2-62f87f172307'
	and activeflag = 1 ;

update cjams.permanencyplan 
set intakeservicerequestactorid = '26dc9ca2-5c39-44c3-939c-8fa792ce3aed',
	updatedby = 'CDM-18704',
	updatedon = now()
where permanencyplanid = '0ec2c8e4-ea5b-458a-9cb2-62f87f172307'
	and activeflag = 1 ;

-- Delete 
-- permanencyplanid
-- 500a9737-6621-403b-ab8e-a568a26a4bc1
-- 8cc9c70e-8f30-4305-a414-05aac0122e64
-- b676b45b-bedc-4c52-9138-e9f5a1bfe0fb
-- 2c99369c-b9d8-4b54-b8e4-7c37899d5b51
-- b8ea1369-ab0c-4846-a7d6-0beadbfd19fb
-- 92b3feae-cb07-41f8-a6d8-8d15b6244f6b
-- c9c13c37-e8af-4091-8110-c4625baf2ff7

select permanencyplanid, intakeservicerequestactorid, updatedby, updatedon, servicecaseid
	from cjams.permanencyplan
where permanencyplanid 
	in (	'500a9737-6621-403b-ab8e-a568a26a4bc1',
			'8cc9c70e-8f30-4305-a414-05aac0122e64',
			'b676b45b-bedc-4c52-9138-e9f5a1bfe0fb',
			'2c99369c-b9d8-4b54-b8e4-7c37899d5b51',
			'b8ea1369-ab0c-4846-a7d6-0beadbfd19fb',
			'92b3feae-cb07-41f8-a6d8-8d15b6244f6b',
			'c9c13c37-e8af-4091-8110-c4625baf2ff7'
		) 
	and activeflag  = 1 ;

update cjams.permanencyplan 
set activeflag = 0,
	updatedby = 'CDM-18704',
	updatedon = now()
where permanencyplanid 
	in (	'500a9737-6621-403b-ab8e-a568a26a4bc1',
			'8cc9c70e-8f30-4305-a414-05aac0122e64',
			'b676b45b-bedc-4c52-9138-e9f5a1bfe0fb',
			'2c99369c-b9d8-4b54-b8e4-7c37899d5b51',
			'b8ea1369-ab0c-4846-a7d6-0beadbfd19fb',
			'92b3feae-cb07-41f8-a6d8-8d15b6244f6b',
			'c9c13c37-e8af-4091-8110-c4625baf2ff7'
		) 
	and activeflag  = 1 ;
	
-- No Changes	
-- Approved Permanency Plan for Client ID: 4093584 (BELLA SKYE OWENS)
-- permanencyplanid
-- 116a15d4-0fd2-45b5-8d8e-39a13cb5f27f
