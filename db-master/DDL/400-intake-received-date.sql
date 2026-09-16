ALTER TABLE cjams.intakeservicerequest ADD intakedaterecieved timestamp NULL;
COMMENT ON COLUMN cjams.intakeservicerequest.intakedaterecieved IS 'Intake received date to be used only for new cjams application intakes';
