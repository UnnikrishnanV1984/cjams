/*
   Issue Description: CJAMS-61380
   Category/ Module  : Case Reopen
   Root cause: User Error, User requested to reopen case.
   Pull request# for code fix: 
   Reason why no related code fix: User Error
*/
/*
-- Completed 
select * from intakeserreqstatustype where intakeserreqstatustypeid = '7995cecb-062d-406c-8ea9-b1da4b1877d8';
--open
select * from intakeserreqstatustype where intakeserreqstatustypeid = 'c8dbf10f-843d-4b40-97ca-288d750463da';
-- accepeted: 52ad4cc7-e8f8-4cbb-9e27-d86f2b817690
*/

-- inspect the summary page to get intakeserviceid = '57c9efab-c0a4-46ad-afac-acb7e8994600'
update intakeservicerequest set exitdate = null,updatedby ='CJAMS-61380', updatedon = now(), intakeserreqstatustypeid = '52ad4cc7-e8f8-4cbb-9e27-d86f2b817690'
where intakeserviceid = '1ce034f1-0fba-4823-a763-ace19b3d7b8d' and activeflag=1;

-- inspect the INVESTIGATION FINDINGS page - api/Intakeservicerequestdispositioncodes/GetHistory to get "dispstatus": "Completed", "intakeservicerequestdispositioncodeid":"b40b4ee7-e309-4ef0-b43f-ad5bfd0869e9"
update  Intakeservicerequestdispositioncode set activeflag = 0,updatedby ='CJAMS-61380', updatedon = now() 
where intakeservicerequestdispositioncodeid in ('0c615c19-dbb1-48b3-9845-2cd8e1cca339','409e0cbb-808e-4f17-96c3-4335afaaaa5c')
and activeflag =1;

update  Intakeservicerequestdispositioncode set servicerequesttypeconfigiddispostionid = '9a333c30-8043-4732-9f9a-622b8d8038da',updatedby ='CJAMS-61380', updatedon = now() 
where intakeservicerequestdispositioncodeid = '33841ad0-cae6-4beb-b741-b69890de16b1' and activeflag =1;

-- remove program area
--Malachi Hall
update personprogramarea set enddate = null, updatedby = 'CJAMS-61380', updatedon = now() 
where personprogramid = 'd9a50395-00ef-4dc6-9490-05682a472802' and activeflag =1;

--Messiah Hall
update personprogramarea set enddate = null, updatedby = 'CJAMS-61380', updatedon = now() 
where personprogramid = 'd3e74d57-a57a-4464-aa95-cb73268930bb' and activeflag =1;

--Makaiya Reed Hall
update personprogramarea set enddate = null, updatedby = 'CJAMS-61380', updatedon = now() 
where personprogramid = '9b181aa9-43b5-4350-8bb6-bd10cc9ec840' and activeflag =1;

--case assignement
update caseassignment 
set enddate = null, updatedby = 'CJAMS-61380', updatedon = now() 
where caseassignmentid ='6acb9e22-975d-42f1-851f-cdc32313f673' and activeflag = 1
and objectid = '1ce034f1-0fba-4823-a763-ace19b3d7b8d';