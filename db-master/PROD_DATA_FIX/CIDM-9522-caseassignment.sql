/*
  Issue Description: CIDM-9522 - User requested to correct the case assignment for case connect.
  Root cause: Following corrections needs to be done for the case connect intake (I241013139764) and added caseassignment record.
            1. Remove your case assignment (1st row)
            2. Update John assignment start date to 09/17/2024
            3. Update the case start date & time to 09/17/2024 11:17AM
  Fix provided : Data fix has been done to delete the first case assignment row, correct the assignment date to 9/17/2024 and Update the case start date & time to 09/17/2024 11:17AM.
  Pull request# for code fix: N/A
  Reason why no related code fix: N/A 
  Status of the code fix if already submitted and expected prod fix date: N/A
  Backup before update/ delete: N/A
*/

update caseassignment set activeflag =0, updatedby = 'CIDM-9522', updatedon = now() where caseassignmentid = 'e300fd68-d6a7-4c57-ac4e-0dc0c1946092';

update caseassignment set startdate = '2024-09-17 15:06:58.081', effectivedate = '2024-09-17 11:17:00.000', updatedby = 'CIDM-9522', updatedon = now() where caseassignmentid = 'd84927a0-fe95-48f4-9937-15b5f66193f6';

update servicecase set insertedon='2024-09-17 11:17:00.000', updatedby = 'CIDM-9522', updatedon = now() where servicecaseid = '794bb7b2-58a0-466f-9c16-ccb7b66c0df8';

