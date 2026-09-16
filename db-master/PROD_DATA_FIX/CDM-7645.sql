
--CDM-7645 - removing removal end date to start adoption planing

UPDATE intakeservreqchildremoval SET exitdate= NULL, removalexitreason = NULL, updatedby = 'CDM-7645' , updatedon = now() WHERE 
intakeservreqchildremovalid IN ('c40356c9-08cb-42eb-87e4-cfba088d3a4a', '64e73ba0-8c02-41ee-aa8c-6791e2156a83') AND 
activeflag = 1 AND exitdate = '2020-07-15 11:00:00';

--CDM-7756 - service case 2020022502358 - remove ooh end date
UPDATE personprogramarea SET enddate = NULL, updatedon = now() WHERE entityid = 2020022502358 AND programkey = 'OOH' AND trunc(enddate ) = '2020-12-09';

--CDM-7646 - inactivate gap review
UPDATE routing SET activeflag = 1, updatedon = now(), updatedby = 'CDM-7646' WHERE routingid = '0d8550cd-2b92-40f2-bd27-3dfac5e71be7' AND activeflag = 1;
