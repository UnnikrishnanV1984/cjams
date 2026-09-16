/*
   Issue Description: CJAMS-61905
   Category/ Module  : Stuck approval
   Root cause: I241012082296:Referral was transferred to Baltimore County but still showing under transfer; referral was approved 
   Pull request# for code fix: It's a data fix
   Reason why no related code fix:  
*/ 

update intaketransfers
set    activeflag = 0,
       updatedby = 'CJAMS-61905',
       updatedon = now()
where  intaketransferid ='84bcab1c-0ff7-48c9-b6fb-cd3dbc9b18b3';