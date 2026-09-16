/*
 Issue Description: CDM-37549
 Category/ Module : Service Plan
 Case#: 3274374
 Root cause: User requested to update end date to 08/12/2024 for the service plan 'Ashley Harrington Service Plan'.
 Fix: Data fix applied to update end date.
 Pull request# for code fix: 
 Reason why no related code fix: 
 Status of the code fix if already submitted and expected prod fix date: 
 Need to do data fix
 */

select targetenddate, * from serviceplan where serviceplanid = 'b8faaa26-9333-499d-9ebc-2ee191cd8213';

update serviceplan
	set targetenddate = '2024-08-12 04:00:00.000',  
		updatedby = 'CDM-37549',
		updatedon = now()
	where serviceplanid = 'b8faaa26-9333-499d-9ebc-2ee191cd8213';