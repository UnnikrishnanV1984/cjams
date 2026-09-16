/*
   Issue Description: CDM-15709
   Category/ Module  :  child welfare 
   Root cause: user wants to remove
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

update intakedastaging set activeflag = 0, updatedby = 'CDM-15709', updatedon = now() 
where intakenumber ='I211010179272' and activeflag =1; 

update intakedastatus set activeflag =0, updatedby = 'CDM-15709', updatedon = now() 
where intakenumber ='I211010179272' and activeflag =1;