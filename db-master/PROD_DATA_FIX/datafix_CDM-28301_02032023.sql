-- CDM-28301 - bug in case
/*
-- Issue Description: 

	221020291373:Although this case shows it was screened in and my supervisor has
     assigned me this case, it does not show up on my tree nor allow me
     to make contact notes. My supervisor can not even add contact notes.

     Please change the case status to accepted as this CPS case was created from     
    Intake # I221010355481 which created on 12/29/2022 with supervisor decision as screened In.
	

*/


select * from IntakeServiceRequest where servicerequestnumber = '221020291373';

update IntakeServiceRequest set intakeserreqstatustypeid = '52ad4cc7-e8f8-4cbb-9e27-d86f2b817690',updatedby = 'CDM-28301',updatedon = NOW() where servicerequestnumber = '221020291373';

select ServiceRequestTypeConfigIdDispostionId, * 
from IntakeServiceRequestDispositionCode 
    where IntakeServiceId = 'a1589777-12fd-48dd-822d-3984685296b1'
    and intakeservicerequestdispositioncodeid  = '3e8f760c-f88c-47ca-8e2c-b6d83093dc8a'
    and activeflag = 1;

update IntakeServiceRequestDispositionCode set ServiceRequestTypeConfigIdDispostionId = '4c6d4e10-5572-4cb0-8bd0-5d596e3e2588',updatedby='CDM-28301',updatedon = NOW()    where 
IntakeServiceId = 'a1589777-12fd-48dd-822d-3984685296b1'
    and intakeservicerequestdispositioncodeid  = '3e8f760c-f88c-47ca-8e2c-b6d83093dc8a'
    and activeflag = 1;