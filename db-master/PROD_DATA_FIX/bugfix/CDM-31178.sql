/*
  Issue Description: CDM-31178
   Category/ Module  : deleting suspension on permenancy plan 
   Root cause: user wants to delete suspension
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    . Need to do data fix
*/
update  gapsuspensionrevision set enddate = startdate,
	approvaldate = now(),updatedby='CDM-31178',updatedon=now() 
where suspensionid='f3f954c0-a3ae-47aa-9659-7cda0e94e21a';
update  gapsuspension set enddate = startdate,updatedby='CDM-31178',updatedon=now() where gapsuspensionid='f3f954c0-a3ae-47aa-9659-7cda0e94e21a';


