update actor 
set personid = 'e3adc13e-67a4-4ce9-85a1-93d60c54d474', updatedon = now(), updatedby = 'CDM-10839'
where actorid = '5474af8f-953e-421d-a6db-e01b0d24a1fc';
update intakeservicerequestactor 
set personid = 'e3adc13e-67a4-4ce9-85a1-93d60c54d474', isheadofhousehold = true, updatedon = now(), updatedby = 'CDM-10839'
where actorid = '5474af8f-953e-421d-a6db-e01b0d24a1fc';


update actor 
set personid = 'b656e32b-5af3-424a-bd85-440f93a1066c', updatedon = now(), updatedby = 'CDM-10839'
where actorid = '12286b35-7508-457c-b7c0-3d945bd2d32b';
update intakeservicerequestactor 
set personid = 'b656e32b-5af3-424a-bd85-440f93a1066c', isheadofhousehold = false, updatedon = now(), updatedby = 'CDM-10839'
where actorid = '12286b35-7508-457c-b7c0-3d945bd2d32b';