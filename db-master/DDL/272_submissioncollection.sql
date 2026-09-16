ALTER TABLE cjams.submissioncollection ALTER COLUMN datavalue TYPE varchar(10000) USING datavalue::varchar;
ALTER TABLE cjams.submissioncollection ALTER COLUMN "datatype" TYPE varchar(250) USING "datatype"::varchar;
