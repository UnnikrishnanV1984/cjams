-- CJAMS-63302 Program Area

/*
-- Issue Description: 
Data fix to delete the Auxiliary Service/Voluntary Placement Services program assignment request (10/23 to 11/4/25; Case: 3195132) for JESSICA MARIE HARPER.
Case Number: 3195132
Client name: JESSICA MARIE HARPER
Client ID: 1384655
-- Resolution: Data fix to delete the Auxiliary Service/Voluntary Placement Services program assignment request 

-- Category/ Module: Case Management
-- Root cause: User Error
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

update
	cjams.personprogramarea
set
    activeflag = 0,
	updatedby = 'CJAMS-63302',
    updatedon = now()
where
	personprogramid = '5843745c-8e1a-4b5a-a82f-61d6c4f68055'
	and personid = 'e3207a91-3ba0-411c-a868-9c6c4291602f'