/*
 * CDM-42263 - Service case is not linked to the GAP worksheet. 
 * Customer Email ID:lashay.fuller1@maryland.gov
 * 
 */


update intakeservreqchildremoval 
set intakeservicerequestactorid = '65d29240-9813-4d0e-9656-a2e4f55ab0a3'
where personid = 'f5061351-ac42-45c5-a5be-6a89d78e2484';

update permanencyplan 
set intakeservicerequestactorid = '65d29240-9813-4d0e-9656-a2e4f55ab0a3' 
where permanencyplanid in (
select pp.permanencyplanid  from permanencyplan pp 
join intakeservicerequestactor isra on --isra.intakeservicerequestactorid = pp.intakeservicerequestactorid --and 
 isra.servicecaseid = pp.servicecaseid
 join person p on p.personid = isra.personid 
WHERE p.cjamspid::bigint = '201143277'
);