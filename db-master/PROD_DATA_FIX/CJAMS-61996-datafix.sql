/*
   Issue Description: CJAMS-61996
   Category/ Module  : Intake
   Root cause: Intake I241013169981  is created and submitted for supervisor review on 11/02/2024, and it has not been approved.
   Data fix has been done to screen out the intake.
   Fix provided: Data fix has been done to screen out the intake I241013169981 .
   Pull request#
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
 Need to do data fix
*/

UPDATE intakedastaging
SET status = 'Closed',
updatedby = 'CJAMS-61994', updatedon = now(), jsondata = jsonb_set(jsondata, '{DAType}',
jsonb_set(jsondata->'DAType', '{DATypeDetail}',
jsonb_set(jsondata->'DAType'->'DATypeDetail', '{0}',
jsonb_set(jsondata->'DAType'->'DATypeDetail'->0, '{supDisposition}', '"ScreenOUT"'))))
WHERE intakenumber = 'I241013169981' AND activeflag=1;


update routing 
set routingstatustypeid = 8, supervisordecision = 'screenout',updatedby ='CJAMS-61994', updatedon = now()
where objectid ='I241013169981' ;