-- CIDM-9332 getusernotification index for length(objectid)
create index usernotification_objectid_length on usernotification (length(objectid));