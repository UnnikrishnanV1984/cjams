 /*  Issue Description: CDM-7524--Incorrect Worker Associated with Request
   Category/ Module  :  Placement
   Root cause: Requester name wrong
   Pull request# for code fix:  Already fixed and deployed
   Reason why no related code fix: Already fixed and deployed
   Status of the code fix if already submitted and expected prod fix date: Already in Production
   
   Old value before update: requestedby,insertedby=cd0791b5-b0cd-48c4-9f30-76232793d084
*/
update placementrevision set requestedby='58051688-dd43-4fcb-a9dd-8e3e1181d341',updatedon=now(),updatedby='CDM-7524' where placementid='c8cd4a31-d8a5-491c-a240-325cb40ab2db' and 
placementrevisionid in ('f0c23815-29e2-41e6-9805-57c89ca19c71','ba8b1029-db85-4aa6-99e9-7c452ca3acbc');

update placementrevision set insertedby='58051688-dd43-4fcb-a9dd-8e3e1181d341',updatedon=now(),updatedby='CDM-7524' where placementid='c8cd4a31-d8a5-491c-a240-325cb40ab2db'  and 
placementrevisionid='ba8b1029-db85-4aa6-99e9-7c452ca3acbc';