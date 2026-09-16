/*
   Issue Description: CDM-32996
   Category/ Module  : Person missing from the case
   Root cause: Person role was updated from cps case isprimary got changed
   Fix Provided: Code fix has been done as part of CIDM-7358
*/

UPDATE cjams.intakeservicerequestactor
SET updatedby='CDM-32996', updatedon=now(), isprimary=false 
WHERE intakeservicerequestactorid='1de1d2ba-21da-4ba8-9910-e3a83c1bbaad' and personid='b01f4af5-3e3a-4df0-bd37-b0020a9abfed';

UPDATE cjams.intakeservicerequestactor
SET updatedby='CDM-32996', updatedon=now(), isprimary=true 
WHERE intakeservicerequestactorid='38899bae-d3f1-4587-9541-e7a03dce3e91' and personid='b01f4af5-3e3a-4df0-bd37-b0020a9abfed';


-- Delete Duplicate person from the case
--**************************Brittany King, DOB 03/12/1993. 830d268a-0eb1-4a42-af27-7e74f6cca343
-- Relationship
	
update actorrelationship
set activeflag = 0,
	updatedby = 'CDM-32996', 
	updatedon = now()
where intakeservicerequestactorid 
	in (	
		select intakeservicerequestactorid 
			from intakeservicerequestactor
where personid = '830d268a-0eb1-4a42-af27-7e74f6cca343'
			and intakeserviceid = '79183c97-873a-4eb1-9acd-231668bdbad2'
		)	
	and activeflag = 1;	

-- Perosn Roles
	
update intakeservicerequestactor	
set activeflag = 0,
	updatedby = 'CDM-32996', 
	updatedon = now()
where personid = '830d268a-0eb1-4a42-af27-7e74f6cca343'
			and intakeserviceid = '79183c97-873a-4eb1-9acd-231668bdbad2'
	and activeflag = 1 ;
	
--actor
update actor
set activeflag = 0,
	updatedby = 'CDM-32996', 
	updatedon = now()
where personid = '830d268a-0eb1-4a42-af27-7e74f6cca343'
			and intakeserviceid = '79183c97-873a-4eb1-9acd-231668bdbad2'
	and activeflag = 1 ;

--personrole
update personrole
set activeflag = 0,
	updatedby = 'CDM-32996', 
	updatedon = now()
where personid = '830d268a-0eb1-4a42-af27-7e74f6cca343'
			and intakeserviceid = '79183c97-873a-4eb1-9acd-231668bdbad2'
	and activeflag = 1 ;

