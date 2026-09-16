-------------------------------------------------------------------------------------------------------
-- 04/29/2025 Charan sai Bodapati - B-246459 EBP short term fix Story (CIDM-10366)
------------------------------------------------------------------------------------------------------- 
ALTER TABLE cjams.splangoal ADD COLUMN IF NOT EXISTS autoflag int4 NULL;
COMMENT ON COLUMN cjams.splangoal.autoflag IS 'Indicates if the goal was auto-inserted. 1 for auto, 0 for manual.';

ALTER TABLE cjams.splanobjective ADD COLUMN IF NOT EXISTS autoflag int4 NULL;
COMMENT ON COLUMN cjams.splanobjective.autoflag IS 'Indicates if the objective was auto-inserted. 1 for auto, 0 for manual.';

ALTER TABLE cjams.serviceplanaction ADD COLUMN IF NOT EXISTS autoflag int4 NULL;
COMMENT ON COLUMN cjams.serviceplanaction.autoflag IS 'Indicates if the action was auto-inserted. 1 for auto, 0 for manual.';