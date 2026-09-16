--CDM-7177 update CIS Id
UPDATE person set cisclientid= 417040341, updatedon = now(), updatedby = 'CDM-7177' WHERE cjamspid = 4310821;

--CDM-7403
UPDATE intakeservreqchildremoval SET removalexitreason= 'EMANIND', exitdate = '2020-09-14 06:00:00', updatedon = now(), 
updatedby = 'CDM-7177' WHERE removalid = 166613 AND activeflag = 1;

--CDM-6596
UPDATE intakeservreqchildremoval SET removalexitreason= 'REUNIF', exitdate = '2020-09-22 12:00:00', updatedon = now(), 
updatedby = 'CDM-6596' WHERE removalid =  185621 AND activeflag = 1;

--CDM-6932 - update routing

UPDATE routing SET fromsecurityusersid = '936ce49e-956d-46f8-bb8e-7e37415221ad', updatedby = 'CDM-6932', updatedon = now() WHERE 
routingid = 'fa7f650f-688c-4414-81c8-e69bcecb7629';

--CDM-7035
UPDATE personprogramarea SET enddate = '2014-03-30 00:00:00', updatedon = now(), updatedby = 'CDM-7035' 
WHERE entityid = 'CW2648659' AND enddate IS NULL AND programkey = 'CPS' AND activeflag = 1 ;

UPDATE personprogramarea SET enddate = '2014-03-30 00:00:00', updatedon = now(), updatedby = 'CDM-7035' 
WHERE entityid = 'CW2782194' AND enddate IS NULL AND programkey = 'CPS' AND activeflag = 1;

--CDM-7034
UPDATE personprogramarea SET enddate = '2020-11-04 00:00:00', updatedon = now(), updatedby = 'CDM-7034' 
WHERE entityid = '2020024102697' AND enddate IS NULL AND programkey = 'OOH' AND activeflag = 1; 

UPDATE personprogramarea SET enddate = '2020-08-26 00:00:00', updatedon = now(), updatedby = 'CDM-7034' 
WHERE entityid = '2020024102697' AND enddate IS NULL AND programkey = 'CPS' AND activeflag = 1; 

UPDATE personprogramarea SET enddate = '2020-08-26 00:00:00', updatedon = now(), updatedby = 'CDM-7034' 
WHERE entityid = 'CW2956320' AND enddate IS NULL AND programkey = 'CPS' AND activeflag = 1; 
