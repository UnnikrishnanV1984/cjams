/*
Issue: CJAMS-63223 Unable to add person
Category/Module: Person profile
Root cause: I251013393802:The client, Breasja Yates - 3159613 (DOB 02/22/2003) could not be added in the referral due to her adoption date (12/01/2010)
Also requested to remove Unknown person - CJAMS PID#:204255179 , from Intake I251013393802 and case 251030587762
Fix provided:  Data fix needed to add the adoption previous date with 12/01/2010 for client ID# 3159613 (Breasja Yates)
Data/Code fix ticket#: CJAMS-63223
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: This is a data entry error and data fix should resolve it.
*/

-- 3159613 	a41ed1d9-becd-4a89-b97b-c00186fb3c69

update person
set preadoptiondate = '2010-12-01',
    updatedon = now(),
    updatedby = 'CJAMS-63223'
where personid = 'a41ed1d9-becd-4a89-b97b-c00186fb3c69'
and activeflag =1; 


-- 204255179  ce679d39-cf58-465f-862c-e9720232819e -- To be remove from Intake I251013393802 and case 251030587762

update cjams.actor 
	set activeflag = 0, 
		updatedon = now(), 
		updatedby = 'CJAMS-63223'
	where actorid IN('368098b7-0973-4d1a-aa93-26f752e474eb','fdcd9cf1-b7cd-48c8-8ce1-2be80dce46fd')
		and activeflag = 1;

update cjams.intakeservicerequestactor 
	set activeflag =0,
		updatedon = now(),
		updatedby = 'CJAMS-63223'
	where intakeservicerequestactorid in ('a5fa2940-ffba-451b-9def-bf82052dcc7d', '44cab27c-eed1-4921-9672-0e3fd65c5159')
		and activeflag = 1;

update cjams.actorrelationship 
	set activeflag = 0,
		updatedon = now(),
		updatedby = 'CJAMS-63223'
	where intakeservicerequestactorid in ('a5fa2940-ffba-451b-9def-bf82052dcc7d', '44cab27c-eed1-4921-9672-0e3fd65c5159')
		and activeflag = 1;


update cjams.personrole 
	set activeflag = 0,
		updatedon = now(),
		updatedby = 'CJAMS-63223'
	where personroleid  in ('a640b4e6-0bf1-4946-9c89-32ef62d92cc9') 
		and activeflag = 1;


update cjams.personroletype 
	set activeflag =0,
		updatedon = now(),
		updatedby ='CJAMS-63223'
	where personroletypeid  in ('1d56838d-b6b5-467c-ab8d-e5c4acd36b77') 
		and activeflag = 1;
		

update cjams.personprogramarea 
	set activeflag = 0,
		updatedon = now(),
		updatedby = 'CJAMS-63223'
	where personid = 'ce679d39-cf58-465f-862c-e9720232819e' 
		and objectid = 'd1407c4b-0d92-4a89-ad3a-95afd3ad793b'
		and activeflag = 1;