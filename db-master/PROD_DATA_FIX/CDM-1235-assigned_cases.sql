UPDATE intakeservicerequest
SET intakeservicerequestclassid  = '00000000-0000-0000-0000-000000000000', actiontype = NULL, updatedby = 'CDM-1235', updatedon = now()
WHERE intakeserviceid IN ('be9feb3c-fa8a-4590-9847-83de9757bd8b','5cbdad0e-60b1-4436-9b0c-763e8e3dfc04');