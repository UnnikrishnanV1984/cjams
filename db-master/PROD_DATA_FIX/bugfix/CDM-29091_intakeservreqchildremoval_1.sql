/*
   Issue Description: CDM-29091
   Category/ Module  : Child Removal 
   Root cause: child removed from CPS IR should show service case
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/

update intakeservreqchildremoval isrc
set servicecaseid = (select coalesce(isra.servicecaseid, acr.servicecaseid, isr.servicecaseid) 
    from intakeservicerequestactor isra,
        actor acr,
        intakeservicerequest isr
    where isra.actorid = acr.actorid
    and isra.intakeservicerequestactorid = isrc.intakeservicerequestactorid
    and isra.intakeserviceid = isr.intakeserviceid
    and isra.personid = isrc.personid
    and isra.activeflag = 1 
    )  ,
updatedby = 'CDM-29091', updatedon = now()
where isrc.intakeserviceid is not null and isrc.servicecaseid is null and isrc.activeflag = 1;


