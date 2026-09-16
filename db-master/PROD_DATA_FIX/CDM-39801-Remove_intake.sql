/*
   Issue Description: CDM-39801
   Category/ Module  : SDM 
   Root cause: safec checklist is not checked in ar summary
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

update intakedastatus 
set activeflag = 0,updatedby = 'CDM-39801',updatedon = now()
where intakenumber = 'I241012534565' and activeflag = 1;

update routing 
set activeflag = 0,updatedby = 'CDM-39801',updatedon = now()
where objectid = 'I241012534565' and activeflag = 1;

update intakedastaging 
set activeflag = 0,updatedby = 'CDM-39801',updatedon = now()
where intakenumber = 'I241012534565' and activeflag = 1;

update intakesnapshot set 
activeflag = 0,
updatedby = 'CDM-39801',
updatedon = now()
where intakenumber = 'I241012534565' and activeflag = 1;


update intakeservicerequestsdm
set  
activeflag = 0,
updatedby = 'CDM-39801',
updatedon = now()
where intakeserviceid  = 'a18c9c23-10e7-4b1d-8e2b-b63dfb81742b' and activeflag  = 1;

update intakeservicerequest
set  
activeflag = 0,
updatedby = 'CDM-39801',
updatedon = now()
where intakeserviceid  = 'a18c9c23-10e7-4b1d-8e2b-b63dfb81742b' and activeflag  = 1;

update intakeservicerequestdispositioncode
set  
activeflag = 0,
updatedby = 'CDM-39801',
updatedon = now()
where intakeserviceid  = 'a18c9c23-10e7-4b1d-8e2b-b63dfb81742b' and activeflag  = 1;

update caseassignment
set  
activeflag = 0,
updatedby = 'CDM-39801',
updatedon = now()
where objectid  = 'a18c9c23-10e7-4b1d-8e2b-b63dfb81742b' and activeflag  = 1;

update personprogramarea
set  
activeflag = 0,
updatedby = 'CDM-39801',
updatedon = now()
where objectid = 'a18c9c23-10e7-4b1d-8e2b-b63dfb81742b' and activeflag  = 1;

update actor
set  
activeflag = 0,
updatedby = 'CDM-39801',
updatedon = now()
where intakeserviceid  = 'a18c9c23-10e7-4b1d-8e2b-b63dfb81742b' and activeflag  = 1;

update intakeservicerequestactor
set  
activeflag = 0,
updatedby = 'CDM-39801',
updatedon = now()
where intakeserviceid  = 'a18c9c23-10e7-4b1d-8e2b-b63dfb81742b' and activeflag  = 1;

update personrole
set  
activeflag = 0,
updatedby = 'CDM-39801',
updatedon = now()
where intakeserviceid  = 'a18c9c23-10e7-4b1d-8e2b-b63dfb81742b' and activeflag  = 1;

update actorrelationship
set  
activeflag = 0,
updatedby = 'CDM-39801',
updatedon = now()
where intakeservicerequestactorid  
in (select intakeservicerequestactorid from intakeservicerequestactor
        where intakeserviceid  = 'a18c9c23-10e7-4b1d-8e2b-b63dfb81742b'
    )    
and activeflag  = 1;

update personroletype 
set  
activeflag = 0,
updatedby = 'CDM-39801',
updatedon = now()
where personroleid 
    in ( select personroleid from personrole
            where intakeserviceid  = 'a18c9c23-10e7-4b1d-8e2b-b63dfb81742b' )
and activeflag  = 1;

update routing
set  
activeflag = 0,
updatedby = 'CDM-39801',
updatedon = now()
where objectid =  'a18c9c23-10e7-4b1d-8e2b-b63dfb81742b' 
and activeflag = 1 ;
