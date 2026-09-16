/*
Issue Description: CJAMS-62088 Wrong Service Case Selected
Category/Module: Service case
Root cause: User error as CPS-AR : 251023115716 is connected to service case # 251030558921, and the service case is closed on 09/03/2025, and approved by Amanda Bates.
            Data fix needed to correct the case id as 3218290.
Fix provided: Data fix has been done to connect service case to correct intake.
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: User error and data fix needed to map correct service case.
*/

update intakeservicerequest
set servicecaseid = '5c087f98-5f15-450c-a763-d8e2ebc51756',
    updatedby ='CJAMS-62088',
    updatedon = now()
where servicecaseid = '56e1d669-adc1-4f87-b338-af8d25632128'
and intakeserviceid = '38cd5a17-bdc0-400a-a6af-9d0e1856b2a5'    
and activeflag =1;


