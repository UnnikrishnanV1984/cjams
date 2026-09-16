/*
   Issue Description: CDM-18199
   Category/ Module  : Service agreement
   Root cause: User not able to update the agreement date befor the case open date
   Pull request# for code fix: 4191
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/


--agreementdate = 2021-11-01 00:00:00.000
update serviceagreement set agreementdate = '10/18/2021', updatedby = 'CDM-18199', updatedon = now()  where agreementid = 'f5395674-88ee-40b9-92bc-bd8c3bb90537' and activeflag = 1;
