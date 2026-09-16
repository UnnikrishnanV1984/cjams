/*
 CDM-35317 - Closure Error

 Issue Description: 
 231021274894:	Unable to close case due to initial face to face requirement. This is a quick close due to no engagement. 
				Multiple notes have been added related to face to face attempts. No face to face visits were successful with child. 
				Worker is required to close the case due to this concern
			
 Case#: 231021274894 (d76d3a23-b407-4fb1-a5a2-c9614b3eb640)

 Case Worker: Chantal Lee (cb9fd936-b210-4c7f-b973-d226464aa46e)
 Supervisor: Briana Stern (3e3e1941-751b-49b1-bdbf-af8d32c8bfb9)

 Root cause:The worker is not able to send the case for closure due to there not being a completed face-to-face contact with one of the children. 
 Resolution: Data fix is provided to close the case.
 Pull request# N/A
 Reason why no related code fix: N/A
 Status of the code fix if already submitted and expected prod fix date: N/A
*/

select * from intakeservicerequest where intakeserviceid = 'd76d3a23-b407-4fb1-a5a2-c9614b3eb640';

update intakeservicerequest 
	set intakeserreqstatustypeid = '7995cecb-062d-406c-8ea9-b1da4b1877d8', 
		updatedby = 'CDM-35317', 
		updatedon = now() 
	where intakeserviceid = 'd76d3a23-b407-4fb1-a5a2-c9614b3eb640';
  
  
select intakeservicerequestdispositioncodeid  
	from cjams.intakeservicerequestdispositioncode 
	where intakeserviceid = 'd76d3a23-b407-4fb1-a5a2-c9614b3eb640' 
		and intakeserreqstatustypeid = '52ad4cc7-e8f8-4cbb-9e27-d86f2b817690';
 
select * 
	from cjams.intakeservicerequestdispositioncode
	where intakeservicerequestdispositioncodeid = 'f8dfaf2d-225c-4573-af04-a8eea9d0ef7c';

select * 
	from cjams.intakeservicerequestdispositioncode 
	where intakeserviceid = 'd76d3a23-b407-4fb1-a5a2-c9614b3eb640' 
		and updatedby = 'CDM-35317';
       
select * 
	from routing 
	where servicerequestnumber = '231021274894' 
		and activeflag = 1 
		and eventcode in ('INDR', 'INVT');

DELETE FROM intakeservicerequestdispositioncode WHERE updatedby = 'CDM-35317';
INSERT INTO
	cjams.intakeservicerequestdispositioncode (intakeservicerequestdispositioncodeid, intakeserviceid, insertedby, insertedon,
	updatedby, updatedon, statusdate, description, effectivedate, activeflag, intakeserreqstatustypeid,
	servicerequesttypeconfigiddispostionid, 
	reviewcomments, 
	reasonfordelay) 
VALUES
	(gen_random_uuid(), 'd76d3a23-b407-4fb1-a5a2-c9614b3eb640', 'cb9fd936-b210-4c7f-b973-d226464aa46e', '2024-02-01 12:00:00',
		'CDM-35317', NOW(), '2024-02-01 12:00:00', 'Completed', '2024-02-01 12:00:00', 1, '7995cecb-062d-406c-8ea9-b1da4b1877d8',
		'd90db0d3-f665-49db-b3ad-0edb468bc02d', 
		'Reasonable efforts were made to ensure the safety and welfare of the child. Family and victim child declined to participate in the Alternative Response case despite these efforts. Child is now 18 years old', 
		'');

DELETE FROM routing WHERE updatedby = 'CDM-35317';  

INSERT INTO
	cjams.routing (routingid, eventcode, fromsecurityusersid,
	tosecurityusersid, teamid, fromroleid, toroleid,
	objectid, 
	routingstatustypeid, activeflag,
	insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, routeddescription, servicerequestnumber) 
VALUES
   (
      cjams.gen_random_uuid(), 'INDR', 'cb9fd936-b210-4c7f-b973-d226464aa46e', 
		'cb9fd936-b210-4c7f-b973-d226464aa46e','3036bbf4-25b7-4392-8812-dd534908f864', 'CWCW', 'CWSP',
		(select intakeservicerequestdispositioncodeid 
			from cjams.intakeservicerequestdispositioncode 
			where intakeserviceid = 'd76d3a23-b407-4fb1-a5a2-c9614b3eb640' 
				and updatedby = 'CDM-35317'), 
		15, 0,
		'cb9fd936-b210-4c7f-b973-d226464aa46e', '2024-02-01 12:00:00.000', 'CDM-35317', now(), true, '',
		'', '231021274894');
 
INSERT INTO
	cjams.routing (routingid, eventcode, fromsecurityusersid,
	tosecurityusersid, teamid, fromroleid, toroleid,
	objectid, 
	routingstatustypeid, activeflag,
	insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, routeddescription, servicerequestnumber) 
VALUES
   (
      cjams.gen_random_uuid(), 'INDR', '3e3e1941-751b-49b1-bdbf-af8d32c8bfb9', 
		'cb9fd936-b210-4c7f-b973-d226464aa46e','3036bbf4-25b7-4392-8812-dd534908f864', 'CWSP', 'CWSP',
		(select intakeservicerequestdispositioncodeid 
			from cjams.intakeservicerequestdispositioncode 
			where intakeserviceid = 'd76d3a23-b407-4fb1-a5a2-c9614b3eb640' 
				and updatedby = 'CDM-35317'), 
		16, 1,
		'cb9fd936-b210-4c7f-b973-d226464aa46e', '2024-02-01 12:00:00.000', 'CDM-35317', now(), true, '',
		'', '231021274894');
  
select * from caseassignment 
	where objectid = 'd76d3a23-b407-4fb1-a5a2-c9614b3eb640'
		and enddate is null;
   
update caseassignment 
	set enddate = '2024-02-01 00:00:00.000', 
		updatedby = 'CDM-35317', 
		updatedon = now() 
	where caseassignmentid = '4271ad8c-c39f-47e3-a635-855b6beb797a';
  
  
update personprogramarea 
	set	enddate = '2024-02-01 00:00:00.000', 
		updatedby = 'CDM-35317', 
		updatedon = now()
	where entityid = '231021274894' 
		and activeflag = 1 
		and enddate is null;

