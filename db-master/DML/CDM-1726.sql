update placement
set activeflag=0, updatedon = now(), updatedby = 'Datafix user as per CDM-1726'
where placementid in ('b040b829-fca7-46ea-bc64-2c4493b93b62','bd0fedf6-4c90-40d8-a505-93d0a3e03623','f54907e8-eb90-4b02-a5df-7bb004490fb9','2ee8c0dc-af88-4af1-b420-bf77f35f3656','086ee7ed-37b5-424d-9d20-bba2ab71309a');

