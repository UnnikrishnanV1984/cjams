--Index addtion CIDM-7315
CREATE INDEX muser_securityusersid ON cjams.muser USING btree(securityusersid);
create index Xie1_intakeservreqcourtorder on intakeservreqcourtorder(servicecaseid,activeflag);
create index Xie1_Intakeservreqcohearingoutcome on Intakeservreqcohearingoutcome(intakeservreqcourtorderid,activeflag);
CREATE INDEX assessment_servicecaseid_idx ON cjams.assessment USING btree (servicecaseid);
