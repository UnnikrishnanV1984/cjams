-- CDM-41669 - Need to remove 1 person that are in Others Tab from 241022918876 case
/*
-- Issue Description: 
	241022918876:child Kenji PID 4320729 was erroneously added as part of this case. He is in OOH care, not in the mother's care and should not be a part of this AR case. 
    He was moved to Others Tab and need to be deleted from this case and program assignment.
-- Case ID: 241022918876 - 86c98d65-5d16-4ab2-8813-5707944ae32f,
-- Clients 
-- 4320729 (KENJI XAVIER Barkley) - personid:7ecbcbfa-2f85-4fc6-b26c-f4f201bbb095

   
-- Category/ Module: Persons
-- Root cause: one person on this screen shot is added incorrectly to the case 241022918876. So need to remove person from the others persons tab.
-- Resolution: Removed a person from the persons other tab by setting active flag to 0.
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

/*
select * from cjams.person where cjamspid='4320729'; --personid:7ecbcbfa-2f85-4fc6-b26c-f4f201bbb095
--objectid: 86c98d65-5d16-4ab2-8813-5707944ae32f
*/
/*

select  * 
	from personprogramarea
where personid = '7ecbcbfa-2f85-4fc6-b26c-f4f201bbb095'
	and objectid = '86c98d65-5d16-4ab2-8813-5707944ae32f' 
	and activeflag = 1 ;

*/

update personprogramarea
set activeflag = 0,
	updatedby = 'CDM-41669',
	updatedon = now()
where personid = '7ecbcbfa-2f85-4fc6-b26c-f4f201bbb095'
	and objectid = '86c98d65-5d16-4ab2-8813-5707944ae32f' 
	and activeflag = 1 ;

-- Delete Person Role(s)
/*
select servicecaseid, *
	from personrole
where personid = '7ecbcbfa-2f85-4fc6-b26c-f4f201bbb095'
	and intakeserviceid  = '86c98d65-5d16-4ab2-8813-5707944ae32f'
	and activeflag = 1 ;
*/

update personrole
set activeflag = 0,
	updatedby = 'CDM-41669',
	updatedon = now()
where personid = '7ecbcbfa-2f85-4fc6-b26c-f4f201bbb095'
	and intakeserviceid  = '86c98d65-5d16-4ab2-8813-5707944ae32f'
	and activeflag = 1 ;

-- Delete Person Relationship(s)
/*
select *
	from actorrelationship
where intakeservicerequestactorid
	in ( select intakeservicerequestactorid
			from intakeservicerequestactor
		where personid = '7ecbcbfa-2f85-4fc6-b26c-f4f201bbb095'
			and intakeserviceid  = '86c98d65-5d16-4ab2-8813-5707944ae32f'
		)
	and activeflag = 1 ;
*/

update actorrelationship	
set activeflag = 0,
	updatedby = 'CDM-41669',
	updatedon = now()
where intakeservicerequestactorid
	in ( select intakeservicerequestactorid
			from intakeservicerequestactor
		where personid = '7ecbcbfa-2f85-4fc6-b26c-f4f201bbb095'
			and intakeserviceid = '86c98d65-5d16-4ab2-8813-5707944ae32f'
		)
	and activeflag = 1 ;
	
-- Delete Intakeservicerequestactor
/*
select *
	from intakeservicerequestactor
where personid = '7ecbcbfa-2f85-4fc6-b26c-f4f201bbb095'
	and intakeserviceid = '86c98d65-5d16-4ab2-8813-5707944ae32f'
	and activeflag = 1 ;
*/

update intakeservicerequestactor
set activeflag = 0,
	updatedby = 'CDM-41669',
	updatedon = now()
where personid = '7ecbcbfa-2f85-4fc6-b26c-f4f201bbb095'
	and intakeserviceid = '86c98d65-5d16-4ab2-8813-5707944ae32f'
	and activeflag = 1 ;

-- Delete Actor
/*
select *
	from actor
where personid = '7ecbcbfa-2f85-4fc6-b26c-f4f201bbb095'
and intakeserviceid  = '86c98d65-5d16-4ab2-8813-5707944ae32f'
	and activeflag = 1 ;
*/
	
update actor
set activeflag = 0,
	updatedby = 'CDM-41669',
	updatedon = now()
where personid = '7ecbcbfa-2f85-4fc6-b26c-f4f201bbb095'
and intakeserviceid  = '86c98d65-5d16-4ab2-8813-5707944ae32f'
	and activeflag = 1 ;

-- Update personroletype
/*
select * from personroletype where personroleid in (select
			personroleid
		from
			personrole
		where
			personid = '7ecbcbfa-2f85-4fc6-b26c-f4f201bbb095'
			and intakeserviceid = '86c98d65-5d16-4ab2-8813-5707944ae32f');
*/
		
		
update personroletype 
		set  activeflag = 0,
			 updatedby = 'CDM-41669',
			 updatedon = now()
		where personroleid in (select
			personroleid
		from
			personrole
		where
			personid = '7ecbcbfa-2f85-4fc6-b26c-f4f201bbb095'
			and intakeserviceid = '86c98d65-5d16-4ab2-8813-5707944ae32f');

