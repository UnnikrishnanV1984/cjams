
/*
  Issue Description:CDM-39852 Missing from approval list
                    User (susan.loysen@maryland.gov) is a part of the LDSS Management #2 unit.
                   Login as one of the member unit (sandra.stewart@maryland.gov) and Susan Loysen name is not available as supervisor when created a purchase authorization.
  Category/ Module :Approval
  Root cause: Supervisor susan.loysen@maryland.gov name is not available in the CW purchase authorization form due to incorrect teamid mapping
  Fix Provided: Data fix has been provided to update the supervisor with correct team member id to make it available in the Case workers Purchase Authorization form approval list. 
  Pull request# for code fix: N/A
  Reason why no related code fix: N/A
  Status of the code fix if already submitted and expected prod fix date: N/A
  Backup before update/ delete: N/A
*/

--old teammemberid - e86c4c87-32e9-4040-84e2-6fe99ce3e358

update teammemberassignment 
set teammemberid ='a008eea9-6838-4aea-9e10-a39ccc0f005f', 
    updatedby='CDM-39852', 
    updatedon = now()
where securityusersid ='4103969d-6c19-4065-8d86-fa7706680634'; 