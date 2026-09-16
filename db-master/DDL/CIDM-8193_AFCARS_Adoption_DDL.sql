-- CIDM-8193 - AFCARS  2.0 Adoption mod to add GAP cases
-- Modify afcarsadoptiondetail to new column to identify Adoption or GAP case

ALTER TABLE cjams.afcarsadoptiondetail ADD COLUMN IF NOT EXISTS adoption_gap_casetype character varying NULL;
COMMENT ON COLUMN cjams.afcarsadoptiondetail.adoption_gap_casetype IS 'Column to Identify Case Type : Adoption or GAP'; 
