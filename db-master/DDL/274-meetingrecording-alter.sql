alter table meetingrecording add column if not exists ismeetingdecision int4 NULL;

alter table meetingrecording add column if not exists followupdate timestamp null;

alter table meetingrecording add column if not exists meetingdecision text null;

