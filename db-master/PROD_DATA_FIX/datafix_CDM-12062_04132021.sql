-- CDM-12062 -- Provider T. Holmes
/*
-- Issue Description: 
   Missing 1 night GAP payment for Provider Tomika Holmes
   
   Case ID: 3157131
   Client ID: 1799835 (CHRISTIAN MICHAEL WEDDLE) - cc293e68-faa1-427e-aa51-d87cacb884b1
   GAP ID: 2915 - 2013-06-13 to 2022-04-02 - 49aee934-3a1f-4a61-a9c6-e861d4a692e5
   Provider ID: 5058547	(Tomika Holmes)

-- Category/ Module: Accounts Payable (Finance Management) 
-- Root cause: Suspension Calculation was not excluding the Suspensions with same Start/End dates
-- Pull request# Tanmay will create PR for the code fix.
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: Next Prod build
*/

-- Datafix to trigger Under/Over for generating June 2021 payment (1 night short)
-- GAP Suspension Approval Date was 03/30/2021

select return_code, al_sqlcode, as_error  
	from cjams.sp_under_over_gap('2021-03-30'::date) ;
