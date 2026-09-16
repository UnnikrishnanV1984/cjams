/*
Issue Description: SSA/PO approved to remove the Persons (PID# 203417025) and (PID#203417091) from this case entirely (CPS-AR : 241022438302).
Category/ Module: Removal
Root cause: Persons (PID# 203417025) and (PID#203417091) were added to case  (CPS-AR : 241022438302) in error and need to be removed.
Fix provided: Yes, write DB query.
Code fix ticket#: CDM-39923
Reason why no related code fix: Status of the code fix already submitted 
Status of the code fix if already submitted and expected prod fix date: 
void the rejected provider placement from backend
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/

update actor
set 
	activeflag = 0,
	updatedby = 'CDM-39923',
	updatedon = now()
where actorid in ('45d5c72c-0eb0-4713-8bc4-7d2214fbaf75', '11b17289-df59-44d4-8c9e-3ae4e63dfe5c') and activeflag = 1;

update intakeservicerequestactor
set 
	activeflag = 0,
	updatedby = 'CDM-39923',
	updatedon = now()
where intakeservicerequestactorid in ('7f5bd8e2-4017-4c69-864a-056e6d417495', '3ce446c0-a315-460f-9420-4843e1c60e31') and activeflag = 1;

update actorrelationship
set 
	activeflag = 0,
	updatedby = 'CDM-39923',
	updatedon = now()
where actorrelationshipid in ('2922780a-512c-44c8-ba27-914f367107e8', '0bb2ad70-5655-44a3-aec7-10316c46b724') and activeflag = 1;

update personrole
set 
	activeflag = 0,
	updatedby = 'CDM-39923',
	updatedon = now()
where personroleid in ('85d8274b-4c41-4665-990b-0e5d32c4f987', '71b0fdfa-24ec-426e-81c6-2ab1bad864a2') and activeflag = 1;

update personroletype
set 
	activeflag = 0,
	updatedby = 'CDM-39923',
	updatedon = now()
where personroletypeid in ('d3aa2207-65ff-4d27-9511-4bbf254bd789', '86644873-02e0-4aa0-bd29-b3aed6979473') and activeflag = 1;

update personprogramarea
set 
	activeflag = 0,
	updatedby = 'CDM-39923',
	updatedon = now()
where personprogramid in ('66a2212f-5144-4488-a020-17da50e8cae6', '9fc462a4-f826-4c59-a349-f2605390ccf6') and activeflag = 1;