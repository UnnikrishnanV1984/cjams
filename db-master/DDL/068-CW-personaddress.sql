alter table personaddress add column if not exists addressstartdate timestamp null;
update intakeserv set activeflag=0 where intakeservid='3af5d26c-6ede-4173-a86a-29b5aaa84f0b';
update intakeagencyserv set activeflag=0 where intakeagencyservid='f97240ac-1201-4719-86eb-8400c4bfd2c4';