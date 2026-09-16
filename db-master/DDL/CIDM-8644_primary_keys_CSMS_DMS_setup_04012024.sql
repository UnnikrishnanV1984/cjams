-- CIDM-8644 - Add missing primary keys (DMS setup for CSMS team)

alter table personemployment add primary key(personemploymentid);
alter table personmilitaryservices add primary key(personmilitaryserviceid);
alter table ivecsescountycodes add primary key(referencetypeid);


