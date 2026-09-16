--------------------------------------
--Revision(s)
-- 02/06/2024 - CIDM-10020 - User story Added the swtichfor househould to sort the persons in actor table
-----------------------------------------
ALTER TABLE cjams.actor 
ADD COLUMN if not exists householdswitch varchar (50);
COMMENT ON COLUMN cjams.actor.householdswitch IS 'To get the household status';