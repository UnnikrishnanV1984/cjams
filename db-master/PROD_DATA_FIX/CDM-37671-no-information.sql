/*
    CDM-37671
    Issue - case doesn't have any information 

    Root cause: CJAMS generated a blank case which is appearing under the worker workload.
    Fix - Datafix has given to remove the blank case and the worker case assignment
*/

select * from servicecase where servicecaseid  = '5e3819d8-44af-4fe9-959a-44c955d8ee95' and activeflag = 1;
update servicecase
set activeflag = 0,
	updatedby = 'CDM-37671',
	updatedon = now()
where servicecaseid  = '5e3819d8-44af-4fe9-959a-44c955d8ee95' and activeflag = 1;

select * from caseassignment where objectid = '5e3819d8-44af-4fe9-959a-44c955d8ee95' and activeflag = 1;
update caseassignment
set activeflag = 0,
	updatedby = 'CDM-37671',
	updatedon = now()
where objectid = '5e3819d8-44af-4fe9-959a-44c955d8ee95' and activeflag = 1;

select * from servicecasedisposition where servicecaseid  = '5e3819d8-44af-4fe9-959a-44c955d8ee95' and activeflag = 1;
update servicecasedisposition
set activeflag = 0,
	updatedby = 'CDM-37671',
	updatedon = now()
where servicecaseid  = '5e3819d8-44af-4fe9-959a-44c955d8ee95' and activeflag = 1;

select * from routing where objectid = '5e3819d8-44af-4fe9-959a-44c955d8ee95' and activeflag = 1;
update routing
set activeflag = 0,
	updatedby = 'CDM-37671',
	updatedon = now()
where objectid  = '5e3819d8-44af-4fe9-959a-44c955d8ee95' and activeflag = 1;