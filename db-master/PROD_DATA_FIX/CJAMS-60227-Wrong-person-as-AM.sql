/*
-- Issue Description: 
   SSA approved on 06/18/2025 and please proceed with the data fix to remove the incorrect Alleged Maltreator (Dwayne Griffin / PID# 204085640) from Intake # I251013231694 & CPS AR # 251023003388,
   then add the correct Alleged Maltreator (Dwayne Antoine Griffin Jr. / PID# 1704028) on both cases. 
   And replace PID#204085640 with PID#1704028 on all contacts and assessments.
-- Category/ Module: Case Data (Case Management)
-- Root cause: User Error
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

--Intake level
--wrong one
/*
select * from person where cjamspid = '204085640'--94d333d7-6a77-4225-9470-1a9fcde3c507
actorid:
8553e496-5b7e-4dfe-bddb-edbec000d643
*/

--right one
/*select * from person where cjamspid = '1704028'--2de9c1cc-37ac-480c-a6d3-47e525086d87
actorid:
fb56e47b-62a8-473c-8d3d-472363093c73*/

/*
select * from actor where personid in ('94d333d7-6a77-4225-9470-1a9fcde3c507','2de9c1cc-37ac-480c-a6d3-47e525086d87') 
and activeflag =1 
and intakenumber  = 'I251013231694'
order by updatedon desc;
*/
update actor 
set personid = '2de9c1cc-37ac-480c-a6d3-47e525086d87',--94d333d7-6a77-4225-9470-1a9fcde3c507
	updatedby = 'CJAMS-60227',
	updatedon = now()
where personid = '94d333d7-6a77-4225-9470-1a9fcde3c507'
and intakenumber = 'I251013231694'
and actorid = '8553e496-5b7e-4dfe-bddb-edbec000d643'
and activeflag =1;

/*
select personid ,* from intakeservicerequestactor where intakenumber = 'I251013231694' and activeflag =1 and actorid = '8553e496-5b7e-4dfe-bddb-edbec000d643'
and activeflag =1;
*/

update intakeservicerequestactor
set personid = '2de9c1cc-37ac-480c-a6d3-47e525086d87',--94d333d7-6a77-4225-9470-1a9fcde3c507
	updatedby = 'CJAMS-60227',
	updatedon = now()
where intakenumber = 'I251013231694'
and actorid = '8553e496-5b7e-4dfe-bddb-edbec000d643'
and activeflag =1;

-- case level
/*
select * from actor where personid in ('94d333d7-6a77-4225-9470-1a9fcde3c507','2de9c1cc-37ac-480c-a6d3-47e525086d87') 
and activeflag =1 
and intakeserviceid = 'ec707567-ec80-4033-a4d7-7981438e3f37'
order by updatedon desc;
*/

update actor 
set personid = '2de9c1cc-37ac-480c-a6d3-47e525086d87',--94d333d7-6a77-4225-9470-1a9fcde3c507
	updatedby = 'CJAMS-60227',
	updatedon = now()
where personid = '94d333d7-6a77-4225-9470-1a9fcde3c507'
and intakeserviceid = 'ec707567-ec80-4033-a4d7-7981438e3f37'
and actorid = 'eca84329-17fd-410e-a279-1100d6219460'
and activeflag =1;

/*
select personid ,* from intakeservicerequestactor 
where intakeserviceid = 'ec707567-ec80-4033-a4d7-7981438e3f37'
and actorid = 'eca84329-17fd-410e-a279-1100d6219460'
 and activeflag =1 ;
*/

update intakeservicerequestactor
set personid = '2de9c1cc-37ac-480c-a6d3-47e525086d87',--94d333d7-6a77-4225-9470-1a9fcde3c507
	updatedby = 'CJAMS-60227',
	updatedon = now()
where actorid = 'eca84329-17fd-410e-a279-1100d6219460'
and intakeserviceid = 'ec707567-ec80-4033-a4d7-7981438e3f37'
and activeflag =1;

update actorrelationship
set person1id = '2de9c1cc-37ac-480c-a6d3-47e525086d87',
	updatedby = 'CJAMS-60227',
	updatedon =  now()
where intakeservicerequestactorid in ('9ce692b1-2611-4a09-ae5a-533b98c4c674',
'f5694253-eb1a-4315-9a51-33ba3707e28c')
and activeflag =1
and person1id = '94d333d7-6a77-4225-9470-1a9fcde3c507';

update actorrelationship
set person2id  = '2de9c1cc-37ac-480c-a6d3-47e525086d87',
	updatedby = 'CJAMS-60227',
	updatedon =  now()
where intakeservicerequestactorid in ('9ce692b1-2611-4a09-ae5a-533b98c4c674',
'f5694253-eb1a-4315-9a51-33ba3707e28c')
and activeflag =1
and person2id  = '94d333d7-6a77-4225-9470-1a9fcde3c507';

update personprogramarea
set personid = '2de9c1cc-37ac-480c-a6d3-47e525086d87',
	updatedby = 'CJAMS-60227',
	updatedon = now()
where personprogramid = 'a12b6c45-55a3-4712-bbbb-917b0c0f23a3'
	and personid = '94d333d7-6a77-4225-9470-1a9fcde3c507'
	and activeflag = 1;