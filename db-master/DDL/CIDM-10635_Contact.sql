ALTER TABLE cjams.personphonenumber
  DROP CONSTRAINT IF EXISTS fk_personphonenumber_person;

ALTER TABLE cjams.personphonenumber
ADD COLUMN IF NOT EXISTS commentsphone text;


ALTER TABLE cjams.personemail
  DROP CONSTRAINT IF EXISTS fk_personemail_person;

ALTER TABLE cjams.personemail
  DROP CONSTRAINT IF EXISTS fk_personemail_personemailtype;

ALTER TABLE cjams.personemail
ADD COLUMN IF NOT EXISTS commentsemail text;



COMMENT ON COLUMN cjams.personphonenumber.commentsphone IS 'Comments related to the phone number entry';
COMMENT ON COLUMN cjams.personemail.commentsemail IS 'Comments related to the email entry';