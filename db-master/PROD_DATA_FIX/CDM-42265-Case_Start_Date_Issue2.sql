/*
   Issue Description: CDM-42265
   Category/ Module  :  Case Profile
   Root cause: user wants to change case start date 
   Pull request# for code fix: 
   Reason why no related code fix: 
 
*/


update servicecase
set startdate='2024-10-08 10:57:09',effectivedate='2024-10-08 10:57:09',
insertedon='2024-10-08 10:57:09',updatedon=now(), updatedby='CDM-42265'
where servicecasenumber ='241030411775';

update servicecasedisposition
set statusdate='2024-10-08 10:57:09',effectivedate='2024-10-08 10:57:09',
insertedon='2024-10-08 10:57:09',updatedon=now(), updatedby='CDM-42265'
where servicecaseid = '2641f10e-9526-4349-bca5-3f97a50ef6d6';

update caseassignment
set startdate='2024-10-08 00:00:00',insertedon='2024-10-08 10:57:31',assigndate='2024-10-08 00:00:00',
updatedon=now(), updatedby='CDM-42265'
where objectid ='2641f10e-9526-4349-bca5-3f97a50ef6d6';

update intakesnapshot 
SET jsondata = 
jsonb_set(jsonb_set(jsondata::jsonb, '{General,CreatedDate}', concat('"','2024-10-08T14:39:01.207Z','"')::jsonb, true),
									 '{General,RecivedDate}', concat('"','10/08/2024 10:39:01 AM','"')::jsonb, true),
updatedon = now(), updatedby ='CDM-42265'
where intakenumber = 'I241013155155'
and activeflag = 1;	

update intakeservicerequest
set ReportedDate ='2024-10-08 10:51:18.001'
where servicecaseid  ='2641f10e-9526-4349-bca5-3f97a50ef6d6';

update routing
set insertedon ='2024-10-08 10:55:13.850', updatedon = '2024-10-08 10:57:07.853', updatedby ='CDM-42265'
where objectid = 'I241013155155';
