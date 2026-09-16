/*
  Issue Description:  CJAMS-58159
   Category/ Module  :  Assessments
   Root cause: User requested to remove the intake # I202100552930 
   Pull request# for code fix: NA
   Reason why no related code fix: NA
   Status of the code fix if already submitted and expected prod fix date: 
   Backup before update/ delete: NA
*/

update intakedastatus set 
activeflag=0,
updatedon=now(),
updatedby='CJAMS-58159'
where intakenumber='I202100552930';

update intakedastaging set
activeflag=0,
updatedon=now(),
updatedby='CJAMS-58159'
where intakenumber='I202100552930';