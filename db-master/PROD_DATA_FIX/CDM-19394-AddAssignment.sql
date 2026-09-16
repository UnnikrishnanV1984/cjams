/*
   Issue Description: CDM-19394
   Category/ Module  : Need to add assignment 
   Root cause: user wants to add new case and assign to case worker, 
   Added new case in assignmnet tab for supervisor to assign to other case worker
   Pull request# for code fix: 4652,4670
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Case is closed without closing removal and placement. Need to do data fix
*/

INSERT INTO servicecasedisposition
( servicecasedispositionid , servicecaseid, statusdate, intakeserreqstatustypekey, dispositioncode, "comments", effectivedate, activeflag, insertedby, insertedon, updatedby, updatedon)
VALUES('0634ebe7-2cfa-46bd-9aa0-5d829c4d5ba6', 'bcdae2c3-b9ee-402c-b2a3-278bdabb9fde','2020-12-28 16:51:00', 'Open', 'Inprogress','In Progress', 
now(), 1, 'CDM-19394',now(),'CDM-19394',now());

INSERT INTO routing (eventcode, fromsecurityusersid, tosecurityusersid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon,updatedby, updatedon)
VALUES ('SCDR', 'e2842f9c-7cd1-4570-ae01-dc431596e4e9', 'e2842f9c-7cd1-4570-ae01-dc431596e4e9', 'CWSP', 'CWSP', '0634ebe7-2cfa-46bd-9aa0-5d829c4d5ba6', 16, 1, 'CDM-19394',now(),'CDM-19394', now());

