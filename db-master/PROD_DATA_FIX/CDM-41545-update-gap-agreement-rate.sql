/* 
   Issue Description: CDM-41545 Incorrect subsidy payment
   Category/ Module  : Payments
   Root cause: User requested to correct the agreement rate from 30.98 to 942.16 for the case 3295743
   Fix Provided : Data fix has been provided to update the agreement rate to 942.16 for the case 3295743
   Pull request# for code fix: N/A
   Reason why no related code fix: N/A 
   Status of the code fix if already submitted and expected prod fix date: N/A
   Backup before update/ delete: N/A
*/


-- 30.98
update gapagreementrate set paymentamout = '942.16', updatedby = 'CDM-41545', updatedon = now() 
where gapagreementrateid = 'b4a3789b-8979-4bc9-969e-4f072c8d89eb';

-- 30.98
update gapratesrevision set paymentamt = '942.16', approvaldate = now() , updatedby = 'CDM-41545', updatedon = now() 
where gaprateid = 'b4a3789b-8979-4bc9-969e-4f072c8d89eb' and activeflag = 1;