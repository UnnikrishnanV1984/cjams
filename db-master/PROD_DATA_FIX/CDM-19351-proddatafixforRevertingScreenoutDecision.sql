
/*
   Issue Description: CDM-19351
   Category/ Module  : Removing CPS AR case and screenout intake
   Root cause: user requeseted to remove it
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

UPDATE intakesnapshot SET
updatedby = 'CDM-19351', updatedon = now(), jsondata = jsonb_set(jsondata, '{DAType}',
jsonb_set(jsondata->'DAType', '{DATypeDetail}',
jsonb_set(jsondata->'DAType'->'DATypeDetail', '{0}',
jsonb_set(jsondata->'DAType'->'DATypeDetail'->0, '{supDisposition}', '"ScreenOUT"'))))
WHERE intakenumber = 'I211010200364' AND activeflag=1;

-- Null
update intakedastatus set status = 8, updatedby = 'CDM-19351', updatedon = now()
where intakenumber = 'I211010200364' and activeflag = 1;

update personprogramarea set activeflag = 0, updatedby = 'CDM-19351', updatedon = now() where objectid = 'd7233f94-7744-402a-979b-de70b1427d52';

update intakeservicerequest i set activeflag = 0, updatedby = 'CDM-19351', updatedon = now() where intakeserviceid ='d7233f94-7744-402a-979b-de70b1427d52';
