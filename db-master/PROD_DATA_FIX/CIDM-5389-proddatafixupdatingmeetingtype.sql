/*
   Issue Description: CIDM-5389
    Category/ Module  : Prod data fix to remove the to get adoption details
   Root cause: 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/


-- Change in Permanency Plan FIM
UPDATE cjams.familymeetingtype
SET  typedescription='Change in Permanency Plan FTDM', updatedby = 'CIDM-5389', updatedon = now() 
WHERE familymeetingtypeid = '43ee98d4-d78c-4322-a0d4-42ef29032c84';
--Youth Transition FIM
UPDATE cjams.familymeetingtype
SET  typedescription='Youth Transition FTDM', updatedby = 'CIDM-5389', updatedon = now() 
WHERE familymeetingtypeid = 'e4695d70-2838-482e-b537-32fe61c381c8';
-- Voluntary Placement Agreement (VPA) FIM
UPDATE cjams.familymeetingtype
SET  typedescription='Voluntary Placement Agreement (VPA) FTDM', updatedby = 'CIDM-5389', updatedon = now() 
WHERE familymeetingtypeid = '839d7285-8f49-4cca-8a54-78a763ef265c';
-- Case Planning FIM
UPDATE cjams.familymeetingtype
SET  typedescription='Case Planning FTDM', updatedby = 'CIDM-5389', updatedon = now() 
WHERE familymeetingtypeid = '97925a41-643c-445d-9121-03fa647983e6';
-- Removal FIM
UPDATE cjams.familymeetingtype
SET  typedescription='Removal FTDM', updatedby = 'CIDM-5389', updatedon = now() 
WHERE familymeetingtypeid = '59a52e3e-19e9-40d3-bf53-9703db9139b8';
-- Change in Placement FIM
UPDATE cjams.familymeetingtype
SET  typedescription='Change in Placement FTDM', updatedby = 'CIDM-5389', updatedon = now() 
WHERE familymeetingtypeid = 'f1dd5fba-9070-46b6-9d3b-5e4c23a8f622';
