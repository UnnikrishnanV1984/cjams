--Near-Death/Serious Physical Injury as part of 1080 refinement
ALTER TABLE cjams.intakeservicerequestsdm ADD column if not exists isseriousphysicalinjury bool NULL;
COMMENT ON COLUMN cjams.intakeservicerequestsdm.isseriousphysicalinjury IS 'to store Near-Death/Serious Physical Injury';