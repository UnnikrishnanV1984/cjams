update placement
set activeflag=1, INTAKESERVREQCHILDREMOVALID ='75dd4bf2-b5d6-4bf3-bd5b-2d591e58bea0', updatedon = now(), updatedby = 'Datafix user as per CDM-1636'
where personid = 'c6aa7e40-0089-404e-8b92-6732cad9956c' and enddatetime is null;

update placement
set activeflag=1, INTAKESERVREQCHILDREMOVALID ='18036fe7-4e51-4b98-993d-946ca6f9b6e8', updatedon = now(), updatedby = 'Datafix user as per CDM-1636'
where personid = 'be0a9545-8c5c-4ca2-b736-4b9859d5b689' and enddatetime is null;