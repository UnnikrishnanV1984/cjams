alter table personsexualinfo ADD column if not exists isgivenbirth boolean;
alter table personsexualinfo ADD column if not exists currentlyparentingother boolean;
alter table personsexualinfo ADD column if not exists notparentingotherreason text;

COMMENT ON COLUMN cjams.personsexualinfo.isgivenbirth IS 'To check if Youth ever given birth?';

COMMENT ON COLUMN cjams.personsexualinfo.currentlyparentingother IS 'To check if Female or Transgender identifies as male currently Parenting the Child?';

COMMENT ON COLUMN cjams.personsexualinfo.notparentingotherreason IS 'To check why the Female or Transgender identifies as male currently is not parenting after giving birth';