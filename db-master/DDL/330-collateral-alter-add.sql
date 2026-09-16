alter table collateral alter column referralid  DROP NOT NULL;

alter table collateral alter column caseid  DROP NOT NULL;

alter table collateral alter column legalclientid  DROP NOT NULL;

alter table collateral alter column clientmergeid  DROP NOT NULL;

ALTER TABLE collateral ADD COLUMN  if not exists intakenumber  varchar(50) NULL ;

ALTER TABLE collateral ADD COLUMN  if not exists title  varchar(50) NULL ;

ALTER TABLE collateral ADD COLUMN  if not exists objecttype  varchar(50) NULL ;