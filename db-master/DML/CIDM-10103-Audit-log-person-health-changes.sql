-- Step 1: Delete from the 'auditlog' table where the 'logtypekey' is still being referenced
DELETE FROM cjams.auditlog
WHERE logtypekey = 'print-person-health-summary';

-- Step 2: Delete the record from 'auditlogtype'
DELETE FROM cjams.auditlogtype
WHERE logtypekey = 'print-person-health-summary' and insertedby = 'CIDM-10103';

-- Step 3: Delete the record from 'tb_picklist_values'
DELETE FROM cjams.tb_picklist_values
WHERE picklist_value_cd = '109' AND picklist_type_id = 10060 and create_user_id = 'CIDM-10103';

-- Step 4: Insert the new value into 'tb_picklist_values'
INSERT INTO cjams.tb_picklist_values
(picklist_value_cd, picklist_type_id, value_tx, description_tx, active_sw, sort_order_no, create_ts, create_user_id, update_ts, update_user_id, delete_sw, category_tx)
VALUES('109', 10060, 'Person Health Summary', 'Person Health Summary', 'Y', 0, Now(), 'CIDM-10103', Now(), 'CIDM-10103', 'N', NULL);

-- Step 5: Insert the new audit log entry into 'auditlogtype'
INSERT INTO cjams.auditlogtype
    (logtypeid, logtypekey, logtype, modulename, effectivedate, 
     expirationdate, insertedby, updatedby, insertedon, updatedon, old_id)
VALUES
    (gen_random_uuid(), 'print-person-health-summary', 'Print Person Health Summary', 'Person Health Summary', now(), 
     NULL, 'CIDM-10103', 'CIDM-10103', now(), now(), NULL);