UPDATE routing
SET activeflag = 0, updatedby = 'CDM-1672', updatedon = now()
WHERE routingid = '774d291d-65e3-4d7b-90ba-044b0744514e';

UPDATE usernotification
SET activeflag = 0, updatedby = 'CDM-1672', updatedon = now()
WHERE usernotificationid = '01547505-8cf9-4ac2-a70d-289788ea9651';

UPDATE servicecasedisposition
SET activeflag = 0, updatedby = 'CDM-1672', updatedon = now()
WHERE servicecasedispositionid = '07f48117-7c1d-4100-8388-fe92bc9a2efe';

UPDATE servicecase
SET statustypekey = 'Closed', dispositioncode = 'Closed', startdate = '2014-08-18 14:34:41', enddate = '2014-10-11 13:45:26', updatedby = 'CDM-1672', updatedon = now()
WHERE servicecaseid = '2e057ff5-f2ed-496c-a549-3754a286a9c5';

UPDATE intakeservicerequestactor
SET activeflag = 0, updatedby = 'CDM-1672', updatedon = now()
WHERE intakenumber = 'I202000166191';

UPDATE routing
SET activeflag = 0, updatedby = 'CDM-1672', updatedon = now()
WHERE objectid = 'I202000166191';

UPDATE intakedastaging
SET activeflag = 0, updatedby = 'CDM-1672', updatedon = now()
WHERE intakenumber = 'I202000166191';

UPDATE intakesnapshot
SET activeflag = 0, updatedby = 'CDM-1672', updatedon = now()
WHERE intakenumber = 'I202000166191';

UPDATE intakedastatus
SET activeflag = 0, updatedby = 'CDM-1672', updatedon = now()
WHERE intakenumber = 'I202000166191';

UPDATE actor
SET activeflag = 0, updatedby = 'CDM-1672', updatedon = now()
WHERE intakenumber = 'I202000166191';

UPDATE personrole
SET activeflag = 0, updatedby = 'CDM-1672', updatedon = now()
WHERE intakenumber = 'I202000166191';