/*
   Issue Description: CDM-41903 Subsidy rate
   Category/ Module  :Subsidy rate
   Root cause: User requested to update the Subsidy Payment Amount as (929.04) and delete the duplicate record for the case 202108906921.
   Case: 202108906921 Client ID: 2776481 (REBECCA KING) Provider ID: 6007773 (LaTosha Boley)
   Fix provided : Data fix has been done update the subsidy amount and delete the duplicate record.
   Pull request# for code fix: N/A
   Reason why no related code fix: N/A
   Status of the code fix if already submitted and expected prod fix date: N/A
   Backup before update/ delete: N/A
*/

--30.98

update gapagreementrate set paymentamout = '929.04', updatedby = 'CDM-41903', updatedon = now() 
where gapagreementrateid = '9002da42-aec0-42e4-8bdb-c7fb08560a5a';

update gapagreementrate set activeflag = 0, updatedby = 'CDM-41903', updatedon = now() 
where gapagreementrateid = 'fe991deb-64e4-4a7c-8e7e-b7b28397ebcd';

-- 30.98

update gapratesrevision set paymentamt = '929.04', approvaldate = now() , updatedby = 'CDM-41903', updatedon = now() 
where gaprateid = '9002da42-aec0-42e4-8bdb-c7fb08560a5a' and activeflag = 1;

update gapratesrevision set activeflag=0 , updatedby = 'CDM-41903', updatedon = now() 
where gaprateid = 'fe991deb-64e4-4a7c-8e7e-b7b28397ebcd' and activeflag = 1;