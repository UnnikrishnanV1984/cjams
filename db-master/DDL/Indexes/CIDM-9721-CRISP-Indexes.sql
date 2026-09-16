/*
 -- CIDM-9721 Indexes for CRISP Job
 */
CREATE INDEX crispinboundinterface_studentno_idx ON cjams.crispinboundinterface (studentno);
CREATE INDEX crispinboundinterface_immunizationid_idx ON cjams.crispinboundinterface (immunizationid);
CREATE INDEX crispinboundinterface_iss_studentno_idx ON cjams.crispinboundinterface_iss (studentno);
CREATE INDEX crispinboundinterface_iss_immunizationid_idx ON cjams.crispinboundinterface_iss (immunizationid);
CREATE INDEX crispoutboundinterface_patientid_idx ON cjams.crispoutboundinterface (patientid);
CREATE INDEX crispoutboundinterface_iss_patientid_idx ON cjams.crispoutboundinterface_iss (patientid);
CREATE INDEX personimmunization_personid_idx ON cjams.personimmunization (personid);
CREATE INDEX personimmunization_sourcesystemprimarykey_idx ON cjams.personimmunization (sourcesystemprimarykey);