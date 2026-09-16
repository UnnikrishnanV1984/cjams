-- CIDM-9998 To add SEN case (Risk of Harm only) to the NCANDS submission (CIDM-????)
-- Modifiy ncands_child_data & tb_ncands_elements to add Element 151 & 152

ALTER TABLE cjams.ncands_child_data ADD COLUMN IF NOT EXISTS sencase integer NULL;
COMMENT ON COLUMN cjams.ncands_child_data.sencase IS 'Flag to identify the SEN case data'; 

CREATE INDEX ncands_child_data_idx_RPTID ON cjams.ncands_child_data USING btree (RPTID);
CREATE INDEX ncands_child_data_idx_CHID ON cjams.ncands_child_data USING btree (CHID);

CREATE INDEX ncands_maltreator_info_idx_RPTID ON cjams.ncands_maltreator_info USING btree (RPTID);
CREATE INDEX ncands_maltreator_info_idx_CHID ON cjams.ncands_maltreator_info USING btree (CHID);

CREATE INDEX ncands_childrisk_idx_RPTID ON cjams.ncands_childrisk USING btree (RPTID);
CREATE index ncands_childrisk_idx_CHID ON cjams.ncands_childrisk USING btree (CHID);

CREATE INDEX ncands_caregiver_idx_RPTID ON cjams.ncands_caregiver USING btree (RPTID);
CREATE index ncands_caregiver_idx_CHID ON cjams.ncands_caregiver USING btree (CHID);

CREATE INDEX ncands_services_idx_RPTID ON cjams.ncands_services USING btree (RPTID);
CREATE index ncands_services_idx_CHID ON cjams.ncands_services USING btree (CHID);

CREATE INDEX ncands_work_perp_idx_RPTID ON cjams.ncands_work_perp USING btree (RPTID);
CREATE index ncands_work_perp_idx_CHID ON cjams.ncands_work_perp USING btree (CHID);


