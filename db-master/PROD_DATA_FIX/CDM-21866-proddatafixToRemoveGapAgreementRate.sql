/*
   Issue Description: CDM-21866
   Category/ Module  : Prod data fix To remove the Gap agreement rate
   Root cause: user requeseted to remove it
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/


update gapagreementrate set activeflag = 0, updatedby = 'CDM-21866', updatedon = now() where gapagreementrateid = '676b66c4-9f83-4511-a98e-fce552949eeb' and activeflag = 1;
update gapratesrevision set activeflag = 0 , updatedby = 'CDM-21866', updatedon = now() where gaprateid  = '676b66c4-9f83-4511-a98e-fce552949eeb' and activeflag = 1;