/*
Issue: CJAMS-62624 221020255578:In IR 221020255578, the finding should reflect ruled out pertaining to victim Zaylon Brown, alleged maltreator Nyla Malloy. CJAMS incorrectly reflects an indicated finding
Category/Module: Investigation Findings
Root cause: Findings was saved incorrectly for the closed case and data fix needs to done to update from indicated neglect to ruled out.
Fix provided: Data fix has been done to update the Findings from Indicated to Ruled out.
Data/Code fix ticket#: CJAMS-62624
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: We got SSA approval and we are working on updating the Findings through data fix
*/
--update approval to modify the findings from indicated neglect to ruled out neglect


update investigationallegationmaltreators
set oahearingdecision = 'RO', 
	updatedon = now(),
	updatedby = 'CJAMS-62624'
where investigationallegationmaltreatorsid = 'eceab195-73f2-4722-bf41-3db33dd70d4a'
and activeflag =1;