create index Xie1_personauditlog on personauditlog(personid,activeflag);
create index Xie2_personauditlog on personauditlog(date(insertedon));