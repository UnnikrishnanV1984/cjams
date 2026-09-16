alter table personsexualinfo add column if not exists pregnancyduedate timestamp;
alter table personsexualinfo add column if not exists ispregnancyduedateunknown boolean;
alter table personsexualinfo add column if not exists currentlyparenting boolean;
alter table personsexualinfo add column if not exists notparentingreason character varying;
alter table personsexualinfo add column if not exists isfatheredachild boolean;