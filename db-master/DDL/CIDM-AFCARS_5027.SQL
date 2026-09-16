-------------------------------------------------------------------------------------------------------
-- 07/12/2022 Pratap P - B-125245 - ICWA Story (CIDM-5027)
------------------------------------------------------------------------------------------------------- 

ALTER TABLE cjams.person DROP COLUMN IF EXISTS lastunknownmaritalstatusupdateon;

-- COMMENT ON COLUMN cjams.person.lastunknownmaritalstatusupdateon IS 'track the last updated unknown date';
