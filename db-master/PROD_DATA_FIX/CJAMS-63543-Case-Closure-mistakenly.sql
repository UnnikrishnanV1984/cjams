/*
   Issue Description: 251023139408:HelloThe supervisor mistakenly closed this case. We are requesting that the case be reopened to allow for further investigation Screen
   Category/ Module  :  data fix to reopen CPS-IR : 221020288068
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
   Need to do data fix
*/

-- inspect the INVESTIGATION FINDINGS page - api/Intakeservicerequestdispositioncodes/GetHistory to get "dispstatus": "Completed", "intakeservicerequestdispositioncodeid":"a34e277f-8fe6-4223-898a-3ab7c7318509"
--select * from intakeservicerequestdispositioncode i where intakeserviceid = 'e78592f5-22c8-4c61-8ef4-4d39af18289b'

update  Intakeservicerequestdispositioncode 
set activeflag = 0,
	updatedby ='CJAMS-63543', 
	updatedon = now() 
where intakeservicerequestdispositioncodeid = 'a34e277f-8fe6-4223-898a-3ab7c7318509'
	and activeflag = 1;

update routing
set activeflag = 0,
updatedby = 'CJAMS-63543',
	updatedon = now()
where routingid = '91a9ee4c-09f9-414d-b927-c28ecd43f765' 
and objectid = 'a34e277f-8fe6-4223-898a-3ab7c7318509' -- objectid = intakeservicerequestdispositioncodeid
	and activeflag = 1;

update intakeservicerequest 
set exitdate = null,
	updatedby ='CJAMS-63543',
	updatedon = now(), 
	intakeserreqstatustypeid = '52ad4cc7-e8f8-4cbb-9e27-d86f2b817690' --7995cecb-062d-406c-8ea9-b1da4b1877d8 (completed)
where intakeserviceid = 'e78592f5-22c8-4c61-8ef4-4d39af18289b'
	and activeflag =1;

-- updating case assignment to case worker
update caseassignment
set enddate = null,
	updatedby = 'CJAMS-63543',
	updatedon = now()
where caseassignmentid = '539932d2-9751-437a-a01d-7d0ace850641' and activeflag = 1;

-- update the ended personprogram
--select subprogramkey ,enddate ,endreasonkey ,activeflag ,* from personprogramarea c where objectid ='e78592f5-22c8-4c61-8ef4-4d39af18289b'
update personprogramarea 
	set enddate = null, 
	updatedby='CJAMS-63543',
	updatedon=now()
where objectid = 'e78592f5-22c8-4c61-8ef4-4d39af18289b'
	and activeflag =1;
