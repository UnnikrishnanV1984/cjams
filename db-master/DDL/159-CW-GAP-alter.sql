alter table gapagreement
add column if not exists isfianotified integer;

alter table gapagreement
add column if not exists fianotifieddate timestamp;

alter table gapagreement
add column if not exists isrcnotifiedcontact integer;

alter table gapagreement
add column if not exists iscsnotifiedtocustody integer;