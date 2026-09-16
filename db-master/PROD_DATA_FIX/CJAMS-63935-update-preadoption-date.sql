/*
Issue: Adoption date input matter CJAMS-63935
Category/Module: Person profile
Root cause: User is unable to complete intake for Angela Alvey. The system is blocking it due to adoption date.
            Data fix is requested by the user to add doption finalization date for the following clients. 
            1) I251013569587 - Client Name (Laren Dlouhy )- The adoption Finalization Date should be "02/11/1999"
            2) I251013521685 - Client Name (Angela Alvey) - The adoption Finalization Date should be "3/9/1992"
Fix provided:  Data fix has been done to add doption finalization date for the following clients. 
            1) I251013569587 - Client Name (Laren Dlouhy )- The adoption Finalization Date should be "02/11/1999"
            2) I251013521685 - Client Name (Angela Alvey) - The adoption Finalization Date should be "3/9/1992"
Data/Code fix ticket#: CJAMS-63935
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: There is no option for user to edit adoption date through application and data fix should resolve it.
*/

update person 
set preadoptiondate = '1999-02-11 00:00:00.000',
    adoptedflag = 1,
    everbeenadoptedflag = 1,
	updatedby = 'CJAMS-60832',
	updatedon = now()
where cjamspid = '1186055' 
and   personid = '38ba56e7-35f0-49c4-9d89-407915060223'
and activeflag =1;


update person 
set preadoptiondate = '1992-03-09 00:00:00.000',
	updatedby = 'CJAMS-60832',
	updatedon = now()
where cjamspid = '1181969' 
and   personid = 'a88a340a-fd21-4191-bc16-da87df66ba08'
and activeflag =1;




