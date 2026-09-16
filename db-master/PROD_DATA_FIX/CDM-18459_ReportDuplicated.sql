/*
   Issue Description: CDM-18459
   Category/ Module  :  Report Duplicated 
   Root cause: ba comments to delete intake (insufficient info about intake, is it not needed or duplicated record?).
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/


update cjams.intakedastatus
set activeflag = 0, updatedby = 'CDM-18459', updatedon = now()  
where intakenumber = 'I211010208366' and intakedastatusid 
in ('f39a2456-22f9-4371-80e1-f442e1afd4ff');
 