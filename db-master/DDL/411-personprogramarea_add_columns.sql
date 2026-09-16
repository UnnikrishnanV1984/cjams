ALTER TABLE cjams.personprogramarea
add column if not exists datatransferflag varchar(1);

ALTER TABLE cjams.personprogramarea
add column if not exists datasentdate timestamp;
 