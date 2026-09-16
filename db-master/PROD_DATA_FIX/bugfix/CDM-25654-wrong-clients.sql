-- CDM-25654-wrong clients
/*
-- Issue Description: 
	1.wrong clients
	
-- Root cause: wrong clients appeared in persons
---Fix : Removed the duplicated persons as required

-- Pull request# N/A 
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

update actorrelationship
set activeflag = 0,
     updatedon = now(),
	updatedby = 'CDM-25654'	
where intakeservicerequestactorid 
	in (	
		select intakeservicerequestactorid 
			from intakeservicerequestactor
		where personid in ('4f65565b-445d-4706-9797-c9128118988f','a25b8c08-f18c-4ec1-8762-b8f0cac94289')
			and servicecaseid = '57a4daf2-d8f2-40bf-af9f-ddf4099935eb'
		)	
	and activeflag = 1;	
	
update intakeservicerequestactor	
set activeflag = 0,
     updatedon = now(),
	updatedby = 'CDM-25654'	
where personid in ('4f65565b-445d-4706-9797-c9128118988f','a25b8c08-f18c-4ec1-8762-b8f0cac94289')
			and servicecaseid = '57a4daf2-d8f2-40bf-af9f-ddf4099935eb'
	and activeflag = 1 ;
	

update actor
set activeflag = 0,
     updatedon = now(),
	updatedby = 'CDM-25654'	
where personid in ('4f65565b-445d-4706-9797-c9128118988f','a25b8c08-f18c-4ec1-8762-b8f0cac94289')
			and servicecaseid = '57a4daf2-d8f2-40bf-af9f-ddf4099935eb'
	and activeflag = 1 ;
	
update personrole
set activeflag = 0,
    updatedon = now(),
	updatedby = 'CDM-25654'	
where personid in ('4f65565b-445d-4706-9797-c9128118988f','a25b8c08-f18c-4ec1-8762-b8f0cac94289')
			and servicecaseid = '57a4daf2-d8f2-40bf-af9f-ddf4099935eb'
	and activeflag = 1 ;