----------------------------------------------------------------
-- 04/08/2025 - B-208462 - Naveenkumar Chemutu
---------------------------------------------------------------

Delete from cjams.meetingtype where meetingtypekey = 'HM' and typedescription ='Health/Medication';


INSERT INTO cjams.meetingtype( meetingtypeid,meetingtypekey, typedescription, displayorder, activeflag,effectivedate,insertedby,updatedby,insertedon,updatedon,old_id)
	VALUES ( gen_random_uuid(),'HM', 'Health/Medication',12, 1,NULL,'CIDM-10354','CIDM-10354',now(),now(),NULL);