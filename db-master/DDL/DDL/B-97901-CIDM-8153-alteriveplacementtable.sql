------------------------------------------------------------------
-- B-97901 CIDM-8153 11-13 CJAMS-CW-IV-E - SILA youth and placement updates
-----------------------------------------------------------------


ALTER TABLE tb_foster_care_placement ADD COLUMN IF NOT EXISTS silaplacementchange json null;
COMMENT ON COLUMN tb_foster_care_placement.silaplacementchange IS 'To save placement details changed by the user';


ALTER TABLE cjams.ivessissadata ADD column if not exists homeassessmentverification varchar(250) NULL;
COMMENT ON COLUMN ivessissadata.homeassessmentverification IS 'home assessment -How verified comment box in  IV-E screen (Other Criteria tab)  for 18-21 youth case ';