/*
Issue Description: Logged in as supervisor Yolanda Byrd and edited and updated the ROLE "Child" but after save the Role is not displayed on the person card. Seems like the role edit is not saving.
Category/Module: Person tab
Root cause: wrong actorid was mapped 
Fix provided: updated with the correct actorid
Data/Code fix ticket#: CDM-44100
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: wrong mapping
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/

/*
select updatedon,updatedby,intakenumber,intakeserviceid,* from actor 
where personid = '6ffff737-4ac6-4c4c-8dc9-f4b08312c243'
and intakeserviceid = '03f9d005-aeb9-4f8c-9346-6f35f1ad5b2b'
and activeflag = 1;--actID: aff6039d-3610-4b66-87dd-f5f7862306cc

select actorid,intakeservicerequestpersontypekey,intakeservicerequestactorid,intakeserviceid,activeflag,* from intakeservicerequestactor 
where personid = '6ffff737-4ac6-4c4c-8dc9-f4b08312c243' 
and intakeserviceid = '03f9d005-aeb9-4f8c-9346-6f35f1ad5b2b'
and activeflag = 1;
*/

update intakeservicerequestactor
set actorid = '949c24a8-6ce9-43a3-9224-97f6fc4fcfd8',
	updatedby = 'CDM-44100',
	updatedon = now()
where personid = '6ffff737-4ac6-4c4c-8dc9-f4b08312c243' 
and intakeserviceid = '03f9d005-aeb9-4f8c-9346-6f35f1ad5b2b'
and activeflag = 1;

update actor
set activeflag = 0,
	updatedby = 'CDM-44100',
	updatedon = now ()
where actorid = 'aff6039d-3610-4b66-87dd-f5f7862306cc'
and activeflag = 1;