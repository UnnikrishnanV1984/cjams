/*
   Issue Description: CJAMS-60251
   Category/ Module  : data fix to delete referral # I241013192362 as the worker 
            incorrectly created the intake and it has not been submitted for review.
   Root cause: user requested to delete referral # I241013192362 as the worker 
            incorrectly created the intake and it has not been submitted for review.
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/

update intakedastaging 
  set activeflag = 0,
      updatedby = 'CJAMS-60251', 
      updatedon = now()
where intakenumber = 'I241013192362'   
  and activeflag = 1;
  
  update intakedastatus 
  set activeflag = 0,
      updatedby = 'CJAMS-60251', 
      updatedon = now()
where intakenumber = 'I241013192362'   
  and activeflag = 1;