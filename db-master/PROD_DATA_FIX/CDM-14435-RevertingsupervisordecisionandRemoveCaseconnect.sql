-- CDM-14435 - reverting supervisor decision and removing the caseconnect --
UPDATE intakesnapshot 
SET 
updatedby = 'CDM-14435', 
updatedon = now(), 
jsondata = jsonb_set(jsondata, '{DAType}', 
			jsonb_set(jsondata->'DAType', '{DATypeDetail}', 
			jsonb_set(jsondata->'DAType'->'DATypeDetail', '{0}', 
			jsonb_set(jsondata->'DAType'->'DATypeDetail'->0, '{supDisposition}', '""'))))
WHERE intakenumber = 'I211010161070 ' AND activeflag=1;

update routing set routingstatustypeid = 1,updatedby = 'CDM-14435', updatedon = now() where objectid = 'I211010161070' and activeflag = 1;

-- 2
update intakedastatus set status = null, updatedby = 'CDM-14435' , updatedon = now() where intakenumber = 'I211010161070';

-- true
update cjams.intakedastaging set ispreintake ='false', updatedby ='CDM-14435', updatedon =now()  where intakenumber ='I211010161070' and activeflag = 1;

update servicecase set activeflag = 0, updatedby = 'CDM-14435', updatedon = now() where servicecaseid = 'ebffb169-710b-4ddd-90bd-c75512bb034a' and activeflag = 1;
