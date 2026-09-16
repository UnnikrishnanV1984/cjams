
UPDATE intakedastaging SET status = 'pending', updatedon = now(), updatedby = 'CDM-293' WHERE intakenumber = 'I202000459863' AND activeflag = 1 ;
UPDATE intakeservicerequest SET activeflag = 1, updatedon = now(), updatedby = 'CDM-293' WHERE intakenumber = 'I202000459863' AND activeflag = 1 ;
UPDATE intakeservicerequestactor SET intakeserviceid = NULL, updatedon = now(), updatedby = 'CDM-293' WHERE intakenumber= 'I202000459863' AND activeflag = 1;
UPDATE routing SET routingstatustypeid=1, updatedon = now(), updatedby = 'CDM-293' WHERE objectid = 'I202000459863' ;