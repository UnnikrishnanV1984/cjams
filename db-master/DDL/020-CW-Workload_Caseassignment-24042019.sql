ALTER TABLE caseassignment 
ADD COLUMN IF NOT EXISTS activeflag int4 DEFAULT 1,
ADD COLUMN IF NOT EXISTS startdate timestamp without time zone,
ADD COLUMN IF NOT EXISTS enddate timestamp without time zone,
ADD COLUMN IF NOT EXISTS fromteamid uuid,
ADD COLUMN IF NOT EXISTS toteamid uuid,
ADD COLUMN IF NOT EXISTS fromcountycode character varying(10),
ADD COLUMN IF NOT EXISTS tocountycode character varying(10),
ADD COLUMN IF NOT EXISTS remarks character varying(250),
ADD COLUMN IF NOT EXISTS statustypekey character varying(50);

ALTER TYPE getdsdsactionsummarydtls_type DROP ATTRIBUTE IF EXISTS  servicecasenumber;
ALTER TYPE getdsdsactionsummarydtls_type DROP ATTRIBUTE IF EXISTS   teamid;
ALTER TYPE getdsdsactionsummarydtls_type DROP ATTRIBUTE IF EXISTS   servicecaseid;

ALTER TYPE getdsdsactionsummarydtls_type ADD ATTRIBUTE servicecasenumber character varying(15); 
ALTER TYPE getdsdsactionsummarydtls_type ADD ATTRIBUTE teamid uuid; 
 ALTER TYPE getdsdsactionsummarydtls_type ADD ATTRIBUTE servicecaseid uuid; 

ALTER TABLE Caseassignment ADD COLUMN IF NOT EXISTS fromldssid uuid;
ALTER TABLE Caseassignment ADD COLUMN IF NOT EXISTS toldssid uuid;

ALTER TABLE cjams.caseassignment DROP COLUMN IF EXISTS fromcountycode;
ALTER TABLE cjams.caseassignment DROP COLUMN IF EXISTS tocountycode;



DROP FUNCTION IF EXISTS cjams.getworkloadassignments(character varying, character varying, uuid, character varying, character varying, integer);

DROP FUNCTION IF EXISTS cjams.getworkloadassignments(character varying, character varying, uuid, character varying, character varying, integer, date, date, integer, integer);