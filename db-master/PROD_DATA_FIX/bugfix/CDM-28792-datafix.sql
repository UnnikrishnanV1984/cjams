/*
   Issue Description: CDM-28792
   Category/ Module  :Service case disposition 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

 
 INSERT INTO cjams.routing(eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id)
VALUES('SCDR', 'dfdc212e-0829-4b69-beae-72e34226bb03', 'dfdc212e-0829-4b69-beae-72e34226bb03', NULL, 'CWSP', 'CWCW', 'f6b3a1f1-7f40-4430-9940-7bad9e1ec141' , 16, 1, 'CDM-28792', now(), 'CDM-28792', now(), false, NULL, '3275659');