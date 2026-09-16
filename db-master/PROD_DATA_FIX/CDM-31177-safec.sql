
    /*
  Issue Description:  CDM-31177
   Category/ Module  :  Assessment
   Root cause: wrongly created
   Pull request# for code fix: 
   Reason why no related code fix: user requested 
   Status of the code fix if already submitted and expected prod fix date: 
   Backup before update/ delete:
   
*/
---updated correct user information 

update cjams.assessment set updatedby ='9e292ec7-756e-4447-829c-9c000c71745c' , insertedby ='9e292ec7-756e-4447-829c-9c000c71745c'
where assessmentid ='6ab6fabb-1edc-4b5a-949b-c87f5b3539e8';

--routing also updated correct user information 
update cjams.routing set fromsecurityusersid ='9e292ec7-756e-4447-829c-9c000c71745c', updatedby ='CDM-31177', updatedon = now()
where routingid ='d5104a48-394c-47cd-9d6f-596f5df7e4fe';

--inserted apporved record 
INSERT INTO cjams.routing
( eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
VALUES( 'ASST', 'ba51d587-d94f-4b54-8225-78af2eab1214', '9e292ec7-756e-4447-829c-9c000c71745c', 'b3e66a90-4bdd-45b3-a1cd-073c3665d6be', 'CWSP', 'CWCW', '6ab6fabb-1edc-4b5a-949b-c87f5b3539e8', 16, 1, '148853dd-9946-4995-8ddc-186cc21b9d2c', now(), 'CDM-31177', now(), true, NULL, '', '221020202432', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
