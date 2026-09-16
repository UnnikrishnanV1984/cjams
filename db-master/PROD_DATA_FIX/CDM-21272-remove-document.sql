/*
-- CDM-21272 - 

-- Issue Description: 
 Delete the test document under Documents tab
  
-- Customer Email ID: anthony.carter@montgomerycountymd.gov

-- Root cause: Data fix to delete the document under the Documents tab
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

update documentproperties set activeflag = 0, updatedby = 'CDM-21272', updatedon = now() where documentpropertiesid = '9a022758-0f33-405d-aa45-0ab992345cee';

update documentattachment set activeflag = 0, updatedby = 'CDM-21272', updatedon = now() where documentpropertiesid = '9a022758-0f33-405d-aa45-0ab992345cee';