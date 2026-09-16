/*
  Issue Description:  CDM-40947
   Category/ Module  :  Case Timeline
   Root cause: User request to Data fix remove the intake
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
   Backup before update/ delete: 
*/

update intakedastaging set activeflag = 0,
updatedby = 'CDM-40947', updatedon = now()
where intakenumber = 'I221010258461' and activeflag = 1;

update intakedastatus set activeflag = 0,
updatedby = 'CDM-40947', updatedon = now()
where intakenumber = 'I221010258461' and activeflag = 1;