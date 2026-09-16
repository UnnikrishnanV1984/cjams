ALTER TABLE cjams.tprdetails ADD COLUMN IF NOT EXISTS intakeservreqcourtorderid uuid;
COMMENT ON COLUMN cjams.tprdetails.intakeservreqcourtorderid IS 'Court Order information';

ALTER TABLE cjams.tprdetails ADD COLUMN IF NOT EXISTS tprpetitiondate timestamp NULL;
COMMENT ON COLUMN cjams.tprdetails.tprpetitiondate IS 'TPR Petitiondate';



alter table cjams.tprdetails drop column if exists iscontested;

ALTER TABLE cjams.tprdetails ADD COLUMN IF NOT EXISTS iscontested boolean NULL;
COMMENT ON COLUMN cjams.tprdetails.iscontested IS 'TPR Contested';

