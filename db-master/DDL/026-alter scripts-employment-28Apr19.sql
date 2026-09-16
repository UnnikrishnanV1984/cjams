alter table personemployment add column promotedemploymentprogramenddate timestamp;
alter table personemployment add column promotedemploymentnarrative varchar(255);
alter table personemployment add column promotedemploymentflag int;
alter table personemployment add column address1 varchar(100);
alter table personemployment add column address2 varchar(100);
alter table personemployment add column personemployerdetailsid uuid;
alter table personemployment alter column workphone type varchar(100);


