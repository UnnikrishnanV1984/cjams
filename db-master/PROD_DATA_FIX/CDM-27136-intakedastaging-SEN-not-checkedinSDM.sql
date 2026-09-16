-- CDM-27136 -Ican't submit this case for approval or select SEN
/*
   File Name: CDM-27136-intakedastaging-SEN-not-checkedinSDM
-- Issue Description: 
    For the intakeNumber  I221010343670 the SEN checkbox is selected under the child profile but the SEN checkbox under SDM is not selected 
    Customer Email ID:jenel.keller@maryland.gov
  
-- Resolution: Updated the jsondata in the intakedastaging table for the intakenumber I221010343670

-- Category/ Module: Case Management
-- Root cause: User Error
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A

*/


UPDATE intakedastaging
SET jsondata = jsonb_set(jsondata, '{sdm}', jsonb_set(jsondata->'sdm', '{isnegrh_exposednewborn}', 'true'))
    , updatedby = 'CDM-27136'
    , updatedon = now()
WHERE intakenumber = 'I221010343670' AND activeflag = 1;

UPDATE intakedastaging 
SET jsondata = replace(jsondata::text, '"isnegrh_exposednewborn": false', '"isnegrh_exposednewborn": true')::json
    , updatedby = 'CDM-27136'
    , updatedon = now()
WHERE intakenumber = 'I221010343670' AND activeflag = 1;