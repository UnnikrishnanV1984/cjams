update routing
set activeflag=0, updatedon = now(), updatedby = 'Datafix user as per CDM-1659'
where routingid in ('14374801-f34d-4e8b-9f45-d8ee00bd4b03','ff7a99ad-9da4-4b5c-ab47-176385c7f2e3','23a882a9-f8ec-496e-9e51-93f0b35a889f','e472c55d-bc06-46fb-94ae-48705c6da071','572fbbe5-8e81-4592-b7a3-fea0d1bc49c5');


