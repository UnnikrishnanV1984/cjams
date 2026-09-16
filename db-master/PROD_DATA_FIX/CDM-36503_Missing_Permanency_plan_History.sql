/*
 Issue Description: CDM-36503
 Category/ Module : Permanency Plan 
 Root cause: 3306375:Permanency Plan history missing from service case
 Fix: Updated the intakeservicerequestactorid with the active actorid of the child BRYAN-THOMAS -BOSTIC 
 Pull request# for code fix: 
 Reason why no related code fix: 
 Status of the code fix if already submitted and expected prod fix date: 
 Need to do data fix
 */

 select *from actor 
    where personid='246de09d-cd52-4b48-8464-d225162d952f';

 select *from intakeservicerequestactor 
    where actorid='8888fb61-1343-4952-a6e5-562bda021928';
    
 update intakeservicerequestactor 
    set actorid='fc5dffb8-f9d4-4971-bba7-709fc38e811c',
        updatedon = now(),
	    updatedby = 'CDM-36503'
    where intakeservicerequestactorid='e57a0f31-4fa6-4bfc-8e37-9caf6fa2ccfa'
        and actorid='8888fb61-1343-4952-a6e5-562bda021928' 
        and intakeservicerequestpersontypekey='CHILD';