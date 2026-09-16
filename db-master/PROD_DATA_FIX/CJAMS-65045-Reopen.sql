/*
Issue Description: 
Category/ Module : Bug
Root cause:Case assignment end date.
Fix provided: Yes, write Db query 
Code fix ticket#: CJAMS-65045
Reason why no related code fix: Status of the code fix  already submitted 
Status of the code fix if already submitted and expected prod fix date: 
void the rejected provider placement from backend
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/




update Investigationallegationmaltreators 
set overrideapprflag = 0,  -- To make the finalization unapproved
	overridefindingtypekey = null,
	finalizeddate = null,
	overridecomments = null,
    updatedon = now(),
    updatedby = 'CJAMS-65045'
	where investigationallegationmaltreatorsid = 'd92e7987-d586-4418-b95c-bb39c9360de2'
	and activeflag =1;





    update Investigationallegationmaltreators 
set overrideapprflag = 0,  -- To make the finalization unapproved
	overridefindingtypekey = null,
	finalizeddate = null,
	overridecomments = null,
    updatedon = now(),
    updatedby = 'CJAMS-65045'
	where investigationallegationmaltreatorsid = '88d91f82-1401-43fe-9c68-d9432fa8f332'
	and activeflag =1;


update caseassignment
set enddate=null , updatedby='CJAMS-65045', updatedon=now()
where caseassignmentid='35d8c7ae-907a-4f02-abee-5480ee8de23e' and activeflag=1;
