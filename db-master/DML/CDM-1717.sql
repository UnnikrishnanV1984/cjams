update permanencyplan
set activeflag=0 , updatedon = now(), updatedby = 'Datafix user as per CDM-1717'
where permanencyplanid = 'b0e81f50-c841-476c-a091-09b3422b9c1e';