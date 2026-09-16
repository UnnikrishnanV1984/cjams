ALTER TABLE cjams.investigationmaltreatment add column if not exists providerid int4 NULL;
ALTER TABLE cjams.investigationmaltreatment add column if not exists providername varchar(100) NULL;
ALTER TABLE cjams.investigationmaltreatment add column if not exists providerphonenumber varchar(20) NULL;

 