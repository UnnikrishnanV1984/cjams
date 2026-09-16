CREATE INDEX IF NOT EXISTS indx_placement_childremoveid 
ON placement 
USING btree (intakeservreqchildremovalid,startdatetime);