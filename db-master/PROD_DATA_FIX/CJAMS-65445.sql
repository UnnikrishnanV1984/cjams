/*
-- Issue Description: 
	202101005278:Personid 200303718 to be deleted from case.
   
client ID# 	2047628727 from the CPS IR # 202101005278

-- Category/ Module: Persons
-- Root cause: personid 2047628727to be deleted from case 
-- Resolution: Removed a person from the persons other tab by setting active flag to 0.
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/



update actorrelationship
set activeflag = 0,
	updatedby = 'CJAMS-65445', 
	updatedon = now()
where intakeservicerequestactorid 
	in (	
		select intakeservicerequestactorid 
			from intakeservicerequestactor
		where personid = '35f6f98d-168e-411b-8f7b-eae72e774eb6'
			and intakeserviceid = 'c50357e6-ee6b-4af3-a461-5d7c8cc27dcf'
		)	
	and activeflag = 1;	


update intakeservicerequestactor	
set activeflag = 0,
	updatedby = 'CJAMS-65445', 
	updatedon = now()
where personid = '35f6f98d-168e-411b-8f7b-eae72e774eb6'
	and intakeserviceid = 'c50357e6-ee6b-4af3-a461-5d7c8cc27dcf'
	and activeflag = 1 ;
	

update actor
set activeflag = 0,
	updatedby = 'CJAMS-65445', 
	updatedon = now()
where personid = '35f6f98d-168e-411b-8f7b-eae72e774eb6'
	and intakeserviceid = 'c50357e6-ee6b-4af3-a461-5d7c8cc27dcf'
	and activeflag = 1 ;


update personrole
set activeflag = 0,
	updatedby = 'CJAMS-65445', 
	updatedon = now()
where personid = '35f6f98d-168e-411b-8f7b-eae72e774eb6'
	and intakeserviceid = 'c50357e6-ee6b-4af3-a461-5d7c8cc27dcf'
	and activeflag = 1 ;
