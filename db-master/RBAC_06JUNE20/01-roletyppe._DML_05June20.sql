update roletype set activeflag = 0 , updatedon = now(), updatedby = 'Rbac' where roletypecode in ('SU','PR', 'SW', 'PW', 'CSP', 'CD', 'PD', 'QAS', 'OIGS', 'DOIG', 'SOD', 'ED', 'DD', 'PM', 'LA', 'QA', 'DSS', 'KN', 'KA', 'CLW', 'IVEW', 'KS', 'KW', 'MHCP','PHCP', 'UW', 'RC', 'RTC', 'FU', 'RTS', 'PA', 'FSW' , 'PSA', 'DU', 'DF', 'LDSSDD', 'LDSSSP','LDSSRT' , 'LDSSRW', 'LDSSHSW', 'PVDJSR', 'PVDJSRS', 'PVDJSQA', 'PVDJSPD', 'PVDJSSD', 'SA', 'DHSLA');

update role set activeflag = 0, updatedby = 'Rbac', updatedon = now() where openamrole is null;

update role set activeflag = 0, updatedby = 'Rbac', updatedon = now() where id in (73,302,34,69,77,70,107,98,701,53,112,217,109,108,111,1400,40,301,100,685,1054);

INSERT INTO cjams.roletype
(roletypecode, roletypename, shortname, activeflag, effectivedate, expirationdate, insertedby, updatedby, insertedon, updatedon, old_id)
VALUES('PCMC', 'Program Coordinator Manager Chief', 'PCMC', 1, now(), NULL, 'Rbac', 'Rbac', now(), now(), NULL);

INSERT INTO cjams.roletype
(roletypecode, roletypename, shortname, activeflag, effectivedate, expirationdate, insertedby, updatedby, insertedon, updatedon, old_id)
VALUES('AAMC', 'Admin Audit Monitor CQI', 'AAMC', 1, now(), NULL, 'Rbac', 'Rbac', now(), now(), NULL);

INSERT INTO cjams.roletype
(roletypecode, roletypename, shortname, activeflag, effectivedate, expirationdate, insertedby, updatedby, insertedon, updatedon, old_id)
VALUES('SPPRC', 'State Private Provider Rates Contracting', 'SPPRC', 1, now(), NULL, 'Rbac', 'Rbac', now(), now(), NULL);

INSERT INTO cjams.roletype
(roletypecode, roletypename, shortname, activeflag, effectivedate, expirationdate, insertedby, updatedby, insertedon, updatedon, old_id)
VALUES('ICPC', 'ICPC-ICAMA', 'ICPC', 1, now(), NULL, 'Rbac', 'Rbac', now(), now(), NULL);

INSERT INTO cjams.roletype
(roletypecode, roletypename, shortname, activeflag, effectivedate, expirationdate, insertedby, updatedby, insertedon, updatedon, old_id)
VALUES('CRBFC', 'Citizens Review Board for Children', 'CRBFC', 1, now(), NULL, 'Rbac', 'Rbac', now(), now(), NULL);

INSERT INTO cjams.roletype
(roletypecode, roletypename, shortname, activeflag, effectivedate, expirationdate, insertedby, updatedby, insertedon, updatedon, old_id)
VALUES('LRAA', 'Legal Rep-Agency Attorney', 'LRAA', 1, now(), NULL, 'Rbac', 'Rbac', now(), now(), NULL);

INSERT INTO cjams.roletype
(roletypecode, roletypename, shortname, activeflag, effectivedate, expirationdate, insertedby, updatedby, insertedon, updatedon, old_id)
VALUES('PSS', 'Professional Service Staff', 'PSS', 1, now(), NULL, 'Rbac', 'Rbac', now(), now(), NULL);

INSERT INTO cjams.roletype
(roletypecode, roletypename, shortname, activeflag, effectivedate, expirationdate, insertedby, updatedby, insertedon, updatedon, old_id)
VALUES('ILC', 'Independent Living Coordinator', 'ILC', 1, now(), NULL, 'Rbac', 'Rbac', now(), now(), NULL);

INSERT INTO cjams.roletype
(roletypecode, roletypename, shortname, activeflag, effectivedate, expirationdate, insertedby, updatedby, insertedon, updatedon, old_id)
VALUES('CPSCS', 'CPS Clearance Staff', 'CPSCS', 1, now(), NULL, 'Rbac', 'Rbac', now(), now(), NULL);


INSERT INTO cjams.roletype
(roletypecode, roletypename, shortname, activeflag, effectivedate, expirationdate, insertedby, updatedby, insertedon, updatedon, old_id)
VALUES('OFCA', 'Office Administrator', 'OFCA', 1, now(), NULL, 'Rbac', 'Rbac', now(), now(), NULL);

INSERT INTO cjams.roletype
(roletypecode, roletypename, shortname, activeflag, effectivedate, expirationdate, insertedby, updatedby, insertedon, updatedon, old_id)
VALUES('CMSP', 'Case Management Specialist', 'CMSP', 1, now(), NULL, 'Rbac', 'Rbac', now(), now(), NULL);

INSERT INTO cjams.roletype
(roletypecode, roletypename, shortname, activeflag, effectivedate, expirationdate, insertedby, updatedby, insertedon, updatedon, old_id)
VALUES('CMSV', 'Case Management Supervisor', 'CMSV', 1, now(), NULL, 'Rbac', 'Rbac', now(), now(), NULL);

INSERT INTO cjams.roletype
(roletypecode, roletypename, shortname, activeflag, effectivedate, expirationdate, insertedby, updatedby, insertedon, updatedon, old_id)
VALUES('EXE', 'Executive', 'EXE', 1, now(), NULL, 'Rbac', 'Rbac', now(), now(), NULL);

INSERT INTO cjams.roletype
(roletypecode, roletypename, shortname, activeflag, effectivedate, expirationdate, insertedby, updatedby, insertedon, updatedon, old_id)
VALUES('MSP', 'Medical Specialist', 'MSP', 1, now(), NULL, 'Rbac', 'Rbac', now(), now(), NULL);

INSERT INTO cjams.roletype
(roletypecode, roletypename, shortname, activeflag, effectivedate, expirationdate, insertedby, updatedby, insertedon, updatedon, old_id)
VALUES('RSP', 'Resource Specialist', 'RSP', 1, now(), NULL, 'Rbac', 'Rbac', now(), now(), NULL);

INSERT INTO cjams.roletype
(roletypecode, roletypename, shortname, activeflag, effectivedate, expirationdate, insertedby, updatedby, insertedon, updatedon, old_id)
VALUES('LMSP', 'License & Monitoring Specialist', 'LMSP', 1, now(), NULL, 'Rbac', 'Rbac', now(), now(), NULL);

INSERT INTO cjams.roletype
(roletypecode, roletypename, shortname, activeflag, effectivedate, expirationdate, insertedby, updatedby, insertedon, updatedon, old_id)
VALUES('EXA', 'External Agency', 'EXA', 1, now(), NULL, 'Rbac', 'Rbac', now(), now(), NULL);

INSERT INTO cjams.roletype
(roletypecode, roletypename, shortname, activeflag, effectivedate, expirationdate, insertedby, updatedby, insertedon, updatedon, old_id)
VALUES('ITA', 'IT Administrator', 'ITA', 1, now(), NULL, 'Rbac', 'Rbac', now(), now(), NULL);

INSERT INTO cjams.roletype
(roletypecode, roletypename, shortname, activeflag, effectivedate, expirationdate, insertedby, updatedby, insertedon, updatedon, old_id)
VALUES('IVEEA', 'IV-E Eligibility Analyst', 'IVEEA', 1, now(), NULL, 'Rbac', 'Rbac', now(), now(), NULL);

INSERT INTO cjams.roletype
(roletypecode, roletypename, shortname, activeflag, effectivedate, expirationdate, insertedby, updatedby, insertedon, updatedon, old_id)
VALUES('IVEQA', 'IV-E Eligibility Quality Assurance', 'IVEQA', 1, now(), NULL, 'Rbac', 'Rbac', now(), now(), NULL);

INSERT INTO cjams.roletype
(roletypecode, roletypename, shortname, activeflag, effectivedate, expirationdate, insertedby, updatedby, insertedon, updatedon, old_id)
VALUES('IVEAD', 'IV-E Eligibility Administrator', 'IVEADM', 1, now(), NULL, 'Rbac', 'Rbac', now(), now(), NULL);

INSERT INTO cjams.roletype
(roletypecode, roletypename, shortname, activeflag, effectivedate, expirationdate, insertedby, updatedby, insertedon, updatedon, old_id)
VALUES('IVEAA', 'IV-E Eligibility Administrator Assistant', 'IVEADMA', 1, now(), NULL, 'Rbac', 'Rbac', now(), now(), NULL);

INSERT INTO cjams.roletype
(roletypecode, roletypename, shortname, activeflag, effectivedate, expirationdate, insertedby, updatedby, insertedon, updatedon, old_id)
VALUES('IVELI', 'IV-E Liaison', 'IVELIA', 1, now(), NULL, 'Rbac', 'Rbac', now(), now(), NULL);

INSERT INTO cjams.roletype
(roletypecode, roletypename, shortname, activeflag, effectivedate, expirationdate, insertedby, updatedby, insertedon, updatedon, old_id)
VALUES('LC', 'Licensing Coordinator', 'LC', 1, now(), NULL, 'Rbac', 'Rbac', now(), now(), NULL);

INSERT INTO cjams.roletype
(roletypecode, roletypename, shortname, activeflag, effectivedate, expirationdate, insertedby, updatedby, insertedon, updatedon, old_id)
VALUES('QAC', 'QA Coordinator', 'QAC', 1, now(), NULL, 'Rbac', 'Rbac', now(), now(), NULL);
