-- CDM-38313-Service Plan
/*
   File Name: CDM-38313-serviceplan-values not showing in pdf
-- Issue Description: 
    For the case 231030153663  - Prevention Services Eligibility is selected as Yes but it's not reflected in the service plan printout
    Customer Email ID:william.offer@maryland.gov
  
-- Resolution: Updated the snapshothist, updatedby Columns

-- Category/ Module: Case Management
-- Root cause: User requested for updating the data to show up in the pdf, API code issue which is being fixed with candidacy determination story.
-- Resolution: Updated the snapshotist table with the needed shapshotdata to populate in pdf
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A

*/


update
	snapshothist sn
set
	updatedby = 'CDM-38313',
	updatedon = now(),
	snapshotdata = jsonb_set(sn.snapshotdata::jsonb, '{serviceplancandidacy}', '{"candidates": [
      {
        "id": "200300842",
        "name": "Kashmere L Simmons",
        "candidacy": "1",
        "candidacydate": "2024-04-22T16:23:51.266Z"
      }
]}')
where
	sn.id = '383420ef-29bb-4253-802d-b4deb842eaf4' ;