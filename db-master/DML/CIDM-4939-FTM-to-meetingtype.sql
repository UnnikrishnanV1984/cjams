delete from meetingtype where meetingtypekey ='FTM';
INSERT INTO cjams.meetingtype( meetingtypeid,meetingtypekey, typedescription, displayorder, activeflag,effectivedate,insertedby,updatedby,insertedon,updatedon,old_id)
	VALUES ( gen_random_uuid(),'FTM', 'Family Team Meeting',8, 1,NULL,'CIDM-4939','CIDM-4939',now(),now(),NULL);