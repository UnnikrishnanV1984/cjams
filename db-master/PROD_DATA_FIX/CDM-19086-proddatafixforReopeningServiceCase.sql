
/*
   Issue Description: CDM-19086
   Category/ Module  : Reopen Service case
   Root cause: user requeseted to remove it
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

INSERT INTO servicecasedisposition
( servicecasedispositionid , servicecaseid, statusdate, intakeserreqstatustypekey, dispositioncode, "comments", effectivedate, activeflag, insertedby, insertedon, updatedby, updatedon)
VALUES('761c5c93-ef14-4d16-a08d-420c9ff7b04d', '1e69544a-8e67-4870-88da-6becaeff9811', Now(), 'Open', 'Inprogress','In Progress', 
	   now(), 1, 'CDM-19086',now(),'CDM-19086',now())on conflict do nothing;

insert into routing (eventcode, fromsecurityusersid, tosecurityusersid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon,updatedby, updatedon)
values ('SCDR', 'd636ac2f-53ff-43e0-adbf-35c97e0427ec', 'd636ac2f-53ff-43e0-adbf-35c97e0427ec', 'CWSP', 'CWSP', '761c5c93-ef14-4d16-a08d-420c9ff7b04d', 16, 1, 'CDM-19086',now(),'CDM-19086', now())on conflict do nothing;
