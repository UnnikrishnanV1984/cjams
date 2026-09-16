/*
Issue Description: Please remove/delete the living arrangement record as highlighted.
Category/ Module : Error
Root cause: Duplicate entry in placement needed to be deactivated.
Fix provided: Yes, write Db query 
Code fix ticket#: CDM-40142
Reason why no related code fix: Status of the code fix  already submitted 
Status of the code fix if already submitted and expected prod fix date: 
void the rejected provider placement from backend
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/

--Updating placement
update placement 
set 
	activeflag = 0,
	updatedby = 'CDM-40142',
	updatedon = now()
where placementid = '9043d145-03cf-4568-a4bc-f6d58e11ce61' and activeflag = 1;

--Updating placementrevision
update placementrevision
set 
	activeflag = 0,
	updatedby = 'CDM-40142',
	updatedon = now()
where placementid = '9043d145-03cf-4568-a4bc-f6d58e11ce61' and activeflag = 1;

--Updating livingarrangement
update livingarrangement
set 
	activeflag = 0,
	updatedby = 'CDM-40142',
	updatedon = now()
where placementid = '9043d145-03cf-4568-a4bc-f6d58e11ce61' and activeflag = 1;

--Updating routing
update routing 
set 
	activeflag = 0,
	updatedby = 'CDM-40142',
	updatedon = now()
where objectid = '9043d145-03cf-4568-a4bc-f6d58e11ce61' and activeflag = 1;