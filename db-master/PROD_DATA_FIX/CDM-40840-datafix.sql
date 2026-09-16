/*
  Issue Description:  CDM-40840
   Category/ Module  :  Application
   Root cause: User requested to remove the Safe c records
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
   Backup before update/ delete: 
*/


update cjams.assessment 
set activeflag =0,
updatedby ='CDM-40840',
updatedon = now()
where assessmentid in ('4748c770-7506-4b83-b6c4-f91768577e94','8e7ad64c-71b4-4b9a-a86d-6cdea568a9f2',
'908ed354-dc5e-467d-abea-e9e012de70c0',
'66a4f75e-d018-412e-a7e3-9d358ae8c2a5',
'c525709c-78d8-4b2e-9cb8-46cd391b42ab')
and activeflag=1;

update assessmentactor
set activeflag =0,
updatedby ='CDM-40840',
updatedon = now()
where assessmentid in ('4748c770-7506-4b83-b6c4-f91768577e94','8e7ad64c-71b4-4b9a-a86d-6cdea568a9f2',
'908ed354-dc5e-467d-abea-e9e012de70c0',
'66a4f75e-d018-412e-a7e3-9d358ae8c2a5',
'c525709c-78d8-4b2e-9cb8-46cd391b42ab')
and activeflag=1;

update assessmentcomments
set activeflag =0,
updatedby ='CDM-40840',
updatedon = now()
where assessmentid in ('4748c770-7506-4b83-b6c4-f91768577e94','8e7ad64c-71b4-4b9a-a86d-6cdea568a9f2',
'908ed354-dc5e-467d-abea-e9e012de70c0',
'66a4f75e-d018-412e-a7e3-9d358ae8c2a5',
'c525709c-78d8-4b2e-9cb8-46cd391b42ab')
and activeflag=1;


update assessment_history
set activeflag =0,
updatedby ='CDM-40840',
updatedon = now()
where assessmentid in ('4748c770-7506-4b83-b6c4-f91768577e94','8e7ad64c-71b4-4b9a-a86d-6cdea568a9f2',
'908ed354-dc5e-467d-abea-e9e012de70c0',
'66a4f75e-d018-412e-a7e3-9d358ae8c2a5',
'c525709c-78d8-4b2e-9cb8-46cd391b42ab')
and activeflag=1;


update routing
set activeflag =0,
updatedby ='CDM-40840',
updatedon = now()
where objectid in ('4748c770-7506-4b83-b6c4-f91768577e94','8e7ad64c-71b4-4b9a-a86d-6cdea568a9f2',
'908ed354-dc5e-467d-abea-e9e012de70c0',
'66a4f75e-d018-412e-a7e3-9d358ae8c2a5',
'c525709c-78d8-4b2e-9cb8-46cd391b42ab')
and eventcode= 'ASST';