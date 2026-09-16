/* 
    Issue Description: CDM-38848
  Category/ Module  : Remove Pending Intake
  Root cause: User request to remove Intake (I241012247419) created by mistake
  Pull request# for code fix: 
  Reason why no related code fix: N/A
  Status of the code fix if already submitted and expected prod fix date: 
  Backup before update/ delete: 
*/

update intakedastatus
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CDM-38848'
where intakenumber = 'I241012247419'
	and activeflag = 1 ;

update intakedastaging
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CDM-38848'
where intakenumber = 'I241012247419'
	and activeflag = 1 ;