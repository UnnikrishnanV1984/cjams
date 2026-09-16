/*
   Issue Description: CDM-44191 - Delete Person Card
   251022986060:The screening unit added the wrong person to the case. Please delete cjams # 1298969.
   Root cause: User Error. Wrong person addedd to case.
   Case#: 251022986060 (intakeserviceid:'85a03483-926b-4fb4-aa03-f7656fb35a52')
   Person to be deleted from case: 1298969 (d293b68f-8942-483f-98b8-ec823c811354)
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
   Need to do data fix: Data fix to remove the approval request record.
*/
/*
select * from person where cjamspid = '1298969';--wrongP: d293b68f-8942-483f-98b8-ec823c811354
select * from person where cjamspid = '1310109';--rightP: d70882ed-ce75-43b1-ba96-79854638e642
-- update wrong person with right person
select servicecaseid,personid,intakenumber,intakeserviceid,activeflag,updatedby,* from intakeservicerequestactor 
where personid = 'd293b68f-8942-483f-98b8-ec823c811354' 
and intakenumber = 'I251013212040'
and activeflag = 1;
*/

update intakeservicerequestactor 
set updatedby = 'CDM-44191',
	updatedon = now(),
	personid = 'd70882ed-ce75-43b1-ba96-79854638e642'-- right
where personid = 'd293b68f-8942-483f-98b8-ec823c811354' --wrong
and intakenumber = 'I251013212040'
and activeflag = 1;

/*select servicecaseid,personid,intakenumber,intakeserviceid,activeflag,updatedby,* from actor 
where personid = 'd293b68f-8942-483f-98b8-ec823c811354' 
and intakenumber = 'I251013212040'
and activeflag = 1;*/

update actor 
set updatedby = 'CDM-44191',
	updatedon = now(),
	personid = 'd70882ed-ce75-43b1-ba96-79854638e642'-- right
where personid = 'd293b68f-8942-483f-98b8-ec823c811354' --wrong
and intakenumber = 'I251013212040'
and activeflag = 1;


---remove from CPS-IR case
/*
select * from person where cjamspid = '1298969';--d293b68f-8942-483f-98b8-ec823c811354
*/

/*
select servicecaseid,intakeserviceid,activeflag,* from intakeservicerequestactor 
where intakeserviceid = '85a03483-926b-4fb4-aa03-f7656fb35a52'
and activeflag = 1 
and personid = 'd293b68f-8942-483f-98b8-ec823c811354';
*/

update cjams.intakeservicerequestactor  
	set activeflag = 0,
		updatedon = now(),
		updatedby = 'CDM-44191'
where intakeserviceid = '85a03483-926b-4fb4-aa03-f7656fb35a52'
and activeflag = 1 
and personid = 'd293b68f-8942-483f-98b8-ec823c811354';


/*
select servicecaseid,intakeserviceid,activeflag,* from actor 
where intakeserviceid = '85a03483-926b-4fb4-aa03-f7656fb35a52'
and activeflag = 1 
and personid = 'd293b68f-8942-483f-98b8-ec823c811354';
*/


update cjams.actor 
	set activeflag = 0,
		updatedon = now(),
		updatedby = 'CDM-44191'
where intakeserviceid = '85a03483-926b-4fb4-aa03-f7656fb35a52'
and activeflag = 1 
and personid = 'd293b68f-8942-483f-98b8-ec823c811354';

	
/*
select * from personrole 
where personid = 'd293b68f-8942-483f-98b8-ec823c811354' 
	and intakeserviceid  = '85a03483-926b-4fb4-aa03-f7656fb35a52'
	and activeflag = 1;
*/

update cjams.personrole 
	set activeflag = 0,
		updatedon = now(),
		updatedby = 'CDM-44191'
	where personroleid  = '178791d9-6e42-4faa-84da-25e6967f387a'
		and activeflag = 1;

update cjams.personroletype 
	set activeflag = 0,
		updatedon = now(),
		updatedby = 'CDM-44191'
	where personroleid  = '178791d9-6e42-4faa-84da-25e6967f387a'
		and activeflag = 1;
	
update cjams.actorrelationship 
	set activeflag = 0,
		updatedon = now(),
		updatedby = 'CDM-44191'
	where intakeservicerequestactorid ='4a350320-ff2d-4047-b4b9-aafe07cc6710'
		and activeflag = 1;
		
/*
select objectid, programkey, *
	from cjams.personprogramarea
	where personid = 'd293b68f-8942-483f-98b8-ec823c811354'
		and objectid = '85a03483-926b-4fb4-aa03-f7656fb35a52'
		and activeflag = 1;
*/
		
update cjams.personprogramarea 
	set activeflag = 0,
		updatedon = now(),
		updatedby = 'CDM-44191'
	where personid = 'd293b68f-8942-483f-98b8-ec823c811354'
		and objectid = '85a03483-926b-4fb4-aa03-f7656fb35a52'
		and activeflag = 1;