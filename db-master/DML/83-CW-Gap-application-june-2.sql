
DROP TABLE if exists cjams.gapapplication;
CREATE TABLE cjams.gapapplication (
	gapapplicationid uuid NOT NULL DEFAULT gen_random_uuid(),
	gapid uuid NULL,
	planmeetingdate timestamp NULL,
    guardianonedate timestamp NULL,
    guardiantwodate timestamp NULL,
    ldssdirectordate timestamp NULL,   
    activeflag int4 NULL DEFAULT 1, -- Status of the record
	effectivedate timestamp NOT NULL DEFAULT now(), -- Record valid from
	insertedby varchar(50) NULL, -- User who created this record
	insertedon timestamp NOT NULL DEFAULT now(), -- Record created date and time
	updatedby varchar(50) NOT NULL, -- user who last updated the record
	updatedon timestamp NOT NULL DEFAULT now(), -- Record updated date and time
	old_id varchar(50) NULL, -- Used for migration purpose
	CONSTRAINT gapapplication_pkey PRIMARY KEY (gapapplicationid),
	CONSTRAINT fk_gapapplication_guardianship FOREIGN KEY (gapid) REFERENCES guardianship(gapid)
);


delete from routingconfig where routingconfigid in ('b92f7080-7f78-406b-abda-996beeba6c90');
INSERT INTO routingconfig
(routingconfigid, eventcode, targetrolekey, activeflag, insertedby, insertedon, updatedby, updatedon, effectivedate, expirationdate, targetteamtypekey, sourcerolekey, old_id, routingstatustypekey,principaltype)
VALUES('b92f7080-7f78-406b-abda-996beeba6c90', 'GAAP', 'CWSP', 1, 'admin', '2019-02-11 21:43:44.395', 'admin', '2019-02-11 21:43:44.395', '2019-02-11 21:43:44.395', NULL, NULL, 'CWCW', NULL, NULL,NULL);

delete from routingconfig where routingconfigid in ('b4c5dac4-f4ba-4469-aafd-b64f8558722f');
INSERT INTO routingconfig
(routingconfigid, eventcode, targetrolekey, activeflag, insertedby, insertedon, updatedby, updatedon, effectivedate, expirationdate, targetteamtypekey, sourcerolekey, old_id, routingstatustypekey,principaltype)
VALUES('b4c5dac4-f4ba-4469-aafd-b64f8558722f', 'GAAP', 'CWSP', 1, 'admin', '2019-02-11 21:43:44.395', 'admin', '2019-02-11 21:43:44.395', '2019-02-11 21:43:44.395', NULL, NULL, 'CWSP', NULL, NULL,NULL);

--select max(sequencenumber) from routingstatustype;
delete from routingstatustype where sequencenumber = 85;
INSERT INTO cjams.routingstatustype
(sequencenumber, routingstatustypekey, activeflag, typedescription, effectivedate, expirationdate, "timestamp", insertedby, updatedby, insertedon, updatedon, old_id)
VALUES(85, 'Adopreview', 1, 'Re-Review', '2018-07-03 22:40:28.232', NULL, NULL, NULL, NULL, NULL, NULL, NULL);
delete from routingstatustype where sequencenumber = 86;
INSERT INTO cjams.routingstatustype
(sequencenumber, routingstatustypekey, activeflag, typedescription, effectivedate, expirationdate, "timestamp", insertedby, updatedby, insertedon, updatedon, old_id)
VALUES(86, 'AdoApproved', 1, 'Re-Approved', '2018-07-03 22:40:28.232', NULL, NULL, NULL, NULL, NULL, NULL, NULL);
