/*
 Issue Description:
 unable to add this person to my intake.
  Category/ Module: Person profile
 Root cause: Preadoption date was missing
 Pull request# 	N/A
 Reason why no related code fix: N/A
 Status of the code fix if already submitted and expected prod fix date: N/A
*/

update person 
set preadoptiondate = '01-11-2005',
	updatedby = 'CJAMS-60832',
	updatedon = now()
where cjamspid = '1691812'
	and activeflag =1;