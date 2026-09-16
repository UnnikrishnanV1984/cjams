/*
Issue Description: Worker was trying to end the removal but added a new one by mistake. Please remove duplicate removal which began on 5/16/24.
Category/ Module :removal
Root cause: Data fix for removal the cases
Fix provided: Yes, write DB query.
Code fix ticket#: CDM-39984
Reason why no related code fix: Status of the code fix already submitted 
Status of the code fix if already submitted and expected prod fix date: 
void the rejected provider placement from backend
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/

--Deactivating in intakeservreqchildremoval
update intakeservreqchildremoval
set activeflag = 0, updatedby = 'CDM-39984', updatedon = now()
where intakeservreqchildremovalid = '32ca4879-026e-4eb2-9cda-ec33163c034d' and activeflag = 1;

--Deactivating in intakeservreqchildremoval_history
update intakeservreqchildremoval_history
set activeflag = 0, updatedby = 'CDM-39984', updatedon = now()
where intakeservreqchildremovalid = '32ca4879-026e-4eb2-9cda-ec33163c034d' and activeflag = 1;

--Deactivating in routing
update routing 
set activeflag = 0, updatedby = 'CDM-39984', updatedon = now()
where objectid = '32ca4879-026e-4eb2-9cda-ec33163c034d' and activeflag = 1;

--Deactivating in tb_client_eligibility
update tb_client_eligibility
set delete_sw = 'Y', update_user_id = 'CDM-39984', update_ts = now()
where removal_id = 317738;