/*
   Issue Description: CJAMS-59865
   Category/ Module  :  person tab
   Root cause: The preadoption date was missing in person table
   code fix: N/A
   Reason why no related code fix: user error
*/
--select everbeenadoptedflag ,preadoptiondate ,adoptedflag ,safehavenbabyflag ,* from person where cjamspid = '1642873';
update person 
set preadoptiondate = '2001-11-07',
	updatedby = 'CJAMS-59865',
	updatedon = now()
where cjamspid = '1642873' and activeflag =1;