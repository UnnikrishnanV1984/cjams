/*
   Issue Description: CDM-37940
   Category/ Module  :Screened In referral not generated investigation
   Description: I241012089903:Here is another example of where supervisor selects screen in where screener had selected screen out where it does not honor the supervisor's recommendation and did NOT generate an investigation.
                This is an active investigation with NO cjams case. Please give immediate attention
   Root cause: Supervisor Approved Screened In the intake but the CPS AR case not created.
               Need to check for RCA why no CPS AR case is created? also why there are two intake displayed while searching for Intake in Global search?
               Need data fix to create the CPS AR Case.
Fix Provided:  Promoted a data fix to Data fix to update the action type to AR and change the status to accepted and update the classid for #I241012089903
*/


select actiontype,intakenumber,intakeserviceid,servicecaseid,intakeserreqstatustypeid,intakeservicerequestclassid, * 
from intakeservicerequest 
where intakeserviceid = '3dbf827a-2460-45e5-8dc7-af24ebb0dd1c'
and intakenumber = 'I241012089903'
and activeflag  = 1 ;

update intakeservicerequest
set actiontype = 'AR',
    intakeserreqstatustypeid = '52ad4cc7-e8f8-4cbb-9e27-d86f2b817690',
    intakeservicerequestclassid ='b74ded78-12dc-4e6d-94db-7662d6eaf093',
    reporteddate = '2024-03-22 16:37:35.927',
    updatedon = now(),
    updatedby = 'CDM-37940'
where intakeserviceid = '3dbf827a-2460-45e5-8dc7-af24ebb0dd1c'
and intakenumber = 'I241012089903'
and activeflag  = 1 ;

select objectid,routingstatustypeid,activeflag,*
from routing where objectid in('I241012089903');

update routing
set routingstatustypeid= 2,
    activeflag = 1,
    isreviewrequest = true
    -- updatedon = now(),
    -- updatedby = 'CDM-37940'
where  objectid = 'I241012089903'
and routingid = 'ca4803de-6088-413f-a470-58f1fa974396';


select intakeserreqstatustypeid,servicerequesttypeconfigiddispostionid, *
from intakeservicerequestdispositioncode 
where intakeserviceid = '3dbf827a-2460-45e5-8dc7-af24ebb0dd1c';


update intakeservicerequestdispositioncode
set intakeserreqstatustypeid='52ad4cc7-e8f8-4cbb-9e27-d86f2b817690',
    servicerequesttypeconfigiddispostionid='081b62dd-a613-4022-8d8d-2380558307db',
    updatedon = now(),
    updatedby = 'CDM-37940'
where intakeserviceid = '3dbf827a-2460-45e5-8dc7-af24ebb0dd1c';

select * from intakedastaging   
where intakenumber = 'I241012089903'
and activeflag  = 1 
and id = 9205229;

update intakedastaging
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CDM-37940'
where intakenumber = 'I241012089903'
and activeflag  = 1 
and id = 9205229 ;   