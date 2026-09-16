-- new service case 211030011546
select * from cjams.createservicecase('039658f2-4963-4eae-8f97-de16d1417f30', null, 1,'1287622e-f1a4-4875-accb-d46953efca5c', 'intake' );

update 
intakeservicerequest 
set 
activeflag = 0,
updatedon = now(),
updatedby = 'CDM-16958'
where 
intakeserviceid = '039658f2-4963-4eae-8f97-de16d1417f30';