
/*

Date : 03-23-2026
Author: Agathya
Purpose: to load the generated mdm and irn from mdm to cjams.
Ticket : CIDM-11251

*/
/*

-- Get the current active and inactice mdm and irn numbers.
select personidentifiertypekey,activeflag ,count(1), count(distinct pi.personid) from cjams.personidentifier pi 
where pi.personid in (
select personid from cjams.person where cjamspid in (
select source_sys_id::bigint from cjams.mdm_sys_reference msr 
)
)
and pi.personidentifiertypekey in ('MDM_ID','IRN')
group by 1,2
;

*/

-- Update all current active MDM and IRNs to 0.
update cjams.personidentifier pi  
set activeflag = 0 ,
updatedby = 'CIDM-11251',
updatedon = now()
where pi.activeflag = 1
and pi.personidentifiertypekey in ('MDM_ID','IRN')
and pi.personid in (
select personid from cjams.person where cjamspid in (
select source_sys_id::bigint from cjams.mdm_sys_reference msr 
)
)
;

-- Script to update the generated MDM and IRN from mdm_sys_reference table to personidentifier table.

DO $$
DECLARE
    row_record RECORD;
v_personid uuid;

BEGIN
    -- The loop iterates through each row returned by the query
    FOR row_record IN 
        SELECT * from cjams.mdm_sys_reference 
    LOOP

select personid into v_personid from cjams.person where cjamspid = row_record.source_sys_id::bigint;

        -- Complex logic can go here
        INSERT INTO cjams.personidentifier
( personid, personidentifiertypekey, personidentifiervalue, updatedby,
 updatedon, insertedby, insertedon, activeflag, effectivedate, expirationdate, old_id, "timestamp", etl_userid, etl_load_date)
VALUES(
v_personid,  'MDM_ID', row_record.mdm_id, 'CIDM-11251', 
now(), 'CIDM-11251', now(), 1, now(), NULL, NULL, NULL, NULL, NULL);


        INSERT INTO cjams.personidentifier
( personid, personidentifiertypekey, personidentifiervalue, updatedby,
 updatedon, insertedby, insertedon, activeflag, effectivedate, expirationdate, old_id, "timestamp", etl_userid, etl_load_date)
VALUES(v_personid,  'IRN', row_record.irn_id, 'CIDM-11251', 
now(), 'CIDM-11251', now(), 1, now(), NULL, NULL, NULL, NULL, NULL);


        -- Optional: Log the progress
        RAISE NOTICE 'Inserted user: %', row_record.source_sys_id;
    END LOOP;
END $$;

-- Update the cis id for records that do not have the first cis client id loaded in cjams.
update cjams.person p set cisclientid = a.irn_id 
,updatedby = 'CIDM-11251-1',
updatedon = now()
from cjams.mdm_sys_reference a 
where a.source_sys_id::int = p.cjamspid 
and  p.cisclientid is  null;
