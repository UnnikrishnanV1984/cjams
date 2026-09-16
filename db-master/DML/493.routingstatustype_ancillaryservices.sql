DELETE FROM routingstatustype WHERE sequencenumber in (110, 111, 112);
DELETE FROM referencevalues WHERE referencetypeid = 46 AND ref_key in ('ANCSR', 'ANCSU');
DELETE FROM tb_picklist_values WHERE picklist_type_id = 2 and picklist_value_cd in ('26') and delete_sw='N';

-- Payment Picklist value
INSERT INTO cjams.tb_picklist_values(picklist_value_cd, picklist_type_id, value_tx, description_tx, active_sw, sort_order_no, create_ts, create_user_id, update_ts, update_user_id, delete_sw, category_tx)
VALUES('26', 2, 'CfE Bed Hold Retainer Fee', 'CfE Bed Hold Retainer Fee', 'Y', 0, now(), 'cadmin', now(), 'cadmin', 'N', NULL);

-- Routing Status
INSERT INTO cjams.routingstatustype(sequencenumber, routingstatustypekey, activeflag, typedescription, effectivedate, insertedby, updatedby, insertedon, updatedon)
VALUES(110, 'ANPRS', 1, 'Ancillary Services Payment Request to Supervisor', now(), NULL, NULL, NULL, NULL);

INSERT INTO cjams.routingstatustype(sequencenumber, routingstatustypekey, activeflag, typedescription, effectivedate, insertedby, updatedby, insertedon, updatedon)
VALUES(111, 'ANPRF', 1, 'Ancillary Services Payment Request to Finance Worker', now(), NULL, NULL, NULL, NULL);

INSERT INTO cjams.routingstatustype(sequencenumber, routingstatustypekey, activeflag, typedescription, effectivedate, insertedby, updatedby, insertedon, updatedon)
VALUES(112, 'ANFA', 1, 'Ancillary Services Funding Approved', now(), NULL, NULL, NULL, NULL);

INSERT INTO cjams.routingstatustype(sequencenumber, routingstatustypekey, activeflag, typedescription, effectivedate, insertedby, updatedby, insertedon, updatedon)
VALUES(113, 'ANPA', 1, 'Ancillary Services Payment Approved', now(), NULL, NULL, NULL, NULL);

-- Reference Values 
INSERT INTO cjams.referencevalues (ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon)
VALUES('ANCSU', 46, 'Ancillary Services Payment Request to Supervisor', 'Ancillary Services Payment Request to Supervisor', NULL, 1, 1, 'Admin', now(), NULL, now());

INSERT INTO cjams.referencevalues (ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon)
VALUES('ANCSFR', 46, 'Ancillary Services Funding Request to Finance worker', 'Ancillary Services Payment Request to Finance supervisor', NULL, 1, 1, 'Admin', now(), NULL, now());

INSERT INTO cjams.referencevalues (ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon)
VALUES('ANCSR', 46, 'Ancillary Services Payment Request to Finance supervisor', 'Ancillary Services Payment Request to Finance supervisor', NULL, 1, 1, 'Admin', now(), NULL, now());
