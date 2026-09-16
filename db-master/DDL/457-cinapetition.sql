ALTER TABLE cjams.cinapetition
ADD COLUMN if not exists grouphomename varchar(30) NULL;


ALTER TABLE cjams.cinapetition
ADD COLUMN if not exists isgrouphome boolean NULL;

