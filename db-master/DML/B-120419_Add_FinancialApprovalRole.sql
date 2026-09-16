
		
INSERT INTO cjams.teammemberroletype
( roletypekey, activeflag, description, teamtypekey, isroutable, insertedby, insertedon, updatedby, updatedon, effectivedate, expirationdate, "timestamp", isupervisor, old_id, rolelevel)
VALUES( 'CWDIR1KAPR', 1, 'CW Director Approver', 'CW', true, 'ADMIN', '2021-01-25 12:48:40.787', 'ADMIN', '2021-01-25 12:48:40.787', '2021-01-25 12:48:40.787', NULL, NULL, true, NULL, 1);

INSERT INTO cjams.teammemberroletype
( roletypekey, activeflag, description, teamtypekey, isroutable, insertedby, insertedon, updatedby, updatedon, effectivedate, expirationdate, "timestamp", isupervisor, old_id, rolelevel)
VALUES( 'ASDIR1KAPR', 1, 'AS Director Approver', 'AS', true, 'ADMIN', '2021-01-25 12:48:40.787', 'ADMIN', '2021-01-25 12:48:40.787', '2021-01-25 12:48:40.787', NULL, NULL, true, NULL, 1);

INSERT INTO "role" (id,"name",description,created,modified,activeflag,insertedby,updatedby,insertedon,updatedon,roletypekey,old_id,openamrole) VALUES
	 (5984,'Director Approval','Director Approval, CW',NULL,NULL,1,'Admin','admin','2021-07-26 09:59:04.797','2021-08-04 13:35:28.323','CWDIR1KAPR',NULL,'CJAMS_CW_SERVICELOG_APPT_GT_1K');
	 
INSERT INTO "role" (id,"name",description,created,modified,activeflag,insertedby,updatedby,insertedon,updatedon,roletypekey,old_id,openamrole) VALUES
	 (5983,'Director Approval','Director Approval, AS',NULL,NULL,1,'Admin','admin','2021-07-26 09:59:04.798','2021-08-04 13:35:28.323','ASDIR1KAPR',NULL,'CJAMS_AS_SERVICELOG_APPT_GT_1K');

