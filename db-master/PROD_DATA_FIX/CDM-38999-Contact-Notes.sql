/*
Issue Description: I am no longer in CPS as an intern. I am now back in a regular In-Home unit & unable to add Contact Notes to a newly assigned case. This happens EVERY time I am shifted to a different unit. I will be assigned to a new unit in a couple of weeks again
Category/ Module : Bug
Root cause: userresource table had the wrong roleids for this user: 135 (Case Management Specialist,CW) and 3150 (Central Policy Staff,CW) instead of 71 (Case Worker,CW).
Fix provided :yes, write Db query 
Code fix ticket#: CDM-38999
Reason why no related code fix: Status of the code fix  already submitted 
Status of the code fix if already submitted and expected prod fix date: 
void the rejected provider placement from backend
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/

--Setting role to Case Worker
update userresource
set 
	roleid = 71,
	updatedby = 'CDM-38999',
	updatedon = now()
where userid = 9659 and activeflag = 1;