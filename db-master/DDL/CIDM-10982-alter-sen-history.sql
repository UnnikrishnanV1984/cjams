-- 01-30-2026 - Sushma Bade -- CIDM-10982 -- othersubstances in Sen history

alter table cjams.senselectiondetails add column if not exists othersubstances text NULL;
COMMENT ON COLUMN cjams.senselectiondetails.othersubstances IS 'To save the substance name when substanceclassees column is Other';

alter table cjams.senselectiondetails_history add column if not exists othersubstances text NULL;
COMMENT ON COLUMN cjams.senselectiondetails_history.othersubstances IS 'To save the substance name when substanceclassees column is Other';