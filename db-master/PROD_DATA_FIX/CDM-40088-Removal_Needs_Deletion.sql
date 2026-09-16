/*
Issue Description: Please remove/delete the child removal record of Client ID: 203352737
Category/ Module : Bug
Root cause: Client's removal needs deletion due to error.
Fix provided: Yes, write Db query 
Code fix ticket#: CDM-40088
Reason why no related code fix: Status of the code fix  already submitted 
Status of the code fix if already submitted and expected prod fix date: 
void the rejected provider placement from backend
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/

--Updating intakeservreqchildremoval
update intakeservreqchildremoval
set 
	activeflag = 0,
	updatedby = 'CDM-40088',
	updatedon = now()
where intakeservreqchildremovalid = '87230ec0-ac26-4a64-82da-79ffe8df038d' and activeflag = 1;

--Updating intakeservreqchildremovalreason
update intakeservreqchildremovalreason
set 
	activeflag = 0,
	updatedby = 'CDM-40088',
	updatedon = now()
where intakeservreqchildremovalid = '87230ec0-ac26-4a64-82da-79ffe8df038d' and activeflag = 1;

--Updating intakeservreqchildremoval_history
update intakeservreqchildremoval_history
set 
	activeflag = 0,
	updatedby = 'CDM-40088',
	updatedon = now()
where intakeservreqchildremovalid = '87230ec0-ac26-4a64-82da-79ffe8df038d' and activeflag = 1;

--Updating routing
update routing 
set 
	activeflag = 0,
	updatedby = 'CDM-40088',
	updatedon = now()
where objectid = '87230ec0-ac26-4a64-82da-79ffe8df038d' and activeflag = 1;

--Updating personprogramarea
update personprogramarea
set 
	activeflag = 0,
	updatedby = 'CDM-40088',
	updatedon = now()
where personprogramid = '7c50c214-9e06-4aea-867c-698cdee652de' and activeflag = 1;

--Updating tb_client_eligibility
update tb_client_eligibility 
set 
	delete_sw = 'Y',
	update_user_id = 'CDM-40088',
	update_ts = now()
where removal_id = 317372 and delete_sw = 'N';

--Updating placement
update placement
set 
	intakeservreqchildremovalid = null,
	updatedby = 'CDM-40088',
	updatedon = now()
where intakeservreqchildremovalid = '87230ec0-ac26-4a64-82da-79ffe8df038d' and activeflag = 1;