select * from cjams.createservicecase('b1a09667-8b36-43c9-89b9-85ea000ce0eb', null, 1,'1287622e-f1a4-4875-accb-d46953efca5c', 'intake' );

update 
intakeservicerequest 
set 
activeflag = 0,
updatedon = now(),
updatedby = 'CDM-16958'
where 
intakeserviceid = 'b1a09667-8b36-43c9-89b9-85ea000ce0eb';