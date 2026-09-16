
/*
-- Issue Description: 
	User Request to Request to restrict Intake I251013272458
	
-- Category/ Module: Intake Referral (Intake Management) 
-- Root cause: TBD
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/
-- Intake Number: I251013272458 (INTAKE)
/*
Approved Access:
Corine Mullings - corine.mullings@maryland.gov--8e1e4591-f441-4732-84af-817d2b87121b
Stephanie Cooke - stephanie.cooke1@maryland.gov--3101f5ad-e192-45d1-9ea3-5e268508f6d9
Emily Harris - emily.harris1@maryland.gov--9dde2129-8df2-4a17-bb06-d25de09f530d
Robin Akehurst - robin.akehurst@maryland.gov--4d1dfcc6-5bbb-44c7-898a-a399f1229278

*/
--I251013272458 
--8e1e4591-f441-4732-84af-817d2b87121b	Corine	Mullings	Corine Mullings	Corine Mullings
INSERT INTO cjams.restricteditems
      (restricteditemsid, objecttypekey, objectid, accessuserid, description, isadd, isedit, isdelete, insertedby, updatedby, insertedon, updatedon, activeflag, roletypekey)
VALUES(gen_random_uuid(), 'INTAKE', 'I251013272458', '8e1e4591-f441-4732-84af-817d2b87121b', NULL, false, false, false, 'CJAMS-59398', 'CJAMS-59398', now(), now(), 1,'CWIW');

--3101f5ad-e192-45d1-9ea3-5e268508f6d9	Stephanie	Cooke	StephanieCooke	Stephanie Cooke
INSERT INTO cjams.restricteditems
(restricteditemsid, objecttypekey, objectid, accessuserid, description, isadd, isedit, isdelete, insertedby, updatedby, insertedon, updatedon, activeflag, roletypekey)
VALUES(gen_random_uuid(), 'INTAKE', 'I251013272458', '3101f5ad-e192-45d1-9ea3-5e268508f6d9', NULL, false, false, false, 'CJAMS-59398', 'CJAMS-59398', now(), now(), 1, 'CWIW');
--9dde2129-8df2-4a17-bb06-d25de09f530d	Emily	Harris	EmilyHarris	Emily Harris
INSERT INTO cjams.restricteditems
      (restricteditemsid, objecttypekey, objectid, accessuserid, description, isadd, isedit, isdelete, insertedby, updatedby, insertedon, updatedon, activeflag, roletypekey)
VALUES(gen_random_uuid(), 'INTAKE', 'I251013272458', '9dde2129-8df2-4a17-bb06-d25de09f530d', NULL, false, false, false, 'CJAMS-59398', 'CJAMS-59398', now(), now(), 1,'CWIW');

--4d1dfcc6-5bbb-44c7-898a-a399f1229278	Robin	Akehurst Dusza	RobinAkehurst Dusza	Robin Akehurst-Dusza
INSERT INTO cjams.restricteditems
      (restricteditemsid, objecttypekey, objectid, accessuserid, description, isadd, isedit, isdelete, insertedby, updatedby, insertedon, updatedon, activeflag, roletypekey)
VALUES(gen_random_uuid(), 'INTAKE', 'I251013272458', '4d1dfcc6-5bbb-44c7-898a-a399f1229278', NULL, false, false, false, 'CJAMS-59398', 'CJAMS-59398', now(), now(), 1,'CWIW');


