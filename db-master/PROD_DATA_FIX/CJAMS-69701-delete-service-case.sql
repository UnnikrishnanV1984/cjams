/*
   Issue Description: CJAMS-69701
   Category/ Module: Service case
   Root cause: User requested to delete the service cases (261023748282, 261023748267) as they all (261023748287, 261023748282, 261023748267) have same referral
   Fix Provided: Data fix has been provided by deleting the services case as requested
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/


update intakeservicerequest 
set activeflag =0, updatedby ='CJAMS-69701', updatedon =now()
where servicerequestnumber in ('261023748282', '261023748267') and activeflag =1;

update intakeservicerequestsdm
set activeflag=0, updatedby ='CJAMS-69701', updatedon =now()
where intakeserviceid in ('1d41064d-766a-43b8-99b2-65f4d7658bec', '18115015-0a4d-40de-9962-1eb944dd0a74') and activeflag=1;

update intakeservicerequestdispositioncode
set activeflag=0, updatedby ='CJAMS-69701', updatedon =now()
where intakeserviceid in ('1d41064d-766a-43b8-99b2-65f4d7658bec', '18115015-0a4d-40de-9962-1eb944dd0a74') and activeflag=1;

--select activeflag,* from caseassignment where objectid in ('1d41064d-766a-43b8-99b2-65f4d7658bec', '18115015-0a4d-40de-9962-1eb944dd0a74');

update personprogramarea
set activeflag=0, updatedby ='CJAMS-69701', updatedon =now()
where objectid in ('1d41064d-766a-43b8-99b2-65f4d7658bec', '18115015-0a4d-40de-9962-1eb944dd0a74') and activeflag=1;

update actor
set activeflag=0, updatedby ='CJAMS-69701', updatedon =now()
where intakeserviceid in ('1d41064d-766a-43b8-99b2-65f4d7658bec', '18115015-0a4d-40de-9962-1eb944dd0a74') and activeflag=1;

update intakeservicerequestactor
set activeflag=0, updatedby ='CJAMS-69701', updatedon =now()
where intakeserviceid in ('1d41064d-766a-43b8-99b2-65f4d7658bec', '18115015-0a4d-40de-9962-1eb944dd0a74') and activeflag=1;

update personrole
set activeflag=0, updatedby ='CJAMS-69701', updatedon =now()
where intakeserviceid in ('1d41064d-766a-43b8-99b2-65f4d7658bec', '18115015-0a4d-40de-9962-1eb944dd0a74') and activeflag=1;

update actorrelationship
set activeflag=0, updatedby ='CJAMS-69701', updatedon =now()
where intakeserviceid in ('1d41064d-766a-43b8-99b2-65f4d7658bec', '18115015-0a4d-40de-9962-1eb944dd0a74') and activeflag=1;

update personroletype
set activeflag=0, updatedby ='CJAMS-69701', updatedon =now()
where personroleid in ('03116731-a0fb-42fd-8a7d-cba4393cd7f2',
'f6042f4b-79e0-40b5-aaee-b37bbc64bed0',
'601e9ae9-37ae-412f-9b1b-33e58594e584',
'894c0e7e-3fbf-406c-8868-e4452ac604cc',
'ada13521-bb79-4544-931e-1597010a70b9',
'60812553-2b51-42db-8186-78ae08e184ec',
'6125e87c-7308-461f-b80c-62e2706843ae',
'1d19287a-11a0-4d5d-9ae6-90cd27c876c7') and activeflag=1;
