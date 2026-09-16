-- CIDM-8667 - Invalid Count Codes to MDM
/*
Issue Details: CJAMS is sending invalid county codes to MDM. 

-- Category/ Module: Person
-- Root cause: 
-- Fix Provided: Increased size of mdmcode column in reference values table to fit MDM county codes and 
-- 				Datafix has been promoted to update the mdm codes in reference values table.
-- Note: N/A
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

drop view cjams.sdr_referencevalues_vw;

alter table cjams.referencevalues alter column mdmcode type varchar(50);

CREATE OR REPLACE VIEW cjams.sdr_referencevalues_vw
AS SELECT referencevalues.ref_key,
    referencevalues.referencetypeid,
    referencevalues.value_text,
    referencevalues.description,
    referencevalues.teamtypekey,
    referencevalues.activeflag,
    referencevalues.displayorder,
    referencevalues.insertedby,
    referencevalues.insertedon,
    referencevalues.updatedby,
    referencevalues.updatedon,
    referencevalues.parenttypeid,
    referencevalues.parentkey,
    referencevalues.mdmcode
   FROM referencevalues;

