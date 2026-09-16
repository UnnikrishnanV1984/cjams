
/*
   Issue Description: CDM-27738
   Category/ Module  : delete person
   Root cause: user wants to delete duplicate client
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
     Need to do data fix
*/

-- Delete Actor
select actorid, actortype, activeflag, updatedby, updatedon
	from actor
where personid = '16bfbf8b-cc67-43ce-873c-b5d080fcd281'
and servicecaseid = 'e31f7fbf-3905-465d-8925-233d188bcd13'
	and activeflag = 1 ;
	
update actor
set activeflag = 0,
	updatedby = 'CDM-27738',
	updatedon = now()
where personid = '16bfbf8b-cc67-43ce-873c-b5d080fcd281'
and servicecaseid = 'e31f7fbf-3905-465d-8925-233d188bcd13'
	and activeflag = 1 ;

-- Delete Person Role(s)
select personroleid, activeflag, updatedby, updatedon 
	from personrole
where personid = '16bfbf8b-cc67-43ce-873c-b5d080fcd281'
 and servicecaseid = 'e31f7fbf-3905-465d-8925-233d188bcd13'
	and activeflag = 1 ;

update personrole
set activeflag = 0,
	updatedby = 'CDM-27738',
	updatedon = now()
where personid = '16bfbf8b-cc67-43ce-873c-b5d080fcd281'
 and servicecaseid = 'e31f7fbf-3905-465d-8925-233d188bcd13'
	and activeflag = 1 ;


	
-- Delete Intakeservicerequestactor
select servicecaseid, intakeservicerequestpersontypekey, activeflag, updatedby, updatedon
	from intakeservicerequestactor
where personid = '16bfbf8b-cc67-43ce-873c-b5d080fcd281'
and servicecaseid = 'e31f7fbf-3905-465d-8925-233d188bcd13'
	and activeflag = 1 ;

update intakeservicerequestactor
set activeflag = 0,
	updatedby = 'CDM-27738',
	updatedon = now()
where personid = '16bfbf8b-cc67-43ce-873c-b5d080fcd281'
and servicecaseid = 'e31f7fbf-3905-465d-8925-233d188bcd13'
	and activeflag = 1 ;