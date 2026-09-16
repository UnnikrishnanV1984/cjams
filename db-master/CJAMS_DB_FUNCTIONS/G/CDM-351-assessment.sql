--CDM-351 Pending Approval Even after the case is closed

--2020035015256 2020042015514 202005601000

UPDATE routing SET activeflag = 0, updatedon = now(), updatedby = 'CDM-351' WHERE 
routingid IN ( 'c4aae0b3-66bf-4263-b9fb-04ccbf760a94',
'08c72fa5-ef32-4976-a599-490a756134e9', '2f16f116-ab1b-478c-9a34-9328844ecb6a') ;
