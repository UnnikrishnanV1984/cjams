/*
 CDM-37218 - Case Closure
 
 Issue Description: 
 241021893666:	Unable to close case due to initial face to face requirement. User requested to close the case with data fix
			
 Case#: 241021893666 (91e923b4-4320-4e38-9086-27f2097f08f8)

 Case Worker: Nia Edmundson (1e72fd87-c3f0-4c21-a67f-39099dea4843)
 Supervisor: Mia Dabney (256457bc-cd36-40ed-9716-c76835b9b8cc)

 Root cause:The worker is not able to send the case for closure due to there not being a completed face-to-face contact with one of the children. 
 Resolution: Data fix is provided to close the case.
 Pull request# N/A
 Reason why no related code fix: N/A
 Status of the code fix if already submitted and expected prod fix date: N/A
*/

select * from intakeservicerequest where intakeserviceid = '91e923b4-4320-4e38-9086-27f2097f08f8';

update intakeservicerequest 
	set intakeserreqstatustypeid = '7995cecb-062d-406c-8ea9-b1da4b1877d8', 
		updatedby = 'CDM-37218', 
		updatedon = now() 
	where intakeserviceid = '91e923b4-4320-4e38-9086-27f2097f08f8';
  
  
select intakeservicerequestdispositioncodeid  
	from cjams.intakeservicerequestdispositioncode 
	where intakeserviceid = '91e923b4-4320-4e38-9086-27f2097f08f8' 
		and intakeserreqstatustypeid = '52ad4cc7-e8f8-4cbb-9e27-d86f2b817690';
 
select * 
	from cjams.intakeservicerequestdispositioncode
	where intakeservicerequestdispositioncodeid = 'f8dfaf2d-225c-4573-af04-a8eea9d0ef7c';

select * 
	from cjams.intakeservicerequestdispositioncode 
	where intakeserviceid = '91e923b4-4320-4e38-9086-27f2097f08f8' 
		and updatedby = 'CDM-37218';
       
select * 
	from routing 
	where servicerequestnumber = '241021893666' 
		and activeflag = 1 
		and eventcode in ('INDR', 'INVT');

DELETE FROM intakeservicerequestdispositioncode WHERE updatedby = 'CDM-37218';
INSERT INTO
	cjams.intakeservicerequestdispositioncode (intakeservicerequestdispositioncodeid, intakeserviceid, insertedby, insertedon,
	updatedby, updatedon, statusdate, description, effectivedate, activeflag, intakeserreqstatustypeid,
	servicerequesttypeconfigiddispostionid, 
	reviewcomments, 
	reasonfordelay) 
VALUES
	(gen_random_uuid(), '91e923b4-4320-4e38-9086-27f2097f08f8', '1e72fd87-c3f0-4c21-a67f-39099dea4843', '2024-02-15 12:00:00',
		'CDM-37218', NOW(), '2024-02-15 12:00:00', 'Completed', '2024-02-15 12:00:00', 1, '7995cecb-062d-406c-8ea9-b1da4b1877d8',
		'd90db0d3-f665-49db-b3ad-0edb468bc02d', 
		'Reasonable efforts were made to ensure the safety and welfare of the child. Family and victim child declined to participate in the Alternative Response case despite these efforts. Child is now 18 years old', 
		'');

DELETE FROM routing WHERE updatedby = 'CDM-37218';  

INSERT INTO
	cjams.routing (routingid, eventcode, fromsecurityusersid,
	tosecurityusersid, teamid, fromroleid, toroleid,
	objectid, 
	routingstatustypeid, activeflag,
	insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, routeddescription, servicerequestnumber) 
VALUES
   (
      cjams.gen_random_uuid(), 'INDR', '1e72fd87-c3f0-4c21-a67f-39099dea4843', 
		'1e72fd87-c3f0-4c21-a67f-39099dea4843','3036bbf4-25b7-4392-8812-dd534908f864', 'CWCW', 'CWSP',
		(select intakeservicerequestdispositioncodeid 
			from cjams.intakeservicerequestdispositioncode 
			where intakeserviceid = '91e923b4-4320-4e38-9086-27f2097f08f8' 
				and updatedby = 'CDM-37218'), 
		15, 0,
		'1e72fd87-c3f0-4c21-a67f-39099dea4843', '2024-02-15 12:00:00.000', 'CDM-37218', now(), true, '',
		'', '241021893666');
 
INSERT INTO
	cjams.routing (routingid, eventcode, fromsecurityusersid,
	tosecurityusersid, teamid, fromroleid, toroleid,
	objectid, 
	routingstatustypeid, activeflag,
	insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, routeddescription, servicerequestnumber) 
VALUES
   (
      cjams.gen_random_uuid(), 'INDR', '256457bc-cd36-40ed-9716-c76835b9b8cc', 
		'1e72fd87-c3f0-4c21-a67f-39099dea4843','3036bbf4-25b7-4392-8812-dd534908f864', 'CWSP', 'CWSP',
		(select intakeservicerequestdispositioncodeid 
			from cjams.intakeservicerequestdispositioncode 
			where intakeserviceid = '91e923b4-4320-4e38-9086-27f2097f08f8' 
				and updatedby = 'CDM-37218'), 
		16, 1,
		'1e72fd87-c3f0-4c21-a67f-39099dea4843', '2024-02-15 12:00:00.000', 'CDM-37218', now(), true, '',
		'', '241021893666');
  
select * from caseassignment 
	where objectid = '91e923b4-4320-4e38-9086-27f2097f08f8'
		and enddate is null;
   
update caseassignment 
	set enddate = '2024-02-15 12:00:00.000', 
		updatedby = 'CDM-37218', 
		updatedon = now() 
	where caseassignmentid = 'e1d0d671-4d40-4436-977e-5a9d838ae14f';
  
  
update personprogramarea 
	set	enddate = '2024-02-15 12:00:00.000', 
		updatedby = 'CDM-37218', 
		updatedon = now()
	where entityid = '241021893666' 
		and activeflag = 1 
		and enddate is null;