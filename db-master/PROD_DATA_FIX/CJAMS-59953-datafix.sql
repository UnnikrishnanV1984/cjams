/* 
    Issue Description: CJAMS-59953
   Category/ Module  : Intake removal
   Root cause: :As per the system design, intake cannot be deleted diretly from the UI once created. 
   User requested to remove the intake through data fix
   Fix provided: Data fix has been promoted to remove the intake
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
   Backup before update/ delete:
*/

update intakedastaging
set activeflag=0, updatedby='CJAMS-59953', updatedon=now()
where intakenumber='I251013249593' and activeflag=1;


update intakedastatus
set activeflag=0, updatedby='CJAMS-59953', updatedon=now()
where intakenumber='I251013249593' and activeflag=1;

