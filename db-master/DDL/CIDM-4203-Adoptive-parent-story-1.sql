alter table adoptioncaseagreement 
add column if not exists switchproviderreason varchar(500);

alter table adoptioncaseagreement 
add column if not exists effectiveswitchdate timestamp;

alter table adoptioncaseagreementrevision 
add column if not exists switchproviderreason varchar(500);

alter table adoptioncaseagreementrevision 
add column if not exists effectiveswitchdate timestamp;