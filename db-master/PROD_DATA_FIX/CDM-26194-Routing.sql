/*
  Issue Description:  CDM-26194
   Category/ Module  :  Approval inbox 
   Root cause: wrongly created
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
   Backup before update/ delete:
   
*/


update cjams.routing set activeflag  =0, updatedby  ='CDM-26194', updatedon =now()
where routingid ='095ad9bc-d5e4-4087-968f-baa416bbbc02';

INSERT INTO cjams.routing (routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes) 
VALUES('2be7492c-1da7-4e09-bd9e-04a46062e516'::uuid, 'SCDR', 'c4d0b6a8-99c0-4d7e-b6ff-859618c9d4ae', '4c87b289-61d3-45e9-9c97-9bd90f6e3eab', 'a964b814-ffed-4367-a497-baaf306eb492'::uuid, 'CWSP', 'CWCW', 'e02f025f-de09-4329-a5ba-4ada5f031ddc', 16, 1, '4c87b289-61d3-45e9-9c97-9bd90f6e3eab', now(), 'CDM-26194', now(), true, 'Disposition Approved', NULL, 'Disposition Approved', '3301701', 'Servicecase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

