/*
   Issue Description: CDM-38971 3174207:Suspension end date(5-2-24) keeps disappearing while attempting to approve. This is causing a delay with payment and result in placement disruption. Please assist with resolving this matter. 
   Category/ Module  : Approval
   Root cause: Suspension of payments end date for agreement document keeps disappearing due to incorrect role assigned to the case worker who sends for approval.
   Fix Provided : Data fix has been promoted to update the role of the user from LDSS to CWSP in teammember table
   Pull request# for code fix:  N/A
   Reason why no related code fix: N/A
   Status of the code fix if already submitted and expected prod fix date: N/A
   Backup before update/ delete: N/A
*/

--updated roletypekey from LDSS to CWSP
update teammember set roletypekey = 'CWSP', updatedby = 'CDM-38971', updatedon = now() where teammemberid= 'e67a3f71-52ac-4626-97d1-478bf0af9274' and activeflag =1;