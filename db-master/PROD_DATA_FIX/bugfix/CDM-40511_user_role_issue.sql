    /*
   Issue Description: CDM-40511 Monee Davis not in drop down to assign
   Category/ Module  :Assignments
   Root cause: The worker Monee Davis was transferred to Family Preservation #19 but he is not available in the case worker screen due to incorrect role assigned as CWCMSP instead of CWCW
   Fix provided : Data fix has been promoted to update the role for the user to CWCW 
   Pull request# for code fix: N/A
   Reason why no related code fix: N/A
   Status of the code fix if already submitted and expected prod fix date: N/A
   Backup before update/ delete: N/A
*/

update teammember
set roletypekey = 'CWCW',
    updatedby = 'CDM-40511',
    updatedon = now()
where  teammemberid = '64bbdc8f-cc61-415e-82c8-8d8705d5404c'
and teamid = '15a4d667-3645-42fc-8264-7a8dadbf206f'
and activeflag =1;