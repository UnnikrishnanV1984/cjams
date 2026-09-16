/*
 Issue Description: CDM-16837
 Category/ Module:linking intake
 Root cause: update
 Pull request# N/A
 Reason why no related code fix: N/A
 Status of the code fix if already submitted and expected prod fix date: N/A
*/
update intakeservicerequest 
set activeflag = 1,reporteddate = '2021-09-08 15:25:32', servicerequestnumber = (select sc.servicecasenumber from servicecase sc where sc.servicecaseid = (select servicecaseid from intakeservicerequest i  where intakeserviceid = '9aa17937-0e9c-4438-b1d2-10e99d0e209a')), updatedon = now(), updatedby = 'CDM-16837' 
where intakeserviceid = '9aa17937-0e9c-4438-b1d2-10e99d0e209a';