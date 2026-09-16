/*
Issue: CJAMS-65062
Category/Module: Form 1080 A
Root cause: User requested to delete Form 1080A which are completed in error fro case 261023566743.
Fix provided:  Data fix to delete the records from DB.
Regression Impacts: N/A
Is Code fix Required?: Yes
Code fix ticket#: NA
Reason why no related code fix: User Error
*/


UPDATE cjams.form1080a 
	set activeflag = 0,
		updatedon = now(),
		updatedby = 'CJAMS-65062'
	where form1080aid IN ('bc19fb2d-5e4f-4c30-b3bb-4ac598b338dd','1bb0c9d8-09f3-446a-95b7-fb921990f5fe')
		and activeflag = 1;

UPDATE cjams.parentmaltreator1080forma 
	set activeflag = 0,
		updatedon = now(),
		updatedby = 'CJAMS-65062'
	where form1080aid IN ('bc19fb2d-5e4f-4c30-b3bb-4ac598b338dd','1bb0c9d8-09f3-446a-95b7-fb921990f5fe')
		and activeflag = 1;
		
UPDATE cjams.listmaltreatorsclearancehistory1080forma 
	set activeflag = 0,
		updatedon = now(),
		updatedby = 'CJAMS-65062'
	where form1080aid IN ('bc19fb2d-5e4f-4c30-b3bb-4ac598b338dd','1bb0c9d8-09f3-446a-95b7-fb921990f5fe')
		and activeflag = 1;
		
UPDATE cjams.listotherchildren1080forma 
	set activeflag = 0,
		updatedon = now(),
		updatedby = 'CJAMS-65062'
	where form1080aid IN ('bc19fb2d-5e4f-4c30-b3bb-4ac598b338dd','1bb0c9d8-09f3-446a-95b7-fb921990f5fe')
		and activeflag = 1;
		
UPDATE cjams.listotherchildrenhousehold1080forma 
	set activeflag = 0,
		updatedon = now(),
		updatedby = 'CJAMS-65062'
	where form1080aid IN ('bc19fb2d-5e4f-4c30-b3bb-4ac598b338dd','1bb0c9d8-09f3-446a-95b7-fb921990f5fe')
		and activeflag = 1;