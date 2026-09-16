
/*
Issue Description:CJAMS-67705 correction to overdue reason
Category/Module: Case Management
Root cause: 261023683084:Overdue reason box erroneously showing missing drop down selections
Fix provided: Data fix has been promoted to update the LRR reason value for CPS AR # 261023683084 as: Contact with Alleged Victim Completed : Alleged victim unavailable / Attempted Face to Face / 1-2 Attempts  from backend
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: No
Reason why no related code fix: Data fix 
*/
update cpsresponsetimeractions 
set cpsresponsetimerreason1 = 'VAVU', 
    cpsresponsetimerreason2 = 'VAFF',
    cpsresponsetimerreason3 = 'V12F',
    updatedby ='CJAMS-67705',
    updatedon =now()
where intakeserviceid = '9472a56c-bbdf-4dd7-b676-5bc9c96772c4'
and cpsresponsetimeractionsid = '719c57ee-616f-4650-b881-e8a58da2b35a'
and activeflag = 1;