
update cjams.routing
set activeflag = 0 , updatedby = 'CDM-9095' , updatedon = now()
where routingid in ('7d0e90d6-72b9-4e8d-9cf7-3817bbc899ce',
'9cb557ad-2e94-4b4f-b1a9-234778e02948',
'8a11b984-20a5-449b-bb5b-9639f9615821',
'efc0c17d-01d9-46e8-be4e-18659e18d1f9',
'8cce2e7d-fb26-48ac-8684-553f27245903', 
'92790fcd-7d22-4e38-8164-9f4723f2ea79');


