/* 
    Issue Description: CDM-44093
   Category/ Module  : Intake
   Root cause: User requested screenout intake supervisor decision
   Pull request# for code fix: 
   Reason why no related code fix: User Error
*/


update routing set supervisordecision = 'ScreenOUT',intakerecommendation ='ScreenOUT',updatedon=now(),updatedby = 'CDM-44093'
where routingid = '743dccb6-4f48-4ec1-9137-2203a6291f05'  and objectid ='I251013216400';


UPDATE intakesnapshot 
SET updatedby = 'CDM-44093', updatedon = now(), jsondata = jsonb_set(jsondata, '{DAType}', 
			jsonb_set(jsondata->'DAType', '{DATypeDetail}', 
			jsonb_set(jsondata->'DAType'->'DATypeDetail', '{0}', 
			jsonb_set(jsondata->'DAType'->'DATypeDetail'->0, '{supDisposition}', '"ScreenOUT"'))))
WHERE intakenumber = 'I251013216400' AND activeflag=1;


UPDATE intakedastaging
SET updatedby = 'CDM-44093', updatedon = now(), jsondata = jsonb_set(jsondata, '{DAType}',
jsonb_set(jsondata->'DAType', '{DATypeDetail}',
jsonb_set(jsondata->'DAType'->'DATypeDetail', '{0}',
jsonb_set(jsondata->'DAType'->'DATypeDetail'->0, '{supDisposition}', '"ScreenOUT"'))))
WHERE intakenumber = 'I251013216400' AND activeflag=1;