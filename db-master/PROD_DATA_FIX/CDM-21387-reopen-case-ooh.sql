/*
-- CDM-21387 - 

-- Issue Description: 
 Reopen Case and OOH PA
  
-- Customer Email ID:christopher.snow@maryland.gov

-- Root cause: Data fix to Reopen Case and OOH PA
-- Pull request#: N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- Closed        Closed        2022-02-17 21:16:37
UPDATE servicecase SET statustypekey = 'Open', 
                dispositioncode = 'Open', 
                enddate = null, 
                updatedby = 'CDM-21387',
                updatedon = now()
where servicecaseid = '443c89c6-4027-4885-864a-0753884e5d0f';

UPDATE servicecasedisposition 
        SET activeflag = 0, 
                updatedby = 'CDM-21387',
                updatedon = now() 
WHERE servicecasedispositionid = 'bd671758-72a5-48ca-a9b6-3b2dc68c5b01';

--2022-02-17
update personprogramarea
set enddate = null,
updatedby = 'CDM-21387',
updatedon = now() 
where personprogramid = 'e4043295-afee-4b19-9302-fe1e7aa973a7';