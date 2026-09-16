/*
   Issue Description: CJAMS-61456
   Category/ Module  : Case Reopen
   Root cause: User Error, User requested to reopen case.
   Pull request# for code fix: 
   Reason why no related code fix: User Error
*/
-- inspect the INVESTIGATION FINDINGS page - api/Intakeservicerequestdispositioncodes/GetHistory to get "dispstatus": "Completed", "intakeservicerequestdispositioncodeid":"b40b4ee7-e309-4ef0-b43f-ad5bfd0869e9"
update  Intakeservicerequestdispositioncode 
set activeflag = 0,updatedby ='CJAMS-61456', updatedon = now() 
where intakeservicerequestdispositioncodeid = 'a9b4df67-8cfb-4b43-b05b-d8052eb2ac65';

-- inspect the summary page to get intakeserviceid = '3d27fa0d-d4fc-46e3-88b5-31633fcf2fdc'
update intakeservicerequest set exitdate = null,updatedby ='CJAMS-61456', updatedon = now(),
intakeserreqstatustypeid = '52ad4cc7-e8f8-4cbb-9e27-d86f2b817690'--accepted
where intakeserviceid = '3d27fa0d-d4fc-46e3-88b5-31633fcf2fdc' and activeflag=1;

--removing appeal coordinator case assignment
--select enddate,effectivedate,effectivetime,activeflag,* from caseassignment where objectid = '3d27fa0d-d4fc-46e3-88b5-31633fcf2fdc'

update caseassignment
set activeflag= 0,
	updatedby = 'CJAMS-61456',
	updatedon = now()
where caseassignmentid = 'dd39be23-6175-487c-8651-6d0388c95c08' and activeflag = 1;

/*
--routing
select fromsecurityusersid,tosecurityusersid,routingstatustypeid,eventcode,* from routing where objectid in ('3d27fa0d-d4fc-46e3-88b5-31633fcf2fdc');
raven.lee@montgomerycountymd.gov
joice.silva@montgomerycountymd.gov
*/

update routing
set activeflag = 0,
updatedby = 'CJAMS-61456',
	updatedon = now()
where routingid = '8b68f06f-5df0-4522-9e0d-95269796d3b1' 
and eventcode = 'APPL' and activeflag = 1;

-- updating case assignment to case worker
update caseassignment
set enddate = null,
	updatedby = 'CJAMS-61456',
	updatedon = now()
where caseassignmentid = '7627e162-75b5-4f93-ae4f-14937cc8a1ac' and activeflag = 1;