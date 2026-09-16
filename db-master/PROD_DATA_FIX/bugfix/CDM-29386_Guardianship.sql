-- CDM-29386 - Guardianship
/*
-- Issue Description: 
   User Request to change GAP subsidy rate from $29.16 to $887.00
   
-- Case ID: 3301207
-- Client ID: 4402349 (RONNIE-ELLI JOHNS) 
-- Provider ID: 6025895 (Ronnie Johns)
-- GAP Agreement Rate ID: '0ebdc151-ff35-43e3-a31a-5ab692e9c669'
-- Client ID: 200567453 (Abel Johns) 
-- Provider ID: 6025895 (Ronnie Johns)
-- GAP Agreement Rate ID: '82c81131-c31e-405f-bacd-6bb9db0538b6'
-- Client ID: 3922538 (ANNABELLA JOHNS) 
-- Provider ID: 6025895 (Ronnie Johns)
-- GAP Agreement Rate ID: '96a06664-4aca-459a-813a-836ce0f30c88'
-- Client ID: 4402353 (BRANDON JOHNS) 
-- Provider ID: 6025895 (Ronnie Johns)
-- GAP Agreement Rate ID: '68661c8f-14af-484d-8695-636436521858'
-- Rate Fix as $887.00 (old value is $29.16 )

A
  
-- Category/ Module: Accounts Payable (Finance Management) 
-- Root cause: User error 
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- Update Rate
select gapagreementid, startdate, enddate, paymentamout, updatedby, updatedon, activeflag 
	from gapagreementrate 
where gapagreementrateid in ('0ebdc151-ff35-43e3-a31a-5ab692e9c669','82c81131-c31e-405f-bacd-6bb9db0538b6',
'96a06664-4aca-459a-813a-836ce0f30c88','68661c8f-14af-484d-8695-636436521858')
	and activeflag = 1 ;

update gapagreementrate 
set paymentamout = 887.00,
	updatedby = 'CDM-29386',
	updatedon = now()
where gapagreementrateid in ('0ebdc151-ff35-43e3-a31a-5ab692e9c669','82c81131-c31e-405f-bacd-6bb9db0538b6',
'96a06664-4aca-459a-813a-836ce0f30c88','68661c8f-14af-484d-8695-636436521858')
	and activeflag = 1 ;

-- Datafix to trigger Under/Over 
select approvalstatustypekey, approvaldate, ratestartdate, rateenddate, paymentamt, activeflag, updatedby, updatedon 
	from gapratesrevision 
where gaprateid in ('0ebdc151-ff35-43e3-a31a-5ab692e9c669','82c81131-c31e-405f-bacd-6bb9db0538b6',
'96a06664-4aca-459a-813a-836ce0f30c88','68661c8f-14af-484d-8695-636436521858') ;

update gapratesrevision 
set paymentamt = 887.00,
	approvaldate = now(),
	updatedby = 'CDM-29386',
	updatedon = now()
where gaprateid in ('0ebdc151-ff35-43e3-a31a-5ab692e9c669','82c81131-c31e-405f-bacd-6bb9db0538b6',
'96a06664-4aca-459a-813a-836ce0f30c88','68661c8f-14af-484d-8695-636436521858') ;
