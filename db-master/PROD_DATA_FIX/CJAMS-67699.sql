
/*
Issue Description:CJAMS-67699 correction to overdue reason
Category/Module: Case Management
Root cause: 261023704573:Please correct overdue reason. Case is already closed. For alleged victim, it should state: "Alleged victim unavailable > Attempted face to face > 1-2 attempts
Fix provided: Data fix has been promoted to update the LRR reason value for CPS AR # 261023704573 as: Contact with Alleged Victim Completed : Alleged victim unavailable / Attempted Face to Face / 1-2 Attempts  from backend
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: No
Reason why no related code fix: Data fix 
*/
update cpsresponsetimeractions 
set cpsresponsetimerreason1 = 'VAVU', 
    cpsresponsetimerreason2 = 'VAFF',
    cpsresponsetimerreason3 = 'V12F',
    updatedby ='CJAMS-67699',
    updatedon =now()
where intakeserviceid = 'b6212671-5638-4f34-99ee-a387f4c0870b'
and cpsresponsetimeractionsid = '53fd6cc9-9d77-4d98-a429-b839bdb8ba1c'
and activeflag = 1;