/*
 Issue Description: CIDM-9746
-- Category/ Module: View Tickets 
-- Root cause: NA
-- Fix Provided: Index for new column 'identifiedas' on supportlog table           
*/

CREATE INDEX if not exists xie14_supportlog ON defecttracking.supportlog USING btree(identifiedas);