-- CDM-30851 - Duplicate removalt
/*
-- Issue Description: The system did a duplicat removal and we have one pending and one approved. We need the one in review deleted.Wanda Noltwanda.nolt@maryland.gov
   
-- CPS-IR: 211030011341 

-- Category/ Module: Child Removal
-- Root cause: Duplicate entries with 1 sec apart same values are recorded in all the fields.   
-- Pull request# TBD
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A 
*/

UPDATE cjams.intakeservreqchildremoval
SET  activeflag = 0 , updatedon = now(), updatedby = 'CDM-30851'
WHERE intakeservreqchildremovalid='029cbb2f-0eb1-48e8-b6d4-fd856294414b' and personid='e7f84c0b-0d0a-4de3-b845-0e4a1c61a4da';

UPDATE cjams.routing
SET  activeflag = 0 , updatedon = now(), updatedby = 'CDM-30851'
WHERE objectid='029cbb2f-0eb1-48e8-b6d4-fd856294414b';

UPDATE cjams.intakeservreqchildremoval_history
SET  activeflag = 0 , updatedon = now(), updatedby = 'CDM-30851'
WHERE intakeservreqchildremovalid='029cbb2f-0eb1-48e8-b6d4-fd856294414b' and activeflag = 1;
