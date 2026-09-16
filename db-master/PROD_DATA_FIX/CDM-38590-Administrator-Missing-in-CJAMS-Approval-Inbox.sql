/*
Issue Description: Alesha Poore is no longer in the Approval Inbox Drop Down in CJAMS. Alesha has recently moved from a supervisor in Cecil County to our In-Home Administrator. All other Cecil County supervisors/administrators are listed in the drop down.
{{ Category/ Module : Teammember tables}}
Root cause: Data fix to upadted the roletypekey.
Fix provided :yes,write db query
Code fix ticket#: CDM-38590
Reason why no related code fix: Status of the code fix already submitted
Status of the code fix if already submitted and expected prod fix date: N/A
Backup before update/ delete:
*/

update teammember
set roletypekey = 'CWSP',
updatedby = 'CDM-38590',
updatedon = now()
where teammemberid = '1de324dd-cd10-4335-91e3-0a7edbfa6efc' and activeflag = 1;