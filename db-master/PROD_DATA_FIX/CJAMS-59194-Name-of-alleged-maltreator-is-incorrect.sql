 /*
  Issue Description: CJAMS-59194
   Category/ Module  :  Person tab
   Root cause: date of birth is listed wrong need to update dob as well as name
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
   Backup before update/ delete:
*/
update
    person
set
	firstname = 'Tyshelle',--Tyxchelle
	lastname = 'Dale',--bayes
    dob = '2000-10-05',--1999-09-04 00:00:00.000
    updatedby = 'CJAMS-59194',
    updatedon = now()
where
    cjamspid = 203974600
    and personid = '88a33712-db77-40e7-89ad-5df77ee80b32'
   and activeflag =1;
    
   
--select otherpersonname ,* from progressnote p where progressnoteid ='c6f95c3a-06e3-4413-b630-ff96d89e9a93';

update progressnote 
set otherpersonname = 'Tyshelle Dale, alleged maltreator',--Tychelle Bales, alleged maltreator
	updatedby = 'CJAMS-59194',
	updatedon = now()
where progressnoteid ='c6f95c3a-06e3-4413-b630-ff96d89e9a93'
and activeflag =1;