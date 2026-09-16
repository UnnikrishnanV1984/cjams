ALTER TABLE intakeservicerequestagency ADD COLUMN IF NOT EXISTS statecountycode character varying (100);
ALTER TABLE intakeservicerequestagency ADD COLUMN IF NOT EXISTS otherresource character varying (250);
ALTER TABLE intakeservicerequestagency ADD COLUMN IF NOT EXISTS resourcetypes json;
ALTER TABLE intakeservicerequestagency ADD COLUMN IF NOT EXISTS servicerequesttypekey character varying (50);
ALTER TABLE intakeservicerequestagency  ALTER COLUMN screeningid TYPE character varying (50);
ALTER TABLE intakeservicerequestagency  ALTER COLUMN referralid TYPE character varying (50);

ALTER TABLE cjams.intakeservicerequestagency DROP CONSTRAINT IF EXISTS fk_intakeservicerequestagency_agencytype;
ALTER TABLE cjams.intakeservicerequestagency ALTER COLUMN agencyid DROP NOT NULL;


CREATE INDEX IF NOT EXISTS idx_intakeservicerequest_casetype ON intakeservicerequest(teamtypekey,activeflag,isdraft,actiontype,servicerequestnumber);
CREATE INDEX IF NOT EXISTS idx_intakeservicerequestactor_person ON intakeservicerequestactor(intakeserviceid,activeflag,isheadofhousehold,personid,actorid);
CREATE INDEX IF NOT EXISTS idx_routing_worker ON routing(objectid,eventcode,routingstatustypeid,activeflag);





