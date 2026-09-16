-- Data fixes to update the CPS case status

delete from routing where routingid='d66bcce6-685e-48c9-9439-efd78358b77f' and eventcode = 'INDR';
--221020180010
INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
VALUES('d66bcce6-685e-48c9-9439-efd78358b77f' , 'INDR', '', 'c76a19b4-adf3-413e-8f0c-9c1e07ee64bc', 'bff616ca-735d-4433-843d-7349bf6abe3a', 'CWSP', 'CWSP', '0a1f7d55-8f10-4ffd-8395-f4111a5e96bf', 16, 1, 'ce5b8c8a-64f7-4a9b-b4eb-f05a7dfe0934', '2022-05-16 00:00:00','CIDM-8330', now(), true, '', NULL, '', '221020180010', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);


--221020178317 
select * from intakeservicerequest
where intakeserviceid = '94a2807a-54d3-45a1-908a-264d469d0d04';

update
   intakeservicerequest 
set
   intakeserreqstatustypeid = '7995cecb-062d-406c-8ea9-b1da4b1877d8', updatedby = 'CIDM-8330', updatedon = now() 
where
   intakeserviceid = '94a2807a-54d3-45a1-908a-264d469d0d04' and activeflag=1;

--221020175560
select * from intakeservicerequest
where intakeserviceid = '86d0579a-f4fd-42f0-b355-93c965a5eb97';

update
   intakeservicerequest 
set
   intakeserreqstatustypeid = '7995cecb-062d-406c-8ea9-b1da4b1877d8', updatedby = 'CIDM-8330', updatedon = now() 
where
   intakeserviceid = '86d0579a-f4fd-42f0-b355-93c965a5eb97' and activeflag=1;
   
--221020222685 
select * from intakeservicerequest
where intakeserviceid = '162e6ed4-747c-43b9-bfdb-42eb69c3f104';

update
   intakeservicerequest 
set
   intakeserreqstatustypeid = '52ad4cc7-e8f8-4cbb-9e27-d86f2b817690', updatedby = 'CIDM-8330', updatedon = now() 
where
   intakeserviceid = '162e6ed4-747c-43b9-bfdb-42eb69c3f104' and activeflag=1;

update routing set activeflag=0 where routingid='54d1d87c-0c26-4d77-b6d4-2efe8ae675f2' and eventcode='INDR';

update intakeservicerequestdispositioncode set intakeserreqstatustypeid='52ad4cc7-e8f8-4cbb-9e27-d86f2b817690', 
servicerequesttypeconfigiddispostionid='4c6d4e10-5572-4cb0-8bd0-5d596e3e2588', updatedby='CIDM-8330', updatedon=now()
where  intakeservicerequestdispositioncodeid='4acfe94f-786f-4af7-bf56-9415acbbd964';