alter table Investigationallegationmaltreators add column if not exists finalizeflag boolean null;
alter table Investigationallegationmaltreators add column if not exists approveappeal boolean null;
alter table investigationallegationmaltreators add column if not exists appealfinding varchar(50) null;
alter table investigationallegationmaltreators add column if not exists workercomments text null;

ALTER TABLE cjams.investigationallegationmaltreators ALTER COLUMN overridefindingtypekey TYPE varchar(50) USING overridefindingtypekey::varchar;
