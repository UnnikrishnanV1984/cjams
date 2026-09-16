-- CDM-44114 - intake screener recomendation not allowing screen in
/* Issue Description:User unable to have screener decision be screen in to open CPS invs Screen

-- Intakenumber: I251013219153

-- Category/ Module: Intake 

-- Root cause: Action type is missing, so unable to create CPSIR/AR Case and couldnot select screener decision
-- Fix Provided: Datafix has been applied to nullify the json data on  scrnout_description for snapshot table and intakedastaging table along with the isar to true.
-- Pull request# N/A

*/
UPDATE intakedastaging
SET 
	updatedby = 'CDM-44114', 
    updatedon = now(), 
    jsondata = jsonb_set(
                jsonb_set(jsondata, '{sdm, screenOut, scrnout_description}', 'null'),
                '{sdm, isar}', 'true'
            )
WHERE intakenumber = 'I251013219153' and activeflag = 1 ;

UPDATE intakesnapshot
SET 
    updatedby = 'CDM-44114', 
    updatedon = now(), 
    jsondata = jsonb_set(
                jsonb_set(jsondata, '{sdm, screenOut, scrnout_description}', 'null'),
                '{sdm, isar}', 'true'
            )
WHERE intakenumber = 'I251013219153' and activeflag = 1;

update intakeservicerequest 
set actiontype = 'AR', 
activeflag = 0,
updatedon = now(),
updatedby = 'CDM-44114' 
where intakeserviceid = '622a290f-b30a-4327-956f-80e26038583d';