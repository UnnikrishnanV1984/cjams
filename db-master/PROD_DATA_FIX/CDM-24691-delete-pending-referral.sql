/*
   Issue Description: CDM-24691
   Category/ Module  : Prod data fix to delete pending referral
   Root cause: User needs to delete
   Pull request# for code fix: 6226
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/
update intakedastaging set activeflag = 0, updatedby = 'CDM-24692', updatedon = now() 
where intakenumber ='I221010234813' and activeflag =1; 

update intakedastatus set activeflag =0, updatedby = 'CDM-24692', updatedon = now() 
where intakenumber ='I221010234813' and activeflag =1; 

update intakedastaging set activeflag = 0, updatedby = 'CDM-24692', updatedon = now() 
where intakenumber ='I221010258715' and activeflag =1; 

update intakedastatus set activeflag =0, updatedby = 'CDM-24692', updatedon = now() 
where intakenumber ='I221010258715' and activeflag =1; 

update intakedastaging set activeflag = 0, updatedby = 'CDM-24692', updatedon = now() 
where intakenumber ='I221010247444' and activeflag =1; 

update intakedastatus set activeflag =0, updatedby = 'CDM-24692', updatedon = now() 
where intakenumber ='I221010247444' and activeflag =1;

