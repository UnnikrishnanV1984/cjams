/*
Issue Description: Delete Ryan Dickinson CJAMS PID# 3162117 from case# CW2703785.
2. Add new person card with name 'Unknown Unknown' and add copy other details of the person from Alexandra D Rostek CJAMS PID# 2314973.
Category/Module: Bug
Root cause: The user does not have permission to delete or create records in the Person tab.
Fix provided: DB queries  update person,personrole  table.
Data/Code fix ticket#: CJAMS-58889
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: Support
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
delete from person where updatedby = 'CJAMS-58889';
delete from actor where updatedby = 'CJAMS-58889';
delete from intakeservicerequestactor where updatedby = 'CJAMS-58889';
delete from personrole  where updatedby = 'CJAMS-58889';
delete from personprogramarea  where updatedby = 'CJAMS-58889';
delete from personaddress  where updatedby = 'CJAMS-58889';
*/

--Inserting unknown person into person
insert into person
	(personid, activeflag, firstname, lastname, insertedby, insertedon, updatedby, updatedon, effectivedate, dob, gendertypekey, refusessn,
	refusedob, dangertoself, isdraft)
values (gen_random_uuid(), 1, 'Unknown', 'Unknown', 'CJAMS-58889', now(), 'CJAMS-58889', now(), now(), '1900-01-01 00:00:00', 'M', false,
	false, 0, 0);
	

update actor
set personid = (select personid from  person where insertedby  = 'CJAMS-58889'), updatedby  = 'CJAMS-58889', updatedon =now()
where actorid = '377f6105-f0b9-41a8-8692-3d34e4d863f6' and activeflag =1;


update intakeservicerequestactor
set personid = (select personid from  person where insertedby  = 'CJAMS-58889'), updatedby  = 'CJAMS-58889', updatedon =now()
where intakeservicerequestactorid  = '5f606cc0-7b37-450d-9b06-801adfab387b' and activeflag =1;


update personrole
set personid = (select personid from  person where insertedby  = 'CJAMS-58889'), updatedby  = 'CJAMS-58889', updatedon =now()
where personroleid  = 'cab70f71-9d03-4ef7-89b9-a81c939490cc' and activeflag =1;


update personprogramarea
set personid = (select personid from  person where insertedby  = 'CJAMS-58889'), updatedby  = 'CJAMS-58889', updatedon =now()
where personprogramid  = '2a6d6065-ef7c-4a5c-bda9-1a6a135a0e3a' and activeflag =1;