/*
  Issue Description: CDM-24880 - duplicate intake delete
   Category/ Module  :  child welfare
   Root cause: 
   Pull request# for code fix: 
   Reason why no related code fix: 
   data fix issue, 
   Backup before update/ delete:
*/

update intakedastatus set activeflag = 0, updatedon = now(), updatedby = 'CDM-24880' where intakenumber = 'I221010257477';

update intakedastaging set activeflag=0, updatedon = now(), updatedby = 'CDM-24880' where intakenumber ='I221010257477' and activeflag=1;

update intakedastatus set activeflag = 0, updatedon = now(), updatedby = 'CDM-24880' where intakenumber = 'I221010229964';

update intakedastaging set activeflag=0, updatedon = now(), updatedby = 'CDM-24880' where intakenumber ='I221010229964' and activeflag=1;



