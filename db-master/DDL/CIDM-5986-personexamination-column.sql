alter table personexamination add column if not exists authformcompletion text;
comment on column cjams.personexamination.authformcompletion is 'to store Was Foster Care Health Services Authorization form completed?';

alter table personexamination add column if not exists notcompletedauthform character varying(500);
comment on column cjams.personexamination.notcompletedauthform is 'to store Explanation for missing foster care health services authorization form ';

alter table personexamination add column if not exists otherreason character varying(500);
comment on column cjams.personexamination.otherreason is 'to store reason for other';
