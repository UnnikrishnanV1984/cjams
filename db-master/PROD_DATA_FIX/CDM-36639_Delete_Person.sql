/*
   Issue Description: CDM-36639 - Delete Person Card
   2020035104845:There are 2 Madison Stewarts. Please delete cjams # 200297128 and keep # 200810461.
   Root cause: User Error. Wrong person addedd to case.
   Case#: 2020035104845 (servicecaseid: af91f846-245e-4afd-9ab2-041c98472e4a)
   Person to be deleted from case: 200297128 (c0abbc13-87d1-4e5a-9e5e-e1c73ffffe6f)
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
   Need to do data fix: Data fix to remove the approval request record.
*/


select * from intakeservicerequestactor 
	where personid = 'c0abbc13-87d1-4e5a-9e5e-e1c73ffffe6f' 
		and servicecaseid = 'af91f846-245e-4afd-9ab2-041c98472e4a'
		and activeflag = 1;
		
update cjams.intakeservicerequestactor  
	set activeflag = 0,
		updatedon = now(),
		updatedby = 'CDM-36639'
	where intakeservicerequestactorid = '89096bd7-5adb-4411-9493-611ec9c3d300'
		and activeflag = 1;

update cjams.actor 
	set activeflag = 0,
		updatedon = now(),
		updatedby = 'CDM-36639'
	where actorid ='f99d109f-aa93-4153-87c3-4a2762d3a159'
		and activeflag = 1;

select * from personrole 
	where personid = 'c0abbc13-87d1-4e5a-9e5e-e1c73ffffe6f' 
		and servicecaseid = 'af91f846-245e-4afd-9ab2-041c98472e4a'
		and activeflag = 1;

update cjams.personrole 
	set activeflag = 0,
		updatedon = now(),
		updatedby = 'CDM-36639'
	where personroleid  = '850efa99-f59d-4f32-8a29-563ff0347d7f'
		and activeflag = 1;

update cjams.personroletype 
	set activeflag = 0,
		updatedon = now(),
		updatedby = 'CDM-36639'
	where personroleid  = '850efa99-f59d-4f32-8a29-563ff0347d7f'
		and activeflag = 1;

update cjams.actorrelationship 
	set activeflag = 0,
		updatedon = now(),
		updatedby = 'CDM-36639'
	where intakeservicerequestactorid ='89096bd7-5adb-4411-9493-611ec9c3d300'
		and activeflag = 1;
		
select objectid, programkey, *
	from cjams.personprogramarea
	where personid = 'c0abbc13-87d1-4e5a-9e5e-e1c73ffffe6f'
		and objectid = 'af91f846-245e-4afd-9ab2-041c98472e4a'
		and activeflag = 1;
		
update cjams.personprogramarea 
	set activeflag = 0,
		updatedon = now(),
		updatedby = 'CDM-36639'
	where personid = 'c0abbc13-87d1-4e5a-9e5e-e1c73ffffe6f'
		and objectid = 'af91f846-245e-4afd-9ab2-041c98472e4a'
		and activeflag = 1;