CREATE INDEX IF NOT EXISTS idx_routing_fc ON routing (objectid, insertedon DESC) WHERE eventcode = 'PLTR' AND routingstatustypeid = 70 AND activeflag = 1; 
CREATE INDEX IF NOT EXISTS idx_routing_pushdown ON routing (objectid, eventcode, fromsecurityusersid) WHERE activeflag = 1;
CREATE INDEX IF NOT EXISTS idx_routing_pushdown1 ON routing (objectid, eventcode, fromsecurityusersid, tosecurityusersid) WHERE activeflag = 1;
 
CREATE INDEX IF NOT EXISTS idx_placement_person_range ON placement(personid, startdatetime, enddatetime) WHERE activeflag=1; 
CREATE INDEX IF NOT EXISTS idx_placement_prpl ON placement (intakeservreqchildremovalid) WHERE placementtypekey='PRPL';
CREATE INDEX IF NOT EXISTS idx_placement_la ON placement (personid) WHERE placementtypekey='LA';  

CREATE INDEX IF NOT EXISTS idx_caseassignment_latest ON caseassignment (insertedon DESC) WHERE enddate IS NULL AND activeflag = 1;
CREATE INDEX IF NOT EXISTS idx_ca_obj_ins_active ON caseassignment (objectid, insertedon DESC) WHERE activeflag = 1 AND enddate IS NULL;

CREATE INDEX IF NOT EXISTS idx_tce_main ON tb_client_eligibility (eligibility_type_cd, delete_sw, start_dt, end_dt);
CREATE INDEX IF NOT EXISTS idx_tce_alerts ON tb_client_eligibility (case_id, client_id) WHERE delete_sw='N' AND eligibility_type_cd IN ('2934'); 
CREATE INDEX IF NOT EXISTS idx_tce_fc_alerts ON tb_client_eligibility (removal_id, client_id) WHERE delete_sw='N' AND eligibility_type_cd IN ('2931');
-- CREATE INDEX IF NOT EXISTS idx_tce_gap_alerts ON tb_client_eligibility (guardian_subsidy_id, client_id, eligibility_id) WHERE delete_sw = 'N' AND eligibility_type_cd IN ('2935');

CREATE INDEX IF NOT EXISTS idx_iscr_removal1 ON intakeservreqchildremoval (removalid) WHERE activeflag = 1; 
CREATE INDEX IF NOT EXISTS idx_iscr_fc_alerts ON intakeservreqchildremoval (removalid, intakeservreqchildremovalid, servicecaseid, personid) WHERE activeflag = 1 AND removaltypekey IN ('TLV','CDVP','EHA');
CREATE INDEX IF NOT EXISTS idx_iscr_actor_fast ON intakeservreqchildremoval (intakeservicerequestactorid, activeflag);
CREATE INDEX IF NOT EXISTS idx_iscr_active_removaltype ON intakeservreqchildremoval (activeflag, removaltypekey, removalid, personid, intakeservreqchildremovalid);

CREATE INDEX IF NOT EXISTS idx_tep_lookup ON tb_eligibility_period (eligibility_id, sqnm_sw, delete_sw); 
CREATE INDEX IF NOT EXISTS idx_tep_lookup1 ON tb_eligibility_period (eligibility_id, approvalstatus, sqnm_sw);