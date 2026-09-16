update Permanencyplan
set activeflag= 0 , updatedon = now(), updatedby= 'Datafix user as per CDM-1410'
where Permanencyplanid in ('bcf82b57-b35b-4697-9cd5-091c15eae340',
						  'd056196b-e2fa-43d0-a134-26749e55709f',
						  '8d70216e-5b60-4045-9971-ec607433149a');