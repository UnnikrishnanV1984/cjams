/*
   Issue Description: CDM-18259
   Category/ Module  : Screenout should be reverted
   Root cause: user wants the referral not be screened out.
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/
UPDATE intakesnapshot 
SET 
updatedby = 'CDM-18259', 
updatedon = now(), 
jsondata = jsonb_set(jsondata, '{DAType}', 
			jsonb_set(jsondata->'DAType', '{DATypeDetail}', 
			jsonb_set(jsondata->'DAType'->'DATypeDetail', '{0}', 
			jsonb_set(jsondata->'DAType'->'DATypeDetail'->0, '{supDisposition}', '""'))))
WHERE intakenumber = 'I211010200364' AND activeflag=1;

update routing set routingstatustypeid = 1,updatedby = 'CDM-18259', updatedon = now() where objectid = 'I211010200364' and activeflag = 1;


update intakedastatus set status = null, updatedby = 'CDM-18259' , updatedon = now() where intakenumber = 'I211010200364';


update cjams.intakedastaging set ispreintake =false, updatedby ='CDM-18259', updatedon =now()  where intakenumber ='I211010200364' and activeflag = 1;