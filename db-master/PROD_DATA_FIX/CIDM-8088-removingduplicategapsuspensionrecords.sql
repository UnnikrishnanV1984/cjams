/*
   Issue Description: CIDM-8088 -Deactivate Duplicate gap suspension
   Category/ Module  :  GAP
   Root cause: User doesnt have central policy staff role, change done in sailpoint 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

--INSERT INTO cjams.gapsuspension
--(gapsuspensionid, gapid, suspensionreasontypekey, startdate, enddate, notes, isdraft, suspensiondesc, activeflag, effectivedate, insertedby, insertedon, updatedby, updatedon, old_id, otherreason, alternateid, approvalstatustypekey, etl_userid, etl_load_date)
--VALUES('9918d292-fe8e-488d-bc8d-bc44810e2652', '47839abf-f4f1-4b8f-aea6-56102fb6496d', 'COHP', NULL, NULL, 'System generated suspension', 0, 'Suspended due to active removal (system generated)', 0, '2023-09-25 00:00:00.000', 'c078eed8-fab6-490d-b099-47f9b968a5dc', '2023-10-19 15:04:06.866', 'c078eed8-fab6-490d-b099-47f9b968a5dc', '2023-10-19 15:04:06.866', NULL, NULL, 1012369, '3047', NULL, NULL);

DELETE FROM cjams.gapsuspension
WHERE gapsuspensionid='9918d292-fe8e-488d-bc8d-bc44810e2652';

update cjams.gapsuspension set activeflag = 1, updatedby = 'CIDM-8088', updatedon = now()
where gapsuspensionid = '01ad6f6c-8804-41b4-9606-bb6e8f13b7aa' and activeflag = 0;


update cjams.gapsuspensionrevision set activeflag = 1, updatedby = 'CIDM-8088', updatedon = now()
where suspensionid = '01ad6f6c-8804-41b4-9606-bb6e8f13b7aa' and activeflag = 0;



update routing set activeflag = 0, updatedby = 'CIDM-8088', updatedon = now()
where  objectid = '9918d292-fe8e-488d-bc8d-bc44810e2652' and activeflag = 1 and routingid = 'ea37a589-8038-4caa-819a-498e5742fc22' ;
			 
update routing set activeflag = 1, updatedby = 'CIDM-8088', updatedon = now()
where  objectid = '01ad6f6c-8804-41b4-9606-bb6e8f13b7aa' and activeflag = 0 and routingid = '7f051767-8be3-4cdf-8870-276caba90b6f';