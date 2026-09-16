 ALTER TABLE cjams.intakeservicerequestsdm
  ADD COLUMN IF NOT EXISTS ismalpa_labortrafficking boolean NULL;

-- comments
COMMENT ON COLUMN cjams.intakeservicerequestsdm.ismalpa_labortrafficking
  IS 'To capture suspected/identified Labor Trafficking indicator for MALPA/SDM screening';


  ALTER TABLE cjams.intakeservicerequestsdm
ADD COLUMN IF NOT EXISTS islabortrafficking bool NULL DEFAULT false;

-- comments
COMMENT ON COLUMN cjams.intakeservicerequestsdm.islabortrafficking
IS 'Labor Trafficking flag'; 