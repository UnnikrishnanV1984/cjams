--D-24911

ALTER TABLE cjams.legalcustody ALTER COLUMN reason TYPE varchar(4000) USING reason::varchar;

