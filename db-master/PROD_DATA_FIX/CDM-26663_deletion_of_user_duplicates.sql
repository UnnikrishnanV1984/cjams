/*
   Issue Description: CDM-26663
   Category/ Module  : Deleting duplicate persons
   Root cause:Persons listed below are duplicates and need to be removed:Christopher D. HolleyQueen JahzaraTere Janae Sneed (Remove One)Jada Sneed Wise (Remove One)Janae Michelle Sneed (Remove One) Thank you in advance.
   Pull request# for code fix: It's a data fix
   Reason why no related code fix:  
   
*/







update actorrelationship set activeflag = 0, updatedby = 'CDM-26663', updatedon = now() where intakeservicerequestactorid in (	
	select intakeservicerequestactorid 
	from intakeservicerequestactor
	where personid = 'ecd77472-31c8-4bdd-907c-f3dd472abf61' and intakeserviceid = 'eb62e170-25b2-4903-a82c-5dd141e3fb94')	
and activeflag = 1;	

update intakeservicerequestactor	
set activeflag = 0, updatedby = 'CDM-26663', updatedon = now()
where personid = 'ecd77472-31c8-4bdd-907c-f3dd472abf61' and intakeserviceid = 'eb62e170-25b2-4903-a82c-5dd141e3fb94' and activeflag = 1 ;

update actor
set activeflag = 0,	updatedby = 'CDM-26663', updatedon = now()
where personid = 'ecd77472-31c8-4bdd-907c-f3dd472abf61' and intakeserviceid = 'eb62e170-25b2-4903-a82c-5dd141e3fb94' and activeflag = 1 ;




update actorrelationship set activeflag = 0, updatedby = 'CDM-26663', updatedon = now() where intakeservicerequestactorid in (	
	select intakeservicerequestactorid 
	from intakeservicerequestactor
	where personid = 'fa48a050-7aa7-4a52-994e-c27d39f01a98' and intakeservicerequestactorid = 'b8fe3427-4b8e-4349-9005-55296a4ee5d6')	
and activeflag = 1;	

update intakeservicerequestactor	
set activeflag = 0, updatedby = 'CDM-26663', updatedon = now()
where personid = 'fa48a050-7aa7-4a52-994e-c27d39f01a98'
and intakeservicerequestactorid = 'b8fe3427-4b8e-4349-9005-55296a4ee5d6' and activeflag = 1 ;

update actor
set activeflag = 0,	updatedby = 'CDM-26663', updatedon = now()
where personid = 'fa48a050-7aa7-4a52-994e-c27d39f01a98' and actorid = 'c2be1383-b977-41e4-b462-7c5cffca1267'
and activeflag = 1 ;






update actorrelationship set activeflag = 0, updatedby = 'CDM-26663', updatedon = now() where intakeservicerequestactorid in (	
	select intakeservicerequestactorid 
	from intakeservicerequestactor
	where personid = '8a261bf9-fd1f-482b-940d-e5fdc4bb3d37' and intakeservicerequestactorid = 'b8fe3427-4b8e-4349-9005-55296a4ee5d6')	
and activeflag = 1;	

update intakeservicerequestactor	
set activeflag = 0, updatedby = 'CDM-26663', updatedon = now()
where personid = '8a261bf9-fd1f-482b-940d-e5fdc4bb3d37'
and intakeservicerequestactorid = '6bed4425-eb0e-4006-8a92-69171c9c9b07' and activeflag = 1 ;

update actor
set activeflag = 0,	updatedby = 'CDM-26663', updatedon = now()
where personid = '8a261bf9-fd1f-482b-940d-e5fdc4bb3d37' and actorid = 'c2be1383-b977-41e4-b462-7c5cffca1267'
and activeflag = 1 ;



update actorrelationship set activeflag = 0, updatedby = 'CDM-26663', updatedon = now() where intakeservicerequestactorid in (	
	select intakeservicerequestactorid 
	from intakeservicerequestactor
	where personid = '7ce5d848-5763-40e0-8fcf-035a184a4907' and intakeserviceid = 'eb62e170-25b2-4903-a82c-5dd141e3fb94')	
and activeflag = 1;	

update intakeservicerequestactor	
set activeflag = 0, updatedby = 'CDM-26663', updatedon = now()
where personid = '7ce5d848-5763-40e0-8fcf-035a184a4907' and intakeserviceid = 'eb62e170-25b2-4903-a82c-5dd141e3fb94' and activeflag = 1 ;

update actor
set activeflag = 0,	updatedby = 'CDM-26663', updatedon = now()
where personid = '7ce5d848-5763-40e0-8fcf-035a184a4907' and intakeserviceid = 'eb62e170-25b2-4903-a82c-5dd141e3fb94' and activeflag = 1 ;





update actorrelationship set activeflag = 0, updatedby = 'CDM-26663', updatedon = now() where intakeservicerequestactorid in (	
	select intakeservicerequestactorid 
	from intakeservicerequestactor
	where personid = 'efd9b001-e27e-465c-a45d-7085f7ff655e' and intakeservicerequestactorid = '20d96956-c2bc-483d-8f85-09e3398b3c5d')	
and activeflag = 1;	

update intakeservicerequestactor	
set activeflag = 0, updatedby = 'CDM-26663', updatedon = now()
where personid = 'efd9b001-e27e-465c-a45d-7085f7ff655e'
and intakeservicerequestactorid = '20d96956-c2bc-483d-8f85-09e3398b3c5d' and activeflag = 1 ;

update actor
set activeflag = 0,	updatedby = 'CDM-26663', updatedon = now()
where personid = 'efd9b001-e27e-465c-a45d-7085f7ff655e' and actorid = 'd91ac8e0-562a-4999-b8f8-a1c9a01da303'
and activeflag = 1 ;
