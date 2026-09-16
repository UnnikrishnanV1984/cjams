/*
-- CDM-23296- 

-- Issue Description: 
 Delete the  love.pdf document under Documents tab

--  love.pdf	20220531SupervisionChecklist-Love	05/31/2022	CW-Document	CW-Document	Kelly Beswick	05/31/2022 03:52 PM

-- documentpropertiesid: "b154bf49-81ea-48bb-8ae3-0e4ef03d27f7"
-- documentdate: "2022-05-31T19:52:31.693"
-- documentpropertiesid: "b154bf49-81ea-48bb-8ae3-0e4ef03d27f7"
-- ecmsdocumentid: "629671ff3898816fa7f5c248"
-- filename: "629671ff3898816fa7f5c248"
-- originalfilename: "love.pdf"
-- Customer Email ID: kelly.beswick@maryland.gov
-- Root cause: Data fix to delete the document under the Documents tab
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

update
    documentproperties
set
    activeflag = 0,
    updatedby = 'CDM-23296',
    updatedon = now()
where
    documentpropertiesid = 'b154bf49-81ea-48bb-8ae3-0e4ef03d27f7';
