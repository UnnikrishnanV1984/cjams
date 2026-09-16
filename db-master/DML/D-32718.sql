update INTAKESERVREQCHILDREMOVAL
set updatedon = now(), updatedby = 'Datafix user as per D-32718'
where PERSONID IN('c6aa7e40-0089-404e-8b92-6732cad9956c',
'be0a9545-8c5c-4ca2-b736-4b9859d5b689') and activeflag=0;

update placement
set updatedon = now(), updatedby = 'Datafix user as per D-32718'
where PERSONID IN('c6aa7e40-0089-404e-8b92-6732cad9956c',
'be0a9545-8c5c-4ca2-b736-4b9859d5b689') and activeflag=0;