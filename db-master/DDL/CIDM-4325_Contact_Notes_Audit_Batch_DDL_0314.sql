-- CJAMS Daily Contact Notes Counts and basic Info (CIDM-4325)

-- Add Column progressnoteid in cjams.progressnote_audit_detail (PK of progressnote table)

Alter table cjams.progressnote_audit_detail add column if not exists progressnoteid uuid;

-- Add Indexes

CREATE INDEX progressnote_detl_conatctid_idx ON cjams.progressnote_audit_detail USING btree (conatctid);
CREATE INDEX progressnote_detl_progressnoteid_idx ON cjams.progressnote_audit_detail USING btree (progressnoteid);

CREATE INDEX progressnote_witsid_idx ON cjams.progressnote USING btree (witsid);

