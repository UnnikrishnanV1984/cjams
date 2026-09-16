/*
 New column added for schoolenrollment type in education tab for userstory -CIDM-4940
*/
ALTER table personeducation add column if not exists schoolenrolltypekey character varying (30);
comment on column personeducation.schoolenrolltypekey is 'To capture the schoolenrollment type in education tab';