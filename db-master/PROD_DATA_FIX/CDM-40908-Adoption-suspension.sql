/*
   Issue Description: CDM-40908 3160325:The suspension date was sent for approval, but not seen in the chil's tab as approved.
   Category/ Module  : Approval
   Root cause: Suspension of payments end date for agreement document keeps disappearing due to incorrect role assigned to the case worker who sends for approval.
   Fix Provided : Data fix has been promoted to update the role of the user from LDSS to CWCW in teammember table
   Pull request# for code fix:  N/A
   Reason why no related code fix: N/A
   Status of the code fix if already submitted and expected prod fix date: N/A
   Backup before update/ delete: N/A
*/

--updated roletypekey from LDSS to CWCW
update teammember set roletypekey = 'CWCW', updatedby = 'CDM-40908', updatedon = now() where teammemberid= '6a8ad22d-7196-4549-a189-3ab02a226a0c' and activeflag =1;