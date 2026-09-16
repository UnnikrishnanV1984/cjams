-- CDM-26284 - No approval date
/*
-- Issue Description: 
	1. As per QA, there are no approved date in the submission history and also the status still Review
		and if there any record in our Db, please populate it to the referral

	
-- Category/ Module: Routing
-- Root cause: Duplicate note
-- Pull request# N/A 
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

UPDATE  intakedastaging
SET     jsondata = jsonb_set(jsondata, '{DAType,DATypeDetail,0,supDisposition}', '"Scrnin"'),
        updatedon = '2022-06-28 11:48:46.153',
        updatedby = 'CDM-26284'
WHERE   intakenumber = 'I221010290796' AND activeflag = 1;

UPDATE  intakedastaging
SET     jsondata = jsonb_set(jsondata, '{disposition,0,supDisposition}', '"Scrnin"'),
        updatedon = '2022-06-28 11:48:46.153',
        updatedby = 'CDM-26284'
WHERE   intakenumber = 'I221010290796' AND activeflag = 1;

UPDATE  intakedastatus
SET     jsondata = (select jsondata from intakedastaging WHERE   intakenumber = 'I221010290796' AND activeflag = 1),
        updatedon = '2022-06-28 11:48:46.153',
        updatedby = 'CDM-26284'
WHERE   intakenumber = 'I221010290796' AND activeflag = 1;

UPDATE  intakesnapshot
SET     jsondata = (select jsondata from intakedastaging WHERE   intakenumber = 'I221010290796' AND activeflag = 1),
        updatedon = '2022-06-28 11:48:46.153',
        updatedby = 'CDM-26284'
WHERE   intakenumber = 'I221010290796' AND activeflag = 1;

UPDATE  routing
SET     routingstatustypeid = ( SELECT sequencenumber FROM routingstatustype WHERE routingstatustypekey = 'Accepted' AND activeflag = 1),
        updatedon = '2022-06-28 11:52:56.153',
        updatedby = '55c8ea0d-98d3-455a-98ec-db067c1ec65d'
WHERE   objectid = 'I221010290796' AND eventcode = 'INTR' AND activeflag = 1;