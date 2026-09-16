/*
   Issue Description: CDM-44192
   Category/ Module  : Dashboard
   Root cause: user requested to remove client from case
   Pull request# for code fix: 
   Reason why no related code fix: User Error 
    
*/



update cjams.actor 
set activeflag = 0,
	updatedon = now(),
	updatedby = 'CDM-44195'
where actorid ='af201eeb-28fc-457c-b519-3f02395331ee'
	 and intakeserviceid ='047279a3-f0a3-445f-a6ae-5459ab67b06c'
	 and activeflag = 1;

update cjams.intakeservicerequestactor  
set activeflag = 0,
	updatedon = now(),
	updatedby = 'CDM-44195'
where intakeservicerequestactorid = '928bb39e-3407-4c34-b1f5-240b716e65c6'
	 and intakeserviceid ='047279a3-f0a3-445f-a6ae-5459ab67b06c'
	 and activeflag = 1;

update cjams.personrole   
set activeflag = 0,
	updatedon = now(),
	updatedby = 'CDM-44195'
where personroleid  = 'aa249e92-1a04-4ea6-9ce3-c9656900dc28'
	 and intakeserviceid ='047279a3-f0a3-445f-a6ae-5459ab67b06c'
	 and activeflag = 1;

update actorrelationship
set activeflag = 0,
	updatedby = 'CDM-44195', 
	updatedon = now()
where intakeservicerequestactorid 
	in (	
		select intakeservicerequestactorid 
			from intakeservicerequestactor
		where personid = '4f755d56-14e8-45b5-89b6-41d22f746b6a'
		and intakeserviceid ='047279a3-f0a3-445f-a6ae-5459ab67b06c'	
		)	
	and activeflag = 1;	


update personprogramarea 
SET activeflag = 0, 
	updatedon = now(), 
	updatedby = 'CDM-44195' 
	where personprogramid = '8bf67b9a-9dae-40d2-a0f0-45873b0dbca4'
	 and activeflag = 1;

update personroletype 
SET activeflag = 0, 
	updatedon = now(), 
	updatedby = 'CDM-44195' 
where personroletypeid = '9452c02d-2156-4953-8c60-8a818b5b37b4'
 	and activeflag = 1;