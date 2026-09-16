/*
Issue Description: Getting Something Wrong red alert when creating a new placement.
Category/Module: Bug
Root cause: Seems row_lock in prov.tb_provider table for this provider had an existing value
Fix provided: DB query to nullify row_lock to allow the client to be added
Data/Code fix ticket#: CDM-42326
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: Data glitch
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/

--Updating prov.tb_provider
update prov.tb_provider 
set row_lock = null, update_user_id = 'CDM-42326', update_ts = now()
where provider_id = 6006029;

--Updating supervisor to active
update userprofile
set supervisorid = '9b057c26-9c53-4aeb-b375-d6feb535a53f', updatedby = 'CDM-42326', updatedon = now()
where securityusersid = 'f39d361a-1281-4495-b395-22db6fa1b43e' and activeflag = 1;