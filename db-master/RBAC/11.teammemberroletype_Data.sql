INSERT INTO cjams.teammemberroletype
(sequencenumber, roletypekey, activeflag, description, teamtypekey, isroutable, insertedby, insertedon, updatedby, updatedon, effectivedate, isupervisor)
VALUES(375, 'CWKN', 1, 'Kinship Navigator,CW', 'CW', true, 'admin', now(), 'admin', NULL, now(), false) on conflict ON constraint pk_areateammemberroletype do nothing;

INSERT INTO cjams.teammemberroletype
(sequencenumber, roletypekey, activeflag, description, teamtypekey, isroutable, insertedby, insertedon, updatedby, updatedon, effectivedate, isupervisor)
VALUES(376, 'CWKA', 1, 'Kinship Approver,CW', 'CW', true, 'admin', now(), 'admin', NULL, now(), false) on conflict ON constraint pk_areateammemberroletype do nothing;

INSERT INTO cjams.teammemberroletype
(sequencenumber, roletypekey, activeflag, description, teamtypekey, isroutable, insertedby, insertedon, updatedby, updatedon, effectivedate, isupervisor)
VALUES(377, 'CWCLW', 1, 'Court Liaison Worker,CW', 'CW', true, 'admin', now(), 'admin', NULL, now(), false) on conflict ON constraint pk_areateammemberroletype do nothing;

INSERT INTO cjams.teammemberroletype
(sequencenumber, roletypekey, activeflag, description, teamtypekey, isroutable, insertedby, insertedon, updatedby, updatedon, effectivedate, isupervisor)
VALUES(378, 'OLMLA', 1, 'Licensing Administrator,OLM', 'OLM', true, 'admin', now(), 'admin', NULL, now(), false) on conflict ON constraint pk_areateammemberroletype do nothing;

INSERT INTO cjams.teammemberroletype
(sequencenumber, roletypekey, activeflag, description, teamtypekey, isroutable, insertedby, insertedon, updatedby, updatedon, effectivedate, isupervisor)
VALUES(379, 'OLMED', 1, 'Executive Director,OLM', 'OLM', true, 'admin', now(), 'admin', NULL, now(), false) on conflict ON constraint pk_areateammemberroletype do nothing;

INSERT INTO cjams.teammemberroletype
(sequencenumber, roletypekey, activeflag, description, teamtypekey, isroutable, insertedby, insertedon, updatedby, updatedon, effectivedate, isupervisor)
VALUES(380, 'OLMDD', 1, 'Deputy Director,OLM', 'OLM', true, 'admin', now(), 'admin', NULL, now(), false) on conflict ON constraint pk_areateammemberroletype do nothing;

INSERT INTO cjams.teammemberroletype
(sequencenumber, roletypekey, activeflag, description, teamtypekey, isroutable, insertedby, insertedon, updatedby, updatedon, effectivedate, isupervisor)
VALUES(381, 'DJSVE', 1, 'IV-E Worker,DJS', 'DJS', true, 'admin', now(), 'admin', NULL, now(), false) on conflict ON constraint pk_areateammemberroletype do nothing;

INSERT INTO cjams.teammemberroletype
(sequencenumber, roletypekey, activeflag, description, teamtypekey, isroutable, insertedby, insertedon, updatedby, updatedon, effectivedate, isupervisor)
VALUES(382, 'CWKW', 1, 'Kinship Intake Worker,CW', 'CW', true, 'admin', now(), 'admin', NULL, now(), false) on conflict ON constraint pk_areateammemberroletype do nothing;





update roletype set shortname ='LDSS_DIRECTOR' where roletypecode ='LDSSDD';
update roletype set shortname ='LDSS_SUPERVISOR' where roletypecode ='LDSSSP';
update roletype set shortname ='LDSS_RESOURCE_WORKER' where roletypecode ='LDSSRW';
update roletype set shortname ='LDSS_HOMESTUDY_WORKER' where roletypecode ='LDSSHSW';
update roletype set shortname ='LDSS_RECRUITER_TRAINER' where roletypecode ='LDSSRT';