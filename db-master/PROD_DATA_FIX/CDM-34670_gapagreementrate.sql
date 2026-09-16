/*
   Issue Description: CDM-34670
   Category/ Module : Prod data fix to update the agreementrate
   Root cause: 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
   Need to do data fix
*/
--Previous agreement rate 58
update gapagreementrate set paymentamout = 892, updatedon = now(), updatedby = 'CDM-34670' 
where gapagreementid = '607212a1-9144-474c-aa92-af86cb9aa7d4' and gapagreementrateid = 'f356bda1-21e5-42b3-a2a7-f685fabd6fb1';
update gapratesrevision set paymentamt = 892, approvaldate =  now(), updatedon = now(), updatedby = 'CDM-34670' 
where gaprateid = 'f356bda1-21e5-42b3-a2a7-f685fabd6fb1' and activeflag = 1;
