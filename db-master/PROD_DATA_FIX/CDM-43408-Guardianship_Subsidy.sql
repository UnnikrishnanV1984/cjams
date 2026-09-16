
/*
   Issue Description: CDM-43408
   Category/ Module  :  Guardianship Subsidy
   Root cause: user requeseted to update subsidy rate
   Pull request# for code fix: 
   Reason why no related code fix: user error.
   Status of the code fix if already submitted and expected prod fix date: 
*/


--Updating payment amount in gapagreementrate
update gapagreementrate
set paymentamout = 902, enddate='2025-10-31', updatedby = 'CDM-43408', updatedon = now()
where gapagreementrateid = '76b6606c-46fd-45d4-9d55-8d1fb541e4ee' and activeflag = 1;

--Updating payment amount in gapratesrevision
update gapratesrevision
set paymentamt = 902, rateenddate='2025-10-31', approvaldate = now(), updatedby = 'CDM-43408', updatedon = now()
where gaprateid = '76b6606c-46fd-45d4-9d55-8d1fb541e4ee';


--Updating payment amount in gapagreementrate
update gapagreementrate
set paymentamout = 887, enddate='2025-10-31', updatedby = 'CDM-43408', updatedon = now()
where gapagreementrateid = '67b177da-1a6c-43ca-9f8c-0a89156c794c' and activeflag = 1;

--Updating payment amount in gapratesrevision
update gapratesrevision
set paymentamt = 887, rateenddate='2025-10-31', approvaldate = now(), updatedby = 'CDM-43408', updatedon = now()
where gaprateid = '67b177da-1a6c-43ca-9f8c-0a89156c794c';


--Updating payment amount in gapagreementrate
update gapagreementrate
set paymentamout = 887, enddate='2025-10-31', updatedby = 'CDM-43408', updatedon = now()
where gapagreementrateid = 'ccabaf21-a271-488d-a392-e9914fb70557' and activeflag = 1;

--Updating payment amount in gapratesrevision
update gapratesrevision
set paymentamt = 887, rateenddate='2025-10-31', approvaldate = now(), updatedby = 'CDM-43408', updatedon = now()
where gaprateid = 'ccabaf21-a271-488d-a392-e9914fb70557';
