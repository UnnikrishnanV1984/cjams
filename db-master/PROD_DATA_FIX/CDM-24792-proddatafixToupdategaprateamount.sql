/*
   Issue Description: CDM-24792
   Category/ Module  : Prod data fix to update gap rate amount
   Root cause: 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/

-- 29.66
update gapagreementrate set paymentamout = '902.16', updatedby = 'CDM-24792', updatedon = now() 
where gapagreementrateid = '048eadd8-c88a-4913-8cfb-d7a82b201c41';

-- 29.66
update gapratesrevision set paymentamt = '902.16', approvaldate = now() , updatedby = 'CDM-24792', updatedon = now() 
where gaprateid = '048eadd8-c88a-4913-8cfb-d7a82b201c41' and activeflag = 1;