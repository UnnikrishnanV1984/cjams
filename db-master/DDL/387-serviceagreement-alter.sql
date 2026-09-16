ALTER TABLE cjams.serviceagreementlist DROP COLUMN IF exists collateralid;
ALTER TABLE cjams.serviceagreementlist ADD COLUMN collateralid uuid;

ALTER TABLE cjams.serviceagreementlist DROP COLUMN IF exists staffid;
ALTER TABLE cjams.serviceagreementlist ADD COLUMN staffid uuid;

ALTER TABLE cjams.serviceagreementlist DROP COLUMN IF exists supervisorid;
ALTER TABLE cjams.serviceagreementlist ADD COLUMN supervisorid uuid;

ALTER TABLE cjams.serviceagreementlist DROP COLUMN IF exists associateid;
ALTER TABLE cjams.serviceagreementlist ADD COLUMN associateid uuid;


ALTER TABLE cjams.serviceagreement DROP COLUMN IF exists staffid;
ALTER TABLE cjams.serviceagreement ADD COLUMN staffid uuid;

ALTER TABLE cjams.serviceagreement DROP COLUMN IF exists supervisorid;
ALTER TABLE cjams.serviceagreement ADD COLUMN supervisorid uuid;

ALTER TABLE cjams.serviceagreement DROP COLUMN IF exists associateid;
ALTER TABLE cjams.serviceagreement ADD COLUMN associateid uuid;
