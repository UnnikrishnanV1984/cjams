/* 
    Issue Description: CDM-39059
  Category/ Module  : Case Timeline
  Root cause: User defect. deleted the Intake # I241012335681 from the worker pending dashboard.
  Pull request# for code fix: 
  Reason why no related code fix: 
  Status of the code fix if already submitted and expected prod fix date: N/A
  Backup before update/ delete: 
*/

update intakedastatus
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CDM-39059'
where intakenumber = 'I241012335681';

update intakedastaging
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CDM-39059'
where intakenumber= 'I241012335681' ;