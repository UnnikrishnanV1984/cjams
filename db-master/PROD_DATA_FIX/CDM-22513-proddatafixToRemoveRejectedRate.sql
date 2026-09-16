/*
   Issue Description: CDM-22513
   Category/ Module  : Prod data fix To remove rejected rate
   Root cause: user requeseted to remove it
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

update gapagreementrate set activeflag = 0, updatedby = 'CDM-22513', updatedon = now() where gapagreementrateid = '723b7a8c-4917-4406-a63e-7c33709925a6';
update gapratesrevision set activeflag = 0, updatedby = 'CDM-22513', updatedon = now() where gaprateid = '723b7a8c-4917-4406-a63e-7c33709925a6';
