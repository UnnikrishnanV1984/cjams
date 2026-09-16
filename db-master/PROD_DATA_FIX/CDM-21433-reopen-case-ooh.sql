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

select * from personprogramarea 
where personprogramid ='ac5521b4-c45f-4a63-b3e3-58c1e810380c';

--2022-03-08 12:18:45
UPDATE cjams.personprogramarea
SET enddate = null,
updatedon = now(),
updatedby = 'CDM-21433'
where personprogramid ='ac5521b4-c45f-4a63-b3e3-58c1e810380c';