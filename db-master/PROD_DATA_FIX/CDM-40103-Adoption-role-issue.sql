/*
   Issue Description: CDM-40103 Adoption case number :241040257622 CJAMS Subsidy Error .There is no add suspension button when the case is assigned to the worker.
   Category/ Module  : Suspension
   Root cause: Add Suspension button is missing in the Adoption subsidy suspension Agreement page as user is provided with adoptioncase_read_only_access in user resource table.
   Fix provided : Data fix has been provided remove the read_only_access role for the user alice.barkley1@maryland.gov in the case number :241040257622
   Pull request# for code fix: N/A
   Reason why no related code fix: N/A 
   Status of the code fix if already submitted and expected prod fix date: N/A
   Backup before update/ delete: N/A
*/


update userresource set activeflag=0, updatedby='CDM-40103', updatedon = now() where userid=14860 and permissiongroupid in('ede14ff0-033a-4b3f-870b-e3c23b602821', 'e66a00fe-0d20-448b-96eb-d7157ff08c39', '386c99fb-58ac-4d53-883c-50e65a3b285f') and activeflag=1;

