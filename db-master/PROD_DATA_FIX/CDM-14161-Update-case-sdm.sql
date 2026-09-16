update intakeservicerequestsdm 
set
ismalpa_nonaccident = true,
updatedon = now(),
updatedby = 'CDM-14161'
where intakeserviceid = '2fbc3161-dc1e-47d2-9795-31e2cf2e7145';