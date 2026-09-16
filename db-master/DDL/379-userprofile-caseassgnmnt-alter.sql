ALTER TABLE userprofile ADD COLUMN IF NOT EXISTS entrydate timestamp without time zone ;
COMMENT ON COLUMN userprofile.entrydate IS 'Date when user profile entry';
ALTER TABLE userprofile ADD COLUMN IF NOT EXISTS exitdate timestamp without time zone;
COMMENT ON COLUMN userprofile.exitdate IS 'Date when user profile exit';
ALTER TABLE userprofile ADD COLUMN IF NOT EXISTS primarycountycd character varying(50);
COMMENT ON COLUMN userprofile.primarycountycd IS 'Primary county code';
ALTER TABLE userprofile ADD COLUMN IF NOT EXISTS primaryteamid uuid;
COMMENT ON COLUMN userprofile.primaryteamid IS 'Primary team id';
ALTER TABLE userprofile ADD COLUMN IF NOT EXISTS primarylocationid uuid;
COMMENT ON COLUMN userprofile.primarylocationid IS 'Primary location id';
ALTER TABLE userprofile ADD COLUMN IF NOT EXISTS secondarylocationid uuid;
COMMENT ON COLUMN userprofile.secondarylocationid IS 'Secondary location id'; 
ALTER TABLE userprofile ADD COLUMN IF NOT EXISTS jobtitlecd character varying (50);
ALTER TABLE userprofile ADD COLUMN IF NOT EXISTS unitsupervisorid character varying (50);

ALTER TABLE ldsslocations DROP COLUMN IF EXISTS regiontypekey;
ALTER TABLE ldsslocations ADD COLUMN IF NOT EXISTS regioncd character varying (25);
ALTER TABLE ldsslocations DROP COLUMN IF EXISTS countytypekey;
ALTER TABLE ldsslocations ADD COLUMN IF NOT EXISTS countycd character varying (25);
COMMENT ON COLUMN ldsslocations.regioncd IS 'region code';
COMMENT ON COLUMN ldsslocations.countycd IS 'County code';
ALTER TABLE ldsslocations ALTER COLUMN insertedby TYPE character varying(50);
ALTER TABLE ldsslocations ALTER COLUMN updatedby TYPE character varying(50);


ALTER TABLE ldsslocations ALTER COLUMN ldsslocationid SET DEFAULT gen_random_uuid();

ALTER TABLE caseassignment ADD COLUMN IF NOT EXISTS assigndate timestamp without time zone;
ALTER TABLE caseassignment ADD COLUMN IF NOT EXISTS isrestricted integer;
ALTER TABLE caseassignment ADD COLUMN IF NOT EXISTS assigndescription character varying(100);
ALTER TABLE caseassignment ADD COLUMN IF NOT EXISTS summary character varying(250);
ALTER TABLE caseassignment ADD COLUMN IF NOT EXISTS isnew integer;
ALTER TABLE caseassignment ADD COLUMN IF NOT EXISTS expungementflag integer;
ALTER TABLE caseassignment ADD COLUMN IF NOT EXISTS entityopendate timestamp without time zone;


DROP INDEX IF EXISTS idx_routing_tosecurityusersid_objectid;
DROP INDEX IF EXISTS idx_caseassignment_toworkeridno_objectid;
DROP INDEX IF EXISTS idx_caseassignment_toworkeridno_objectid1;
DROP INDEX IF EXISTS idx_servicecase_servicecaseid;
DROP INDEX IF EXISTS idx_routing_tosecurityusersid;
DROP INDEX IF EXISTS idx_submissioncollection_datakey1;
DROP INDEX IF EXISTS idx_submissioncollection_datakey;

CREATE INDEX idx_routing_tosecurityusersid_objectid ON routing (objectid, tosecurityusersid);
CREATE INDEX idx_caseassignment_toworkeridno_objectid ON caseassignment (objectid, toworkeridno, enddate);
CREATE INDEX idx_caseassignment_toworkeridno_objectid1 ON caseassignment (objectid, toworkeridno);
CREATE INDEX idx_servicecase_servicecaseid ON servicecase (servicecaseid);
CREATE INDEX idx_routing_tosecurityusersid ON routing (tosecurityusersid);
CREATE INDEX idx_submissioncollection_datakey1 ON submissioncollection (datakey);
CREATE INDEX idx_submissioncollection_datakey ON submissioncollection (assessmentsubmissionid,datakey,dataindex);