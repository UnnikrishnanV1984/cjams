/*
   Issue Description: CDM-44187
   Category/ Module  : workload dashboard
   Root cause: user requeseted to remove particular cases from workload dashboard
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/


update caseassignment set fromldssid ='34457960-811a-4d35-a416-b8941d6974cc',
	updatedby ='CDM-44187',
	updatedon =now()
	where caseassignmentid in ('fdb220b8-d3ef-449f-8356-7c2d8d27ddee','3756279f-b8ba-4031-b240-0006fbed4681') and activeflag =1;