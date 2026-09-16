/*
   Issue Description: CDM-39287
   Category/ Module  : Approval
   Root cause:Service case referral was accepted but did not populate into a service case. Referral shows as Accepted. Supervisor unable to turn it around. A new referral will be entered.
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/

update intakedastaging
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CDM-39287'
where intakenumber in ('I241012392316') 
    and activeflag = 1 ;
    

update intakedastatus
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CDM-39287'
where intakenumber in ('I241012392316') 
    and activeflag = 1 ;
    
 update intakesnapshot
   set activeflag = 0,
    updatedon = now(),
    updatedby = 'CDM-39287'
where intakenumber in ('I241012392316') 
    and activeflag = 1 ;
    
update routing
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CDM-39287'
where objectid in ('I241012392316') 
    and activeflag = 1 ;

update intakeservicerequest
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CDM-39287'
where intakenumber in ('I241012392316') 
    and activeflag = 1 ;

-- Update actor
UPDATE actor
SET activeflag = 0,
    updatedby = 'CDM-39287',
    updatedon = now()
WHERE intakenumber = 'I241012392316' AND activeflag = 1;

-- Update intakeservicerequestactor
UPDATE intakeservicerequestactor
SET activeflag = 0,
    updatedby = 'CDM-39287',
    updatedon = now()
WHERE intakenumber = 'I241012392316' AND activeflag = 1;

-- Update personrole
UPDATE personrole
SET activeflag = 0,
    updatedby = 'CDM-39287',
    updatedon = now()
WHERE intakenumber = 'I241012392316' AND activeflag = 1;

-- Update personroletype
UPDATE cjams.personroletype
SET updatedby = 'CDM-39287',updatedon = now(),activeflag =0
where personroletypeid in ('23e91fa9-a31d-424c-8dc6-cf9bab88f56b','d2f83ffd-b768-46ca-95f7-22cee4bc8503');

--UPDATE actorrelationship
UPDATE cjams.actorrelationship
SET updatedby = 'CDM-39287',updatedon = now(),activeflag =0
where intakenumber='I241012392316' AND activeflag = 1;