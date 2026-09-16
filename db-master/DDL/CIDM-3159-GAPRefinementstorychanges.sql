ALTER TABLE gapratesrevision ADD COLUMN IF NOT EXISTS approvaldate timestamp NULL;
ALTER TABLE cjams.gapagreement ADD COLUMN IF NOT EXISTS guardian1signature text NULL;
ALTER TABLE cjams.gapagreement ADD COLUMN IF NOT EXISTS guardian2signature text NULL;
ALTER TABLE cjams.gapagreement ADD COLUMN IF NOT EXISTS ldssdirectorsignature text NULL;
ALTER TABLE cjams.gapagreementrevision ADD COLUMN IF NOT EXISTS guardian1signature text NULL;
ALTER TABLE cjams.gapagreementrevision ADD COLUMN IF NOT EXISTS guardian2signature text NULL;
ALTER TABLE cjams.gapagreementrevision ADD COLUMN IF NOT EXISTS ldssdirectorsignature text NULL;

ALTER TABLE cjams.gapapplication ADD COLUMN IF NOT EXISTS guardian1signature text NULL;
ALTER TABLE cjams.gapapplication ADD COLUMN IF NOT EXISTS guardian2signature text NULL;
ALTER TABLE cjams.gapapplication ADD COLUMN IF NOT EXISTS ldssdirectorsignature text NULL;

ALTER TABLE cjams.guardianship ADD column if not exists iscgenteredagreement bool;
ALTER TABLE cjams.guardianship ADD column if not exists isapprovedresourceparent bool;
ALTER TABLE cjams.guardianship ADD column if not exists isapprovedkinshipplacement bool;

ALTER TABLE cjams.gapagreement ADD COLUMN IF NOT EXISTS guardian1signature text NULL;
ALTER TABLE cjams.gapagreement ADD COLUMN IF NOT EXISTS guardian2signature text NULL;
ALTER TABLE cjams.gapagreement ADD COLUMN IF NOT EXISTS ldssdirectorsignature text NULL;


ALTER TABLE cjams.guardianship ADD column if not exists documentsigned bool;
ALTER TABLE cjams.gapdisclosure ADD column if not exists dateofplanning timestamp NULL;

ALTER TABLE gapratesrevision ADD COLUMN IF NOT EXISTS ratestartdate timestamp NULL;
ALTER TABLE gapratesrevision ADD COLUMN IF NOT EXISTS providerid int4 NULL;
ALTER TABLE gapratesrevision ADD COLUMN IF NOT EXISTS paymentamt numeric NULL;
ALTER TABLE gapratesrevision ADD COLUMN IF NOT EXISTS "comments" varchar NULL;

ALTER TABLE gapagreementrate ADD COLUMN IF NOT EXISTS ssaapprovaldate timestamp NULL;