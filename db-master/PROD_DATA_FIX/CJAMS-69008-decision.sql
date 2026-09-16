/* 
    Issue Description: CJAMS-69008
  Category/ Module  : Decision
  Root cause: User request to update the decision to accepted and supervisor decision to screenin
  Fix Provided: As requested data fix has been provided by updating the decision to accepted and supervisor decision to screenin
  Pull request# for code fix: 
  Reason why no related code fix: 
  Status of the code fix if already submitted and expected prod fix date: 
  Backup before update/ delete: 
*/

UPDATE intakedastaging
SET status = 'Accepted',
updatedby = 'CJAMS-69008', updatedon = now(), 
jsondata = jsonb_set(jsondata, '{DAType}',
jsonb_set(jsondata->'DAType', '{DATypeDetail}',
jsonb_set(jsondata->'DAType'->'DATypeDetail', '{0}',
jsonb_set(jsondata->'DAType'->'DATypeDetail'->0, '{supDisposition}', '"Scrnin"'))))
WHERE intakenumber = 'I261014127827' AND activeflag=1;

update intakedastatus 
set status =2, updatedby = 'CJAMS-69008', updatedon = now()
where intakenumber ='I261014127827' and activeflag =1;

update routing 
set routingstatustypeid =2, 
	supervisordecision ='Scrnin',
	updatedby = '69b55bdc-1611-4219-bf06-79b4a5f9e5b7', 
	updatedon = now()
where objectid ='I261014127827' and activeflag =1;