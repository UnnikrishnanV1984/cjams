
/*
Issue:221030013654:251022980241:I am trying to re-open the Safe C- as there are two children listed on the SAFE - C that do not reside in the household.
Root Cause:Duplicate SAFE-C assessments were created and casued confusion in the OHP Milestone report due to ovelapping approval .
Fix Provided (Data Fix Only): as per data fix updated the 
assessment.
Data/Code fix ticket#:CJAMS-59195
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: Data-only issue; no logic/code changes required.
Status of the code fix: Data fix completed, PR raised for documentation.
Backup before update/ delete:Query:
*/

update assessment
set activeflag = 0 ,updatedby = 'CJAMS-59195', updatedon = now()
where assessmentid = '738d0276-9a7d-4260-bf52-2358bccc47ef' and activeflag =1;



update assessment_history
set activeflag = 0 ,updatedby = 'CJAMS-59195', updatedon = now()
where assessmenthistoryid  in('9abf5058-3e2c-43c3-b574-6bb139c3003b',
'50b12e04-deff-4bb6-8afb-0efeaeede5f7' )and activeflag =1;



update assessmentactor
set activeflag = 0 ,updatedby = 'CJAMS-59195', updatedon = now()
where assessmentactorid  in('be7e7388-d5f0-4b61-bebe-f821617c1fac',
'f2807284-78fd-4445-8ff5-41edd7645ad2',
'd64bde7e-4c4a-4271-8139-c9362d05b071' )and activeflag =1;


update assessmentcomments
set activeflag = 0 ,updatedby = 'CJAMS-59195', updatedon = now()
where assessmentcommentsid  in('8f705659-3b4e-4803-a446-5b8ffb10df8c')and activeflag =1;


update routing
set activeflag = 0 ,updatedby = 'CJAMS-59195', updatedon = now()
where objectid  in('2341dc66-1e90-4171-9f4c-5f91fe9889c0')and activeflag =1;
