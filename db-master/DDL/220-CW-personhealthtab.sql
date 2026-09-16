alter table personmedicalinfo 
add column if not exists medicationtype varchar(50),
add column if not exists prescribedduration varchar(50);

alter table investigationmaltreatment 
add column if not exists isnotapplicable integer default 0,
add column if not exists notapplicablecomments varchar(500);