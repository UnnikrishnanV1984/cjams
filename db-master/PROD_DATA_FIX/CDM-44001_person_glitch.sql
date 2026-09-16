/*
   Issue Description: CDM-44001
   Category/ Module  :  person tab
   Root cause: The preadoption date was missing in person table
   code fix: CIDM-10109
   Reason why no related code fix: user error
*/
/*
select adoptedflag,preadoptiondate,updatedby,updatedon,dob,* from person 
where cjamspid = '2428906';
*/
update person
set preadoptiondate = '2008-10-10',
	updatedby = 'CDM-44001',
	updatedon =  now()
where cjamspid = '2428906'
and activeflag = 1;
