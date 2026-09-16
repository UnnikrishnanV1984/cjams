/* 
   Issue Description: CDM-43000 Incorrect subsidy payment
   Category/ Module  : Payments
   Root cause: User requested to correct the agreement rate from 30.47 to 927 for the case 3281364
   Fix Provided : Data fix has been provided to update the agreement rate to 927 for the case 3281364
   Pull request# for code fix: N/A
   Reason why no related code fix: N/A 
   Status of the code fix if already submitted and expected prod fix date: N/A
   Backup before update/ delete: N/A
*/
/*
select paymentamout,* from gapagreementrate where gapagreementrateid = '28706627-f319-41b0-bbf4-5b3af2c7173f' and activeflag  = 1;
*/

update gapagreementrate set paymentamout = '927', updatedby = 'CDM-43000', updatedon = now() 
where gapagreementrateid = '28706627-f319-41b0-bbf4-5b3af2c7173f';

-- 30.47
/*
select paymentamt,* from gapratesrevision where gaprateid  = '28706627-f319-41b0-bbf4-5b3af2c7173f' and activeflag  = 1;
*/

update gapratesrevision set paymentamt = '927', approvaldate = now() , updatedby = 'CDM-43000', updatedon = now() 
where gaprateid = '28706627-f319-41b0-bbf4-5b3af2c7173f' and activeflag = 1;
