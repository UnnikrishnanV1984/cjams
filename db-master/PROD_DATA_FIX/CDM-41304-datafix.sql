/*
  Issue Description:  CDM-41304
   Category/ Module  :  Case Timeline
   Root cause: User request to Data fix remove the intake from the dashboard
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
   Backup before update/ delete: 
*/

update IntakeDAStaging set status = 'Complete', updatedby = 'CDM-41304', updatedon = now() 
where intakenumber = 'CW10184570' and activeflag = 1;