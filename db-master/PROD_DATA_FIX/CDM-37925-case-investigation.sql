/*
   Issue Description: CDM-37925
   Category/ Module  :Case not generated when screened in
   Description: I241012088623:I screened in a case that was recommended as screen out from screener. It did not generate a case
   Root cause: Need technical investigation and need data fix to create a CPS AR case and connected to the intake also need to fixed the Intake status.
   Fix Provided:  Promoted a data fix to Data fix to update the action type to AR and change the status to accepted and update the classid for #I241012088623
*/


select actiontype,intakenumber,intakeserviceid,servicecaseid,intakeserreqstatustypeid,intakeservicerequestclassid, * 
from intakeservicerequest 
where intakenumber = 'I241012088623'
and intakeserviceid ='e80fc8d5-cb2e-460f-bce1-5c184bf64daa'
and activeflag  = 1 ;


update intakeservicerequest
set actiontype = 'AR',
    intakeserreqstatustypeid='52ad4cc7-e8f8-4cbb-9e27-d86f2b817690',
    intakeservicerequestclassid ='b74ded78-12dc-4e6d-94db-7662d6eaf093',
    reporteddate = '2024-03-21 17:16:53.730',
    updatedon = now(),
    updatedby = 'CDM-37925'
where intakeserviceid = 'e80fc8d5-cb2e-460f-bce1-5c184bf64daa'
and intakenumber = 'I241012088623'
and activeflag  = 1 ;

select objectid,routingstatustypeid,activeflag,*
from routing where objectid in('I241012088623');

update routing
set routingstatustypeid= 2,
    activeflag = 1,
    isreviewrequest = true
where  objectid = 'I241012088623'
and routingid = 'd1e1d1b5-c671-4b85-97ee-ef48b8e23a07';


select intakeserreqstatustypeid,servicerequesttypeconfigiddispostionid, *
from intakeservicerequestdispositioncode 
where intakeserviceid = 'e80fc8d5-cb2e-460f-bce1-5c184bf64daa';


update intakeservicerequestdispositioncode
set intakeserreqstatustypeid='52ad4cc7-e8f8-4cbb-9e27-d86f2b817690',
    servicerequesttypeconfigiddispostionid='081b62dd-a613-4022-8d8d-2380558307db',
    updatedon = now(),
    updatedby = 'CDM-37925'
where intakeserviceid = 'e80fc8d5-cb2e-460f-bce1-5c184bf64daa';


