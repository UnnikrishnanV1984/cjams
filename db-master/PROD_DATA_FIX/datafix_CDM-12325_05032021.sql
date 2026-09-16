-- CDM-12325 - Adoption Subsidy increase
/*
-- Issue Description: 
	CJAMS is not allowing the user to add new Adoption Subsidy Rate
	Adoption case of Brianna Godfrey was initiated with a 0 subsidy + medical assistance. 
    On March 31, 2021 SSA approved Brianna for an increase from 0 to $835. 
    
   	Adoption Case ID: 3253324
	Client ID: 3792279 (BRIANNA C GODFREY) - 42e8c899-1d1b-46a1-abaf-0c214456ba9b
	Adoption ID: 43412 - 2015-04-06 to 2027-06-08 - c0671f51-7d6d-4cc2-b664-cb0575e07d9f
  
-- Category/ Module: Adoption Subsidy (Finance Management) 
-- Root cause: Data issue (MD CHESSIE migrated data)
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- User response: the new rate is $835 beginning 3/31/2021 with an ending date of 6/8/2027. 
-- The end date of the old rate of $0 is 3/30/2021.

-- Update the Adoption Rate slab dates & status 
select paymentamout, startdate, enddate, transactiondate, status, updatedby, updatedon 
	from adoptioncaseagreementrate 
where adoptionagreementid = '8c90e27c-d29d-4fef-9254-0a2e6baaf215'
	and activeflag  = 1 ;

update adoptioncaseagreementrate 
set startdate = '2015-04-06 00:00:00',
     enddate = '2021-03-30 00:00:00', 
     transactiondate = '2015-04-14 00:00:00',
     status = 'Approved',
     updatedby = 'CDM-12325',
     updatedon = now()
where adoptionagreementid = '8c90e27c-d29d-4fef-9254-0a2e6baaf215'
	and activeflag  = 1 ;