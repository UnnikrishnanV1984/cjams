/*
   Issue Description: CJAMS-67552
   Category/ Module: intake submission history
   Root cause: User requested to update the status to closed and supervisor decision to screenout.
   Fix Provided : Data fix is done to update the status to closed and supervisor decision to screenout
   Pull request# for code fix:  N/A
   Is code fix required:No
   Status of the code fix if already submitted and expected prod fix date: N/A
   Backup before update/ delete: N/A
*/

UPDATE 	intakesnapshot 
SET 	updatedby = 'CJAMS-67552', updatedon = now(), jsondata = jsonb_set(jsondata, '{DAType}', 
			jsonb_set(jsondata->'DAType', '{DATypeDetail}', 
			jsonb_set(jsondata->'DAType'->'DATypeDetail', '{0}', 
			jsonb_set(jsondata->'DAType'->'DATypeDetail'->0, '{supDisposition}', '"ScreenOUT"'))))
WHERE 	intakenumber = 'I261014013673' AND activeflag=1;

UPDATE intakedastaging
SET status = 'Closed',
updatedby = 'CJAMS-67552', updatedon = now(), jsondata = jsonb_set(jsondata, '{DAType}',
jsonb_set(jsondata->'DAType', '{DATypeDetail}',
jsonb_set(jsondata->'DAType'->'DATypeDetail', '{0}',
jsonb_set(jsondata->'DAType'->'DATypeDetail'->0, '{supDisposition}', '"ScreenOUT"'))))
WHERE intakenumber = 'I261014013673' AND activeflag=1;

update routing
set supervisordecision ='ScreenOUT', routingstatustypeid =8, updatedby ='7a8cd264-8789-4016-9bb1-353a27d24785', updatedon =now()
where objectid ='I261014013673' and routingid ='9c116b59-8a11-4863-a5f9-ffa18ff03bbd';