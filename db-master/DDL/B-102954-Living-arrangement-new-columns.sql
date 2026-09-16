alter table person add column if not exists livingarrangementkey varchar(50);
alter table person add column if not exists livingarrangementdesc text;

comment on column cjams.person.livingarrangementkey is 'Living arrangement of the person';
comment on column cjams.person.livingarrangementdesc is 'Description for the Person Living arrangement';