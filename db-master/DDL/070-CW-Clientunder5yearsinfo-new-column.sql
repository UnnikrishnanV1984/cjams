alter table clientunder5yearsinfo add column if not exists complications json null;
alter table personphycisianinfo add column if not exists otherspeciality varchar(100) null;
alter table personphycisianinfo add column if not exists degreetype varchar(100) null;

alter table personsexualinfo  add column if not exists genderidentity varchar(50) NULL;
alter table personsexualinfo  add column if not exists genderidentityspecify varchar(500) NULL;
alter table personsexualinfo  add column if not exists birthcontroldate date NULL;
alter table personsexualinfo  add column if not exists sexualorientationcomments varchar(500) NULL;
alter table personsexualinfo  add column if not exists specify varchar(500) NULL;