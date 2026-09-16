/*
   Issue Description: CIDM-4942 AFCARS Sex Trafficking User Story
   Category/ Module  : Substance Use in Person Tab
    Name: Shamili Kallu on 07/27/2022
*/

ALTER TABLE cjams.personabusesubstance ADD COLUMN IF NOT EXISTS ischildhassextraffichistory boolean;

ALTER TABLE cjams.personabusesubstance ADD COLUMN IF NOT EXISTS issextraffichistoryreported boolean;

ALTER TABLE cjams.personabusesubstance ADD COLUMN IF NOT EXISTS sextraffichistoryreportedon date;

ALTER TABLE cjams.personabusesubstance ADD COLUMN IF NOT EXISTS ischildhassextraffic boolean;

ALTER TABLE cjams.personabusesubstance ADD COLUMN IF NOT EXISTS issextrafficreported boolean;

ALTER TABLE cjams.personabusesubstance ADD COLUMN IF NOT EXISTS sextrafficreportedon date;

ALTER TABLE cjams.personabusesubstance ADD COLUMN IF NOT EXISTS nochangesinsextraffic boolean;

COMMENT ON COLUMN cjams.personabusesubstance.ischildhassextraffichistory IS 'Flag to check whether the person is already has an history of sex trafficking';

COMMENT ON COLUMN cjams.personabusesubstance.issextraffichistoryreported IS 'Flag to check whether the person is already has an history reported of sex trafficking';

COMMENT ON COLUMN cjams.personabusesubstance.sextraffichistoryreportedon IS 'Date of the reported time';

COMMENT ON COLUMN cjams.personabusesubstance.ischildhassextraffic IS 'Flag to check whether the person is already has an sex trafficking';

COMMENT ON COLUMN cjams.personabusesubstance.issextrafficreported IS 'Flag to check whether the person is already has reported of sex trafficking';

COMMENT ON COLUMN cjams.personabusesubstance.sextrafficreportedon IS 'Date of the reported time';

COMMENT ON COLUMN cjams.personabusesubstance.nochangesinsextraffic IS 'Flag to check whether the person is has no changes of sex trafficking';
	