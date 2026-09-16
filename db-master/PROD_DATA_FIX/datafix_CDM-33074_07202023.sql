-- CDM-33074 - CLONE - No Alleged Maltreator or Investigation Findings in closed case
/*
--	Issue Description: 
	Data celanup for the CPS cases with misisng Alleged Maltreator
    
-- Category/ Module: Adoption Subsidy (Case Management) 
--	Root cause: TBD 
		One possibility is this is related to the issue of person role updates in Service case is causing missing person in CPS case. 
		Other scenario is CJAMS is currently allowing the users to remove the client’s Alleged Maltreator role even after submitting the request to close the CPS case. And we don’t have any validation on the supervisory approval side to check for at least one Maltreatment Allegation and Investigation Finding prior to approve the case.
-- Fix Provided: Datafix has been promoted to fix all impacted CPS cases with misisng Alleged Maltreator
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- Data celanup for the CPS cases with misisng Alleged Maltreator (CDM-33074)
update intakeservicerequestactor set activeflag = 1, isprimary = FALSE, updatedby = 'CDM-33074', updatedon = now() where intakeservicerequestactorid = '820f1a7d-479b-47be-b0c0-2e02e9972189' and activeflag = 0 ;
update intakeservicerequestactor set activeflag = 1, isprimary = FALSE, updatedby = 'CDM-33074', updatedon = now() where intakeservicerequestactorid = 'b22f0de8-de70-407a-a1f5-4871fb68ee9b' and activeflag = 0 ;
update intakeservicerequestactor set activeflag = 1, updatedby = 'CDM-33074', updatedon = now() where intakeservicerequestactorid = '8c79e5ff-f0ae-482a-9bcc-5165e0e3b07a' and activeflag = 0 ;
update intakeservicerequestactor set activeflag = 1, updatedby = 'CDM-33074', updatedon = now() where intakeservicerequestactorid = '7d83b5f2-e26c-4e65-b96b-13d386bfd51f' and activeflag = 0 ;
update intakeservicerequestactor set activeflag = 1, isprimary = FALSE, updatedby = 'CDM-33074', updatedon = now() where intakeservicerequestactorid = 'e4ff884a-3be4-4e0c-80cd-20295af41e53' and activeflag = 0 ;
update intakeservicerequestactor set activeflag = 1, isprimary = FALSE, updatedby = 'CDM-33074', updatedon = now() where intakeservicerequestactorid = '7df9da40-4e98-4df6-8162-912a3e9e9e5f' and activeflag = 0 ;
update intakeservicerequestactor set activeflag = 1, isprimary = FALSE, updatedby = 'CDM-33074', updatedon = now() where intakeservicerequestactorid = '97e9fcee-55b5-429d-bc85-1fc811c1580a' and activeflag = 0 ;
update intakeservicerequestactor set activeflag = 1, updatedby = 'CDM-33074', updatedon = now() where intakeservicerequestactorid = 'f294fd68-1f7f-46a4-99c4-e017e782bd19' and activeflag = 0 ;
update intakeservicerequestactor set activeflag = 1, isprimary = FALSE, updatedby = 'CDM-33074', updatedon = now() where intakeservicerequestactorid = '10c1155f-e353-4c86-a2d6-80cc6e5ca02d' and activeflag = 0 ;
update intakeservicerequestactor set activeflag = 1, isprimary = FALSE, updatedby = 'CDM-33074', updatedon = now() where intakeservicerequestactorid = '649d1cee-c6cf-4475-9357-ce4542f334f7' and activeflag = 0 ;
update intakeservicerequestactor set activeflag = 1, isprimary = FALSE, updatedby = 'CDM-33074', updatedon = now() where intakeservicerequestactorid = '495a3077-dee7-448e-846f-15b1c471087b' and activeflag = 0 ;
update intakeservicerequestactor set activeflag = 1, updatedby = 'CDM-33074', updatedon = now() where intakeservicerequestactorid = '13b39e3c-6ca9-49b8-9838-2afd8f5e602b' and activeflag = 0 ;
update intakeservicerequestactor set activeflag = 1, isprimary = FALSE, updatedby = 'CDM-33074', updatedon = now() where intakeservicerequestactorid = '9942f506-f75b-4792-aae2-dc320922f730' and activeflag = 0 ;
update intakeservicerequestactor set activeflag = 1, updatedby = 'CDM-33074', updatedon = now() where intakeservicerequestactorid = '6f18fcb4-67ff-4c4d-bcb1-c30e4d56e610' and activeflag = 0 ;
update intakeservicerequestactor set activeflag = 1, isprimary = FALSE, updatedby = 'CDM-33074', updatedon = now() where intakeservicerequestactorid = '8b046402-5ea1-4610-a853-0d861e89d3e4' and activeflag = 0 ;
update intakeservicerequestactor set activeflag = 1, isprimary = FALSE, updatedby = 'CDM-33074', updatedon = now() where intakeservicerequestactorid = 'fbb00183-b800-4729-8a88-514df12090e7' and activeflag = 0 ;
update intakeservicerequestactor set activeflag = 1, isprimary = FALSE, updatedby = 'CDM-33074', updatedon = now() where intakeservicerequestactorid = 'c88a511f-5fd4-4412-a893-83fce381fa57' and activeflag = 0 ;
update intakeservicerequestactor set activeflag = 1, isprimary = FALSE, updatedby = 'CDM-33074', updatedon = now() where intakeservicerequestactorid = 'fcb68e3a-3cd7-486b-9ec9-dd9ff8832d5b' and activeflag = 0 ;
update intakeservicerequestactor set activeflag = 1, isprimary = FALSE, updatedby = 'CDM-33074', updatedon = now() where intakeservicerequestactorid = '285166d2-4652-4a0f-b850-8d4ce7bfd472' and activeflag = 0 ;
update intakeservicerequestactor set activeflag = 1, isprimary = FALSE, updatedby = 'CDM-33074', updatedon = now() where intakeservicerequestactorid = 'c5362f40-6f43-4345-b198-46bbc298be3e' and activeflag = 0 ;
update intakeservicerequestactor set activeflag = 1, isprimary = FALSE, updatedby = 'CDM-33074', updatedon = now() where intakeservicerequestactorid = '0939ff34-1ff9-4653-af06-954c3b5dfa8a' and activeflag = 0 ;
update intakeservicerequestactor set activeflag = 1, isprimary = FALSE, updatedby = 'CDM-33074', updatedon = now() where intakeservicerequestactorid = '4284c2df-fc24-4848-a639-3a0adcc3c70f' and activeflag = 0 ;
update intakeservicerequestactor set activeflag = 1, isprimary = FALSE, updatedby = 'CDM-33074', updatedon = now() where intakeservicerequestactorid = 'b2b38e0a-06ef-4a1a-9f11-a0a3d5dc434d' and activeflag = 0 ;
update intakeservicerequestactor set activeflag = 1, updatedby = 'CDM-33074', updatedon = now() where intakeservicerequestactorid = '59615737-4e0e-4848-b4d8-f1612d9d0fa0' and activeflag = 0 ;
update intakeservicerequestactor set activeflag = 1, isprimary = FALSE, updatedby = 'CDM-33074', updatedon = now() where intakeservicerequestactorid = '1b8529dd-da9b-48a9-b07f-a3a8e3e3d263' and activeflag = 0 ;
update intakeservicerequestactor set activeflag = 1, isprimary = FALSE, updatedby = 'CDM-33074', updatedon = now() where intakeservicerequestactorid = '72e72411-edce-4ce4-aae6-2ba326fab1e2' and activeflag = 0 ;
update intakeservicerequestactor set activeflag = 1, isprimary = FALSE, updatedby = 'CDM-33074', updatedon = now() where intakeservicerequestactorid = 'de361264-5421-499b-bca8-8a2891e169b2' and activeflag = 0 ;
update intakeservicerequestactor set activeflag = 1, isprimary = FALSE, updatedby = 'CDM-33074', updatedon = now() where intakeservicerequestactorid = 'fad0f7da-8ded-4244-a99a-1fc221951d1c' and activeflag = 0 ;
update intakeservicerequestactor set activeflag = 1, isprimary = FALSE, updatedby = 'CDM-33074', updatedon = now() where intakeservicerequestactorid = '375ec9b1-f4fb-40d3-86c5-e08552f9402b' and activeflag = 0 ;
update intakeservicerequestactor set activeflag = 1, isprimary = FALSE, updatedby = 'CDM-33074', updatedon = now() where intakeservicerequestactorid = '9412d73e-a5d3-4254-8f81-70dd040c6d4b' and activeflag = 0 ;
update intakeservicerequestactor set activeflag = 1, isprimary = FALSE, updatedby = 'CDM-33074', updatedon = now() where intakeservicerequestactorid = 'ec7b9c4c-bbfb-4392-9da8-5353a33978ee' and activeflag = 0 ;
update intakeservicerequestactor set activeflag = 1, isprimary = FALSE, updatedby = 'CDM-33074', updatedon = now() where intakeservicerequestactorid = '9b065f8b-dc5d-4884-bb45-36ca9e041f84' and activeflag = 0 ;
update intakeservicerequestactor set activeflag = 1, updatedby = 'CDM-33074', updatedon = now() where intakeservicerequestactorid = 'b855d479-7c19-4163-9e1b-081afee7aa47' and activeflag = 0 ;
update intakeservicerequestactor set activeflag = 1, isprimary = FALSE, updatedby = 'CDM-33074', updatedon = now() where intakeservicerequestactorid = '5e296201-b4a3-4cce-82a7-28a13bd177cc' and activeflag = 0 ;
update intakeservicerequestactor set activeflag = 1, updatedby = 'CDM-33074', updatedon = now() where intakeservicerequestactorid = 'dc57510b-68ba-4be3-ab9c-ea231ceacec8' and activeflag = 0 ;
update intakeservicerequestactor set activeflag = 1, isprimary = FALSE, updatedby = 'CDM-33074', updatedon = now() where intakeservicerequestactorid = '978fc834-99f7-4265-b851-690c8736de28' and activeflag = 0 ;
update intakeservicerequestactor set activeflag = 1, isprimary = FALSE, updatedby = 'CDM-33074', updatedon = now() where intakeservicerequestactorid = '96189d12-5bd6-4624-bb70-7745b1c7c5a1' and activeflag = 0 ;
update intakeservicerequestactor set activeflag = 1, isprimary = TRUE, updatedby = 'CDM-33074', updatedon = now() where intakeservicerequestactorid = '32a1d617-101d-4adf-a606-a95b9e12b989' and activeflag = 0 ;
update intakeservicerequestactor set activeflag = 1, updatedby = 'CDM-33074', updatedon = now() where intakeservicerequestactorid = '1ae4e010-22ad-4bed-b78b-116fc9705aee' and activeflag = 0 ;
update intakeservicerequestactor set activeflag = 1, isprimary = FALSE, updatedby = 'CDM-33074', updatedon = now() where intakeservicerequestactorid = '623efb95-65e9-4313-a7d1-47634d19815c' and activeflag = 0 ;
update intakeservicerequestactor set activeflag = 1, updatedby = 'CDM-33074', updatedon = now() where intakeservicerequestactorid = '4d7af3c4-4bd4-4ede-a412-36ff90ccb146' and activeflag = 0 ;
update intakeservicerequestactor set activeflag = 1, updatedby = 'CDM-33074', updatedon = now() where intakeservicerequestactorid = 'fba5e9e0-1350-4f78-b831-f22309d6fc47' and activeflag = 0 ;
update intakeservicerequestactor set activeflag = 1, updatedby = 'CDM-33074', updatedon = now() where intakeservicerequestactorid = '264ac8b6-bc43-4311-8e70-5f3cca1208e7' and activeflag = 0 ;
update intakeservicerequestactor set activeflag = 1, updatedby = 'CDM-33074', updatedon = now() where intakeservicerequestactorid = '0700c79d-ae9a-41eb-b614-9729fe740eed' and activeflag = 0 ;
update intakeservicerequestactor set activeflag = 1, isprimary = FALSE, updatedby = 'CDM-33074', updatedon = now() where intakeservicerequestactorid = '38ad786c-4b28-4eb4-aab4-3364e8ecf039' and activeflag = 0 ;
update intakeservicerequestactor set activeflag = 1, updatedby = 'CDM-33074', updatedon = now() where intakeservicerequestactorid = 'dfa63785-155f-4494-95b6-94adb2ed2f76' and activeflag = 0 ;
update intakeservicerequestactor set activeflag = 1, updatedby = 'CDM-33074', updatedon = now() where intakeservicerequestactorid = '18c67ed9-8d5c-44f6-bb2d-27e040df805a' and activeflag = 0 ;
update intakeservicerequestactor set activeflag = 1, updatedby = 'CDM-33074', updatedon = now() where intakeservicerequestactorid = 'f1f1cb86-5f88-4c19-864c-8e0541a9ed4e' and activeflag = 0 ;
update intakeservicerequestactor set activeflag = 1, updatedby = 'CDM-33074', updatedon = now() where intakeservicerequestactorid = '59fe265e-b60e-48a9-ad8c-145d933cbe09' and activeflag = 0 ;
update intakeservicerequestactor set activeflag = 1, isprimary = FALSE, updatedby = 'CDM-33074', updatedon = now() where intakeservicerequestactorid = '65608f23-635c-47ed-885a-0f7e18621311' and activeflag = 0 ;
update intakeservicerequestactor set activeflag = 1, updatedby = 'CDM-33074', updatedon = now() where intakeservicerequestactorid = 'c18144b2-77e6-432f-a780-b85999b9d791' and activeflag = 0 ;
update intakeservicerequestactor set activeflag = 1, updatedby = 'CDM-33074', updatedon = now() where intakeservicerequestactorid = '7b84fee3-ee29-4011-a099-68094f5e802e' and activeflag = 0 ;

-- CPS-IR	20200157020420	10721457	PAULA  MUNIZ 
update intakeservicerequestactor set activeflag = 1, updatedby = 'CDM-33074', updatedon = now() 
where intakeservicerequestactorid = '4def1031-cf4b-4ec1-bb41-67d1b2a0f9d5' and activeflag = 0 ;
	
-- CPS-IR	2021056085126	4415541	HANNAH  CHANEY 
-- update intakeservicerequestactor set activeflag = 1, isprimary = FALSE, updatedby = 'CDM-33074', updatedon = now() where intakeservicerequestactorid = '4cdf3d82-a64e-4618-913b-8ce28f9a5f3b' and activeflag = 0 ;
-- update intakeservicerequestactor set activeflag = 1, isprimary = FALSE, updatedby = 'CDM-33074', updatedon = now() where intakeservicerequestactorid = 'db3fdf74-cecc-459a-bfc4-c2acd9ab9eff' and activeflag = 0 ;

-- CPS-IR	211020161588	4172004	DANIELLE OPHEL SCRUGGS 
-- update intakeservicerequestactor set activeflag = 1, isprimary = FALSE, updatedby = 'CDM-33074', updatedon = now() where intakeservicerequestactorid = 'ac9a10e5-771a-40fa-acb9-38d72f5564eb' and activeflag = 0 ;	

-- CPS-IR	221020246684	200948016	Yaneiri  Corado Matute 
-- update intakeservicerequestactor set activeflag = 1, updatedby = 'CDM-33074', updatedon = now() where intakeservicerequestactorid = '9f51cd48-280f-4bc6-a63a-37943bbc55d5' and activeflag = 0 ;

-- CPS-IR	20200287041554	200159824	Chistopher  Thornton 
-- update intakeservicerequestactor set activeflag = 1, updatedby = 'CDM-33074', updatedon = now() where intakeservicerequestactorid = 'cb69a1b5-8232-4a5d-93b6-2f53de06e4d7' and activeflag = 0 ;
-- update intakeservicerequestactor set activeflag = 1, isprimary = FALSE, updatedby = 'CDM-33074', updatedon = now() where intakeservicerequestactorid = 'c7aea1ad-c6bb-4db3-ba4a-b67c8792ccc2' and activeflag = 0 ;

-- CPS-IR	202101260107596	200664873	Kadiatu  Turay 
-- update intakeservicerequestactor set activeflag = 1, isprimary = FALSE, updatedby = 'CDM-33074', updatedon = now() where intakeservicerequestactorid = 'e62e94a6-1692-4a3e-b1bf-ce9fafb23cd5' and activeflag = 0 ;
-- update intakeservicerequestactor set activeflag = 1, updatedby = 'CDM-33074', updatedon = now() where intakeservicerequestactorid = 'ffc78e3a-ad14-4e96-a28e-292cd66dfc38' and activeflag = 0 ;

-- CPS-IR	20200244032184	200157409	Melissa  Clement 
-- update intakeservicerequestactor set activeflag = 1, isprimary = FALSE, updatedby = 'CDM-33074', updatedon = now() where intakeservicerequestactorid = 'cef2874b-0b46-47c7-ade2-d85906e114dc' and activeflag = 0 ;

-- CPS-IR	221020270634	200976970	John  Torres 
-- update intakeservicerequestactor set activeflag = 1, updatedby = 'CDM-33074', updatedon = now() where intakeservicerequestactorid = '4656de8c-b3c6-42e5-b745-983e593b4c65' and activeflag = 0 ;

-- CPS-IR	20200289042550	4039318	ROSA E ALVARADO 
-- update intakeservicerequestactor set activeflag = 1, isprimary = FALSE, updatedby = 'CDM-33074', updatedon = now() where intakeservicerequestactorid = '2b119af8-67f8-4615-b634-11489d9915ba' and activeflag = 0 ;

-- CPS-IR	20200216027131	1726971	RICKY L BAREISS 
-- update intakeservicerequestactor set activeflag = 1, isprimary = FALSE, updatedby = 'CDM-33074', updatedon = now() where intakeservicerequestactorid = '9d20ab9f-b593-44d3-952b-45427df07e5d' and activeflag = 0 ;

-- CPS-IR	20200293043482	200161737	Mueenuddin  Ahmed 
-- update intakeservicerequestactor set activeflag = 1, updatedby = 'CDM-33074', updatedon = now() where intakeservicerequestactorid = '03511aa4-039f-4f09-be01-17e3d5ecd5e8' and activeflag = 0 ;

-- CPS-IR	20200304047795	1659774	TAVARUS G LONG 
-- update intakeservicerequestactor set activeflag = 1, isprimary = FALSE, updatedby = 'CDM-33074', updatedon = now() where intakeservicerequestactorid = 'e7bba28d-917f-4869-b510-1ec3a65e0a3e' and activeflag = 0 ;

-- CPS-IR	20200174021983	1271331	SAMANTHA L DAVIS 
-- update intakeservicerequestactor set activeflag = 1, isprimary = FALSE, updatedby = 'CDM-33074', updatedon = now() where intakeservicerequestactorid = 'b533a974-8b68-4210-b90d-248b54d054d8' and activeflag = 0 ;

-- CPS-IR	20200311050414	200169326	kiaonna  jones 
-- update intakeservicerequestactor set activeflag = 1, isprimary = FALSE, updatedby = 'CDM-33074', updatedon = now() where intakeservicerequestactorid = 'bf25f752-77a7-41e6-b16a-f21fb0558034' and activeflag = 0 ;

-- CPS-IR	211020119984	4370373	CASAUNDRA  BRIDGES 
-- update intakeservicerequestactor set activeflag = 1, isprimary = FALSE, updatedby = 'CDM-33074', updatedon = now() where intakeservicerequestactorid = 'e1e9030f-b07c-4ce6-8c2d-bacfc6819326' and activeflag = 0 ;

-- CPS-IR	211020119510	3896072	DANDRE A HARRIS 
-- update intakeservicerequestactor set activeflag = 1, isprimary = FALSE, updatedby = 'CDM-33074', updatedon = now() where intakeservicerequestactorid = '044648e1-d3bf-410f-aba4-585d29d89dd6' and activeflag = 0 ;

-- CPS-IR	211020114584	200672187	Ka'desha   Gamble 
-- update intakeservicerequestactor set activeflag = 1, isprimary = FALSE, updatedby = 'CDM-33074', updatedon = now() where intakeservicerequestactorid = '7ab0641b-0c01-42da-99f0-e8527ec7a212' and activeflag = 0 ;

-- CPS-IR	211020152650	200176990	Keisha DUPLICATE Simmons 
-- update intakeservicerequestactor set activeflag = 1, isprimary = FALSE, updatedby = 'CDM-33074', updatedon = now() where intakeservicerequestactorid = 'ef44c84d-e2f6-4470-a1a9-a4b0a7a8a724' and activeflag = 0 ;

-- CPS-AR	CW2955390	1173116	JACLYN M LINKOUS 
-- update intakeservicerequestactor set activeflag = 1, updatedby = 'CDM-33074', updatedon = now() where intakeservicerequestactorid = '55175591-b9f0-463c-952c-0c8c6d0dd20b' and activeflag = 0 ;

-- CPS-AR	231020530097	201231786	Unknown  Whistler 
-- update intakeservicerequestactor set activeflag = 1, updatedby = 'CDM-33074', updatedon = now() where intakeservicerequestactorid = '67acbf60-9ae4-4d98-ba3e-d3f6a2928405' and activeflag = 0 ;

-- CPS-IR	221020208908	1754301	CIERRA  COSTELLO 
-- update intakeservicerequestactor set activeflag = 1, isprimary = FALSE, updatedby = 'CDM-33074', updatedon = now() where intakeservicerequestactorid = '9a81e54a-50ea-47a4-b0e9-858c74ea58e6' and activeflag = 0 ;

/*
-- CPS-IR 221020270634 - 200976970 John Torres is having 2 records with isprimary = true
select isprimary, intakenumber, intakeserviceid, servicecaseid, activeflag, updatedby, updatedon
	from intakeservicerequestactor a1
where intakeservicerequestactorid = '852a0ce4-3177-49b1-a8d7-8b2c30283543'
	and activeflag = 1
	and ( select count(*)
			from intakeservicerequestactor a2
		  where a2.actorid = a1.actorid	
			and a2.activeflag = 1
			and a2.isprimary = true
		) > 0;
		
update intakeservicerequestactor a1
set activeflag = 0,
	updatedby = 'CDM-33074',
	updatedon = now()
where intakeservicerequestactorid = '852a0ce4-3177-49b1-a8d7-8b2c30283543'
	and activeflag = 1 
	and ( select count(*)
			from intakeservicerequestactor a2
		  where a2.actorid = a1.actorid	
			and a2.activeflag = 1
			and a2.isprimary = true
		) > 0;
*/

