ALTER TABLE cjams.placementrevision ALTER COLUMN placementrevisionid SET DEFAULT gen_random_uuid();
ALTER  TABLE gapagreementrate ALTER COLUMN alternateid  SET DEFAULT nextval('sequence_gapagreementrate'::regclass);
UPDATE gapagreementrate SET alternateid =nextval('sequence_gapagreementrate'::regclass) ;