-- CDM-22118 - Please delete child
/*
-- Issue Description: 
	Duplicate Client 200142529 (KANIYAH COOK) is missing from the Service Case 3276768 
	
-- Client ID: 200142529 (KANIYAH COOK) - ce47c13a-904b-4961-8a6e-164c88f95623
-- Case ID 3276768 - b06c1765-cd1b-417d-b61c-f494fd33269d
-- nina.gonzalez@maryland.gov
-- Old -- Case ID: 3266238 - 937cae88-48c9-422d-b780-561a7a57a28c
   
-- Category/ Module: Case Data (Case Management)
-- Root cause: TBD
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- To update the correct Service Case ID in actor table
select intakenumber, intakeserviceid, servicecaseid, activeflag, updatedby, updatedon
	from actor
where personid = 'ce47c13a-904b-4961-8a6e-164c88f95623'
	and actorid = '9a4f7ffb-0654-4e15-82ed-fce9fc98443e'
	and activeflag = 1 ;
	
update actor
set servicecaseid = 'b06c1765-cd1b-417d-b61c-f494fd33269d', -- 3276768
	updatedby = 'CDM-22118',
	updatedon = now()
where personid = 'ce47c13a-904b-4961-8a6e-164c88f95623'
	and actorid = '9a4f7ffb-0654-4e15-82ed-fce9fc98443e'
	and activeflag = 1 ;
