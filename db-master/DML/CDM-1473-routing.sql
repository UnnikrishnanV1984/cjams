UPDATE cjams.routing
SET eventcode='INTR', routingstatustypeid=2, activeflag=1 , updatedon = now(), updatedby = 'CDM-1473' 
WHERE routingid='7261ff16-552e-4756-a4d4-708d7a626410';

UPDATE cjams.intakedastatus SET status = 2, submitteddate =  '2020-06-22 00:00:00', updatedon = now(), updatedby = 'CDM-1473' WHERE intakenumber = 'I202000165191';




