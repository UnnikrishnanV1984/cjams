/*
   Issue Description: CDM-39597
   Category/ Module  : Decision
   Root cause: user requested to add closing status in the decision tab 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/

delete  from routing where updatedby='CDM-39597';


INSERT INTO cjams.routing
(eventcode, fromsecurityusersid, tosecurityusersid, teamid,
fromroleid, toroleid, objectid, routingstatustypeid, activeflag,
insertedby, insertedon, updatedby, updatedon, isreviewrequest,
remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes, intakerecommendation, supervisordecision, approveddate)
VALUES('INDR', '5611b96f-733e-47a7-878b-f40b92d39f7c', '4db6906f-a529-41c2-8e97-709b4815523d', '13235932-5e81-4427-a9d0-affbc6001410',
'CWCW', 'CWSP', '9b212707-e0b4-4077-bb16-56f35436a2ec', 16, 1,
'4db6906f-a529-41c2-8e97-709b4815523d', '2024-06-12 08:10:18.702', 'CDM-39597',now(), true,
'', NULL, '', '241022126457', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);


update intakeservicerequestdispositioncode
set insertedon ='2024-06-11 04:39:05', effectivedate ='2024-06-11 04:39:05',
updatedby ='CDM-39597',
updatedon=now()
where intakeservicerequestdispositioncodeid='9b212707-e0b4-4077-bb16-56f35436a2ec' and activeflag=1;

