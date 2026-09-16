/*
Issue Description: 231030077674:There are 2 pending service logs with the same date. Because they have the same date, neither can be sent for approval. One needs to be deleted. 
Category/Module: User Request
Root cause: User Request, to remove the draft purchase authorization 
Fix provided: DB query to remove the draft PA.
Data/Code fix ticket#: 
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: User Request
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/

update tb_service_purchase_authorization pa
set delete_sw = 'Y',
	update_ts = now(),
	update_user_id = 'CJAMS-63370'
where authorization_id = '3926326'
and delete_sw = 'N'
and sprvsr_approval_status_cd is null
and ads_approval_status_cd is null
and funding_approval_status_cd is null
and payment_approval_status_cd is null
and ( select count(*)
from routing
where objectid = pa.authorization_id::character varying
and eventcode in ( 'PCAUTHR', 'PCAUTH' )
) = 0 ;
