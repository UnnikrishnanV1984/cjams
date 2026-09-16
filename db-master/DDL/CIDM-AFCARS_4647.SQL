-------------------------------------------------------------------------------------------------------
-- 05/31/2022 Mounika Gudise - B-125245 AFCARS 2.0 - ICWA Story (CIDM-4647)
------------------------------------------------------------------------------------------------------- 

ALTER TABLE cjams.person ADD COLUMN IF NOT EXISTS icwastatusinquiry character  varying(10);
ALTER TABLE cjams.person ADD COLUMN IF NOT EXISTS icwaeligibleformembership character varying(10);
ALTER TABLE cjams.person ADD COLUMN IF NOT EXISTS icwatribename character varying;
ALTER TABLE cjams.person ADD COLUMN IF NOT EXISTS icwaunderdefinition character  varying(10);
ALTER TABLE cjams.person ADD COLUMN IF NOT EXISTS icwanotification date;
ALTER TABLE cjams.person ADD COLUMN IF NOT EXISTS icwatribelegalnotice character  varying(10);