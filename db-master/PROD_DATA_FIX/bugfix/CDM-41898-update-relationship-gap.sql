/* 
    Issue Description: CDM-41898 Relationship Status
   Category/ Module  : Missing Relationship
   Root cause: Please update the relationship for the case 200659769 and Client ID: 200659769
   Fix provided : Data fix has been done to add relationship as relative in IV-E side and case side.
   Pull request# for code fix: N/A
   Reason why no related code fix: N/A
   Status of the code fix if already submitted and expected prod fix date: N/A
   Backup before update/ delete: N/A
*/

update guardianship set primaryrelationshipkey = 'Relative', updatedby ='CDM-41898', updatedon = now () 
where gapid = '4da6e41a-0284-4ffd-bccd-824bf9a4d52e';

update gapeligibilityinfo set primaryguardianisrelative = 'YES', primaryguardianrelationship = 'Relative',
primaryguardianrelationshipid = '1001', updatedby ='CDM-41898', updatedon = now ()
where client_id = '200659769' and activeflag =1;
