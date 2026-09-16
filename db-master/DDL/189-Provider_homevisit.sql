ALTER TABLE cjams.publicproviderhomestudyvisit ALTER COLUMN interview_location TYPE varchar(1000) USING interview_location::varchar;
