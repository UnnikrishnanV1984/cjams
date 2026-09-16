/*
-- Issue Description: CIDM-8997: Program Assignment - Reason For Closure - Emanicipation needs spelling correction
-- Root cause: The spelling for Emancipation is spelled wrong. requested to update.
-- Fix Provided: Updated the referencevalues table with correct spelling
*/

update cjams.referencevalues set value_text='Legal Emancipation', description='Legal Emancipation',  updatedby='CIDM-8997', updatedon=now()
where referencevaluesid='9efec9d0-068b-4a6c-b86a-dc3258e0abc3' and activeflag = 1;