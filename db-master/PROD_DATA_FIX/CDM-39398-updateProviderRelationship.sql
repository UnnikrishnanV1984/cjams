/*
   Issue Description: CDM-39398 3968178 Please update - Paternal Grandmother
                      Make sure in IV-E side it shoudl reflect and is relative should be YES and GAP decision
   Category/ Module  : Title IV-E (GAP Relationship)
   Root cause: yonna Norris Id:3968178 The relationship on the GAP worksheet in CJAMS is not showing and not allowing to enter information in the drop down box.
   Fix Provided : Data fix has been promoted to update Paternal Grandmother the role for the user yonna Norris Id:3968178 
   Pull request# for code fix:  N/A
   Reason why no related code fix: N/A
   Status of the code fix if already submitted and expected prod fix date: N/A
   Backup before update/ delete: N/A
*/



update guardianship set primaryrelationshipkey = 'PRNTLGPRNT', updatedby = 'CDM-39398', updatedon =  now()
where gapid = '6c1f2203-3985-4cd6-b528-83821b40d30c';


update gapeligibilityinfo set primaryguardianrelationship = 'Paternal Grandparent',primaryguardianrelationshipid = '1001', primaryguardianisrelative = 'YES', updatedby = 'CDM-39398', updatedon =  now()
where client_id = '3968178' and activeflag = 1;