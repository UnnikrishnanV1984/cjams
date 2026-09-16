-- CDM-25931-incorrect-persons-entered
/*
-- Issue Description: 
	1.Persons Error
	
-- Root cause: This data is duplicated
---Fix : Removed the duplicated persons as required

-- Pull request# N/A 
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

update actorrelationship
set activeflag = 0,
    updatedon = now(),
	updatedby = 'CDM-18535'
where intakeservicerequestactorid 
	in ('313b8ef5-016d-4fdb-a55c-f0863662f77e')	
	and activeflag = 1;	
	
update intakeservicerequestactor	
set activeflag = 0,
    updatedon = now(),
	updatedby = 'CDM-18535'
where intakeservicerequestactorid 
	in ('313b8ef5-016d-4fdb-a55c-f0863662f77e')	
	and activeflag = 1 ;
	

update actor
set activeflag = 0,
    updatedon = now(),
	updatedby = 'CDM-18535'
where actorid = '06ac012c-a16e-45b8-a8b1-94994d32f00e'
	and activeflag = 1 ;
	
update personrole
set activeflag = 0,
    updatedon = now(),
	updatedby = 'CDM-18535'
where personid = 'b26e9032-59c9-493a-8c77-d53c8e07fafd' and intakeserviceid = '7697e071-0ab1-488d-acd2-92e9b5616517'
	and activeflag = 1 ;

update personrole 
set activeflag =0,
    updatedon = now(),
	updatedby = 'CDM-18535'
where personid ='b6c0f5e4-2106-493b-a78b-9d29d722e4cf' and personroleid in ('62139fe8-34e0-42fc-a360-62f05ea5f72b', '1b761761-6c3a-4262-ae11-9f3e34458b25');


update personprogramarea 
set activeflag =0,
    updatedon = now(),
	updatedby = 'CDM-18535'
where personid  = 'b26e9032-59c9-493a-8c77-d53c8e07fafd'
and objectid ='7697e071-0ab1-488d-acd2-92e9b5616517';