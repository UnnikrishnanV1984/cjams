UPDATE intakeservicerequest
SET intakeservicerequestclassid  = '00000000-0000-0000-0000-000000000000', actiontype = null, updatedon = now(), updatedby  = 'CDM-1408'
WHERE intakeserviceid in ('8819bdbf-c254-4645-8990-7e1e6db9e37a','0b7fb2cf-a2b9-46cc-9f04-458489a39b58');