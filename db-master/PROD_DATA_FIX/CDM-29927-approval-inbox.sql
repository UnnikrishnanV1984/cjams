/*
   Issue Description: CDM-29927
   Category/ Module  : approval screen 
   Root cause: user requeseted to remove pending  apporval 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/



INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
VALUES(cjams.gen_random_uuid(), 'GADR', '7cf77857-7a72-4b32-999d-fd0eacf88f37', '7a03a441-97cc-4de9-bf92-e1445b4c0c717', '9a6c4cec-46f2-4f17-9814-4f50286a5d85', 'CWSP', 'CWCW', '8bf7dd0c-06ee-438e-ac17-29064319e3ea', 16, 1, 'CDM-29927', now(), 'CDM-29927', now(), true, '', NULL, '', '3281156', 'Servicecase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

update routing
set activeflag = 0 , 
updatedby = 'CDM-29927' ,
updatedon =now() 
where routingid ='fd4dfcb3-9f42-41b2-93ff-3e12efd7669d';
