/*
-- Issue Description: CIDM-8809: CJAMS-CW- Immunet Interface (CRISP)
-- Root cause: Duplicate records available for each immunization
-- Fix Provided: Only the latest record for each immunization is left active
*/

-- update personimmunization 
-- set activeflag = 0, updatedby= 'CIDM-8809', updatedon = now()
-- where personimmunizationid in (select personimmunizationid from (
--     select  personimmunizationid
--     ,row_number () over ( partition by personid,personimmunizationconfigid,dose order by insertedon desc)  as rownum
--     from personimmunization where personimmunizationconfigid is not null and dose is not null)s 
--     where rownum <> 1
--     );

-- Rewriting after the screen changes to fix duplicate by immunization date not dose.

update personimmunization 
set activeflag = 0, updatedby= 'CIDM-8809', updatedon = now()
where personimmunizationid in (select personimmunizationid from (select  personimmunizationid,
    row_number () over (partition by personid,personimmunizationconfigid, immunizationdate order by insertedon desc)  as rownum
    from personimmunization where personimmunizationconfigid is not null and immunizationdate is not null and vaccineadministered is null and activeflag = 1) s
    where rownum <> 1
);