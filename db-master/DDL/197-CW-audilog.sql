ALTER TABLE cjams.auditlog 
add column if not exists objectid varchar(50) null,
add column if not exists objecttype varchar(50) null;