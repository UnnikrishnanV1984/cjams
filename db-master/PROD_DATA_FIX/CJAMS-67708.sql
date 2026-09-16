
/*
Issue Description:CJAMS-67708 correction to overdue reason
Category/Module: Case Management
Root cause: 261023595843:Overdue Reason Box erroneously deleting information
Fix provided: Data fix has been promoted to update the LRR reason value for CPS AR # 261023595843 as below:Contact with Alleged Victim Completed : Alleged victim unavailable / Family was contacted but unavailable to meet within mandate
Contact with Initial Contact Caregiver Attempted or Completed : Initial Contact Caregiver Unavailable / Family was contacted but unavailable to meet within mandate ,Caseworker Comment : Family contacted and unavailable to meet during mandate timeframe.
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
    caseworkercomments='Family contacted and unavailable to meet during mandate timeframe.',
    updatedby ='CJAMS-67708',
    updatedon =now()
where intakeserviceid = '2ed43077-6e8c-4a60-81ff-3e0319ac97dc'
and cpsresponsetimeractionsid = 'ad8abbb0-6771-41bc-aaa7-c64cb82dacc7'
and activeflag = 1;