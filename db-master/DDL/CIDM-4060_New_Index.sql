-- Modifications for CJAMS - Performance Issue (CIDM-4060)
-- of gethearingdetails_v2($1, $2)

-- To Add Index on hearingclients table --> column courthearingid

Drop INDEX if exists indx_hearingclients_courthearingid;

CREATE INDEX indx_hearingclients_courthearingid ON cjams.hearingclients USING btree (courthearingid);
