--D-25115

update servicecase set dispositioncode = 'Closed', enddate = now(), activeflag = 0 where servicecaseid = '19b0c836-3459-4068-8dd1-b0161ca39ece';
update servicecasedisposition set intakeserreqstatustypekey = 'Closed' where servicecasedispositionid = 'f624f37d-a1dd-4ddd-910e-59dacb0c97e5';


--D-26653
update routing set routingstatustypeid =2 , updatedby = 'D-26653', updatedon = now() where old_id in (3229228, 3229229) and  eventcode = 'SRVC'
