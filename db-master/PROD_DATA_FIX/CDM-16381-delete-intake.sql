update intakedastaging set activeflag = 0, updatedby = 'CDM-16381', updatedon = now() 
where intakenumber ='I211010185344' and activeflag =1; 

update intakedastatus set activeflag =0, updatedby = 'CDM-16381', updatedon = now() 
where intakenumber ='I211010185344' and activeflag =1;

update intakeservicerequest set activeflag = 0, updatedby = 'CDM-16381', updatedon = now()
where intakenumber = 'I211010185344';