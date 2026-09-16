-- CDM-39542 - Daily GAP Rate
/*
-- Issue Description: 
   User requet to fix the monthly rate on the 2 GAP cases

-- Service Case # 3179974
-- Client ID: 3221018 (SKYLER STURGILL) - fc827ed2-41e0-443d-983d-735ee99e0fb3
-- Provider ID: 5051514	(Teresa Sturgill) - GAP ID: 2504

-- Service Case # 3195476
-- Client ID: 3182447 (JACOB WILLIAM BARNHART) - cef92089-4ff2-4fa4-b6e8-6ebd696ee6de
-- Provider ID: 5087195	(Timothy Schaumburg)  - GAP ID: 3314

-- Category/ Module: Guardianship Subsidy (Finance Management) 
-- Root cause: User error (Wrong monthly rate $892.49 was asked to fix in CDM-38974)
-- Fix Provided: Datafix has been promoted to fix the GAP monthly rate amounts as $875.70 for the fiscal adjustments. 
-- Pull request# N/A 
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

--  Provider id: 5051514
update gapagreementrate set paymentamout = '875.70', updatedby = 'CDM-39542', updatedon = now() 
where gapagreementrateid = '34f3e09b-f7db-4ff2-ba0d-a3748636d726';

update gapratesrevision set paymentamt = '875.70', approvaldate = now() , updatedby = 'CDM-39542', updatedon = now() 
where gaprateid = '34f3e09b-f7db-4ff2-ba0d-a3748636d726' -- and activeflag = 1
;

--  Provider id: 5087195
update gapagreementrate set paymentamout = '875.70', updatedby = 'CDM-39542', updatedon = now() 
where gapagreementrateid = 'faeec7a4-9966-4e01-9a83-61f7987566cd';

update gapratesrevision set paymentamt = '875.70', approvaldate = now() , updatedby = 'CDM-39542', updatedon = now() 
where gaprateid = 'faeec7a4-9966-4e01-9a83-61f7987566cd' -- and activeflag = 1
;


