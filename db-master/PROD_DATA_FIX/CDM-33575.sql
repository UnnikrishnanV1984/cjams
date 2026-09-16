/*
   Issue Description: CDM-33575
   Category/ Module  : Dashboard
   Root cause: User wants to remove delete Intake # I231010936527 and CPS-AR : 231020850164
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

UPDATE IntakeDAStaging 
SET activeflag = 0,
    updatedby = 'CDM-33575',
    updatedon = now()
WHERE intakenumber ='I231010936527';

UPDATE intakedastatus 
SET activeflag = 0,
    updatedby = 'CDM-33575',
    updatedon = now()
WHERE intakenumber ='I231010936527';

update intakesnapshot
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CDM-33575'
WHERE intakenumber ='I231010936527';



update 
   intakeservicerequest
set activeflag = 0, 
   updatedby = 'CDM-33575',
   updatedon = now() 
where 
servicerequestnumber = '231020850164';

update 
   personprogramarea 
set
  activeflag = 0,  
  updatedby = 'CDM-33575',
  updatedon = now() 
where objectid = 'a65d9738-fb62-4118-bb85-e301cef53c27';

update 
   caseassignment
set
  activeflag = 0,  
  updatedby = 'CDM-33575',
  updatedon = now() 
where objectid = 'a65d9738-fb62-4118-bb85-e301cef53c27';

update 
  routing
set
  activeflag = 0,  
  updatedby = 'CDM-33575',
  updatedon = now() 
where objectid = 'a65d9738-fb62-4118-bb85-e301cef53c27' and activeflag = 1;
