ALTER TABLE cjams.alias ALTER COLUMN akatypetypekey TYPE varchar(20) USING akatypetypekey::varchar;
ALTER TABLE cjams.alias ALTER COLUMN prefixtypekey TYPE varchar(20) USING prefixtypekey::varchar;