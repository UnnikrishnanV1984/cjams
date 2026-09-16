
/*
Issue: Case Connecting
Root Cause: 1. Intake# I261013916031 - The Parents (CJAMS PID# 204793199 and CJAMS PID# 204001288) profiles need to be deleted and replaced with (CJAMS PID# 202191179 and CJAMS PID# 200391742). This is because the Parents added in the Intake have different CJAMS PID when compared with Service Case# 231030224559.
            2. Intake # I261013916031, which is connected to Case # 261030648989, needs to be connected to Case # 231030224559, and Case # 261030648989 needs to be deleted.
Fix Provided (Data Fix Only): Data fix was done by replacing the parents profiles with new PIDs and connecting the intake to another case and deleting the old case.
Data/Code fix ticket#: CJAMS-65871
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: Used the database queries to complete this ticket.
Status of the code fix: Data fix completed, PR raised for documentation.
Backup before update/ delete:Query:
*/
--Replace the Parents profiles with new PIDs.
update actor set personid='b3de3429-cdb2-47f0-96ef-e13df1e74fef',updatedby='CJAMS-65871',updatedon = now()
where actorid='9befc398-1a4f-4537-99e1-3e9220a5c3b2';


update actor set personid='ea987dc2-13cf-46a5-9a90-6c03d4d8dcc6',updatedby='CJAMS-65871',updatedon = now()
where actorid='5668b7f2-da0f-4c24-8018-f3bb27657f47';


update intakeservicerequestactor set personid='b3de3429-cdb2-47f0-96ef-e13df1e74fef',updatedby='CJAMS-65871',updatedon = now()
where intakeservicerequestactorid='aed43e33-d5ae-459b-ba52-d4724d2eb5f3';


update intakeservicerequestactor set personid='ea987dc2-13cf-46a5-9a90-6c03d4d8dcc6',updatedby='CJAMS-65871',updatedon = now()
where intakeservicerequestactorid='6c3f3df9-35a4-4d28-a8c5-97d262efdf4e';


--Delete the old case.
update servicecase set activeflag =0, updatedby = 'CJAMS-65871', updatedon = now() 
where servicecaseid = 'dc845d77-8f3e-4885-8ed1-f613710adc85' and activeflag=1;

update servicecasedisposition set activeflag = 0, updatedby = 'CJAMS-65871', updatedon = now() 
where servicecaseid = 'dc845d77-8f3e-4885-8ed1-f613710adc85' and activeflag=1;

update servicecaserequest set activeflag = 0, updatedby = 'CJAMS-65871', updatedon = now() 
where servicecaseid = 'dc845d77-8f3e-4885-8ed1-f613710adc85' and activeflag=1;

update routing set activeflag=0, updatedby = 'CJAMS-65871', updatedon = now() where objectid='dc845d77-8f3e-4885-8ed1-f613710adc85'
 and activeflag = 1;

update caseassignment set activeflag = 0, updatedby = 'CJAMS-65871', updatedon = now() 
where objectid = 'dc845d77-8f3e-4885-8ed1-f613710adc85' and activeflag=1;

update actor set personid ='ea987dc2-13cf-46a5-9a90-6c03d4d8dcc6',updatedby='CJAMS-65871',updatedon = now()
where actorid in ('40d736cf-77ea-4cd8-8830-f26eae5148c3','fc8ff940-c188-4c99-8654-521be84d5b19','333d9750-66bb-47b9-b3a6-98926d021e96');

update actor set personid ='b3de3429-cdb2-47f0-96ef-e13df1e74fef',updatedby='CJAMS-65871',updatedon = now()
where actorid in ('09a26e3c-8ec6-4d2e-8694-0637df3df744','f4b4dbbb-760d-455c-bb1b-c8c995c7876b','05bac012-286b-4e70-acd4-c41bddb71e57');

--Connect intakde from one case to another case.
select * from cjams.createservicecase('54359993-f0df-46bf-9f3b-9b379f1adb0d', '73ebe8d9-ceaf-43d4-84bf-f7a553cb5fdd', 0,'344ed8ee-d8d4-4052-92d3-577713dc3c21',null,'','intake',null);
