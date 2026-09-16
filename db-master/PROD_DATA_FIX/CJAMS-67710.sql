
/*
Issue Description:CJAMS-67710 correction to overdue reason
Category/Module: Case Management
Root cause: 261023635222:Please correct overdue reason on closed case. The drop downs should reflect:Alleged victim > alleged victim unavailable > family was contacted but unavailable to meet within mandateinitial contact caregiver > initial contact caregiver unavailable > family was contacted but unavailable to meet within mandate
Fix provided: Data fix has been promoted to update the LRR reason value for CPS AR # 261023635222 as below:Contact with Alleged Victim Completed : Alleged victim unavailable / Family was contacted but unavailable to meet within mandate
Contact with Initial Contact Caregiver Attempted or Completed : Initial Contact Caregiver Unavailable / Family was contacted but unavailable to meet within mandate 
from backend
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: No
Reason why no related code fix: Data fix 
*/
update cpsresponsetimeractions 
set cpsresponsetimerreason1 = 'VAVU', 
    cpsresponsetimerreason2 = 'VFCM',
    cpsresponsetimerreason7 = 'CCCN',
    cpsresponsetimerreason8 = 'CFMN',
    updatedby ='CJAMS-67710',
    updatedon =now()
where intakeserviceid = '0bc66e95-6657-4964-bd58-6a4296e25140'
and cpsresponsetimeractionsid = 'b5b199eb-ba14-40b0-9428-5d522723ed6c'
and activeflag = 1;
