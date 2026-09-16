UPDATE cjams.servicecase
SET activeflag=0, updatedon=now(), updatedby='CDM-1564'
WHERE servicecaseid='92f0c9e3-c6fe-4d10-b5c1-980b06498306';

UPDATE cjams.intakeservicerequest
SET updatedby='CDM-1564', activeflag=0, updatedon=now()
WHERE intakeserviceid='966cc45d-5d74-4ae8-817b-14721e69c905';

UPDATE cjams.personprogramarea
SET updatedby='CDM-1564', updatedon=now(), activeflag=0, datatransferflag='D'
WHERE personprogramid in ('ff34c2b6-a1e8-4618-ade3-ddc1c521e48f', '5ad29b68-5211-4911-8884-b460da4d55be', '24ba3d29-69db-49d3-91ec-657949b8d7da', '91019689-e369-4ef7-9c2c-c726fe521a16');
