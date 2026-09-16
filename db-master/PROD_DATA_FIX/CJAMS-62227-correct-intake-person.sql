/*
Issue Description: CJAMS-62227 I251013362285:Katia Washington has Cjams#1379932; however, it would not allow her to be added due to not being able to put the adoption date in. Katia was created under Cjams#204221427.
Category/Module: Intake
Root cause:  Intake is already approved and Incorrect client id is connected to intake  
             We need a data fix to link the correct client id
             Recieved SSA approval and data fix needed for the follows
             Remove the incorrect client id PID# : 204221427 from intake I251013361301
             Add client id 1379932 to the intake I251013361301

Fix provided: Data fix has been done to make the following changes
             1. Remove the incorrect client id PID# : 204221427 from intake I251013361301 
             2. Add client id 1379932 to the intake I251013361301
Data/Code fix ticket#: CJAMS-62227
Regression Impacts: N/A
Is Code fix Required?: N/A
Code fix ticket#: N/A
Reason why no related code fix: Intake is already approved and data fix needed to link the correct person
*/


update intakeservicerequestactor
set personid = '51cb8c81-f431-45bb-ba1a-60f7f5913e8f',
    updatedby = 'CJAMS-62227',
    updatedon = now()
where intakeservicerequestactorid in ('237a46a2-fad0-4ffb-9db4-6cbf685241ac','4d30107b-590e-493b-9a5e-2d6a9ed3fd67') 
and activeflag=1;

update actor
set personid = '51cb8c81-f431-45bb-ba1a-60f7f5913e8f',
    updatedby = 'CJAMS-62227',
    updatedon = now()
where actorid = '8a3b0ddf-85f3-4ec1-b2f5-0422d2fb0e2d' 
and activeflag=1;