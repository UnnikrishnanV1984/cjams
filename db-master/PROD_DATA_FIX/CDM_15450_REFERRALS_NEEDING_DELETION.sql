/*
   Issue Description: CDM-15450
   Category/ Module  :  Living Arrangement  
   Root cause: user wants to remove
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

update intakedastaging set activeflag = 0, updatedby = 'CDM-15450', updatedon = now() 
where intakenumber ='I211010163695' and activeflag =1; 

update intakedastatus set activeflag =0, updatedby = 'CDM-15450', updatedon = now() 
where intakenumber ='I211010163695' and activeflag =1; 

update intakedastaging set activeflag = 0, updatedby = 'CDM-15450', updatedon = now() 
where intakenumber ='I211010175574' and activeflag =1; 

update intakedastatus set activeflag =0, updatedby = 'CDM-15450', updatedon = now() 
where intakenumber ='I211010175574' and activeflag =1;