update routing
set activeflag= 1, updatedon = now(), updatedby = 'Datafix user as per CDM-914'
where servicerequestnumber = '202005601000' and eventcode = 'PPLR' 
and fromsecurityusersid = '4e551d6c-61dd-4758-836a-da5015b86c8a'
and tosecurityusersid = '19e38454-17c2-41a0-830c-e6e1110ec820' 
and objectid = 'fa358853-dae2-483a-a5f8-9ac74c03a9ad';