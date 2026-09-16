/*
-- CDM-21433 - 
-- Issue Description: Reopen Case and OOH/OHP
-- Customer Email ID: wanda.nolt@maryland.gov
-- Closed  on:        2022-03-07 15:16:37
-- Root cause: Data fix to Reopen Case and OOH/OHP
-- Pull request#: N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

UPDATE cjams.servicecase SET 
                statustypekey = 'Open', 
                dispositioncode = 'Open', 
                enddate = null, 
                updatedby = 'CDM-21433',
                updatedon = now()
where servicecaseid = '420ab76c-2ae4-412a-b642-1c597ef6a76d';

UPDATE cjams.servicecasedisposition   SET 
                activeflag = 0, 
                updatedby = 'CDM-21433',
                updatedon = now() 
WHERE servicecasedispositionid in (
'c1ee3449-e842-4d1a-9f2c-75cdb7a866d9'
);