-- CDM-22731 - Best Interests Determination Ticklers
/*
-- Issue Description: 
   BID Ticklers related to placement change are not displaying the name of the identified child 
   or even their CJAMS ID it only displays an unidentifiable number.

-- Category/ Module: User Notification (Case Management) 
-- Root cause: sp_cw_usernotifications was having error in column mapping personid (uuid) in place of Person name 
-- Pull request# Code fix is part of CDM-22731 
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: Next Prod deployment
*/

-- Before 
select un.old_id,
	un.usernotificationid, 
	un.updatedby, 
	un.updatedon,
	( select pr.firstname || ' ' || pr.lastname || ' / CJAMS PID ' || to_char(pr.cjamspid) 
		from person pr
      where pr.personid = btrim(substring(un.subject from 43 for (79 - 43)))::uuid
	 ) as client_name
	-- , un."body", un.subject
from usernotification un
where un.old_id in ('edu-plc-updt-bid', 'edu-plc-new-bid')
	and un."body" not like '%CJAMS PID%'
	and un.activeflag = 1
	and cjams.uuid_or_null(btrim(substring(un.subject from 43 for (79 - 43)))::character varying) is not null
	;

-- and length(un."body") =121 
update usernotification un
set un."body" = 'There is a Placement Change for the Child ' 
	|| ( select pr.firstname || ' ' || pr.lastname || ' / CJAMS PID ' || to_char(pr.cjamspid) 
			from person pr
		where pr.personid = btrim(substring(un.subject from 43 for (79 - 43)))::uuid
		) 
	|| '. The Education entries need to be updated.',	
	un.subject = 'There is a Placement Change for the Child ' 
	|| ( select pr.firstname || ' ' || pr.lastname || ' / CJAMS PID ' || to_char(pr.cjamspid) 
			from person pr
		where pr.personid = btrim(substring(un.subject from 43 for (79 - 43)))::uuid
		) 
	|| '. The Education entries need to be updated.',	
	updatedby = 'CDM-22731',
	updatedon = now()
where un.old_id in ('edu-plc-updt-bid', 'edu-plc-new-bid')
	and un."body" not like '%CJAMS PID%'
	and un.activeflag = 1
	and cjams.uuid_or_null(btrim(substring(un.subject from 43 for (79 - 43)))::character varying) is not null
	and length(un."body") = 121 ;
	

-- and length(un."body") =153
update usernotification un
set un."body" = 'There is a Placement Change for the Child ' 
	|| ( select pr.firstname || ' ' || pr.lastname || ' / CJAMS PID ' || to_char(pr.cjamspid) 
			from person pr
		where pr.personid = btrim(substring(un.subject from 43 for (79 - 43)))::uuid
		) 
	|| '. The Best Interest Determination and Education entries need to be updated.',	
	un.subject = 'There is a Placement Change for the Child ' 
	|| ( select pr.firstname || ' ' || pr.lastname || ' / CJAMS PID ' || to_char(pr.cjamspid) 
			from person pr
		where pr.personid = btrim(substring(un.subject from 43 for (79 - 43)))::uuid
		) 
	|| '. The Best Interest Determination and Education entries need to be updated.',	
	updatedby = 'CDM-22731',
	updatedon = now()
where un.old_id in ('edu-plc-updt-bid', 'edu-plc-new-bid')
	and un."body" not like '%CJAMS PID%'
	and un.activeflag = 1
	and cjams.uuid_or_null(btrim(substring(un.subject from 43 for (79 - 43)))::character varying) is not null
	and length(un."body") = 153 ;
	
-- After 
select Count(*)
from usernotification un
where un.old_id in ('edu-plc-updt-bid', 'edu-plc-new-bid')
	and un."body" not like '%CJAMS PID%'
	and un.activeflag = 1
	and cjams.uuid_or_null(btrim(substring(un.subject from 43 for (79 - 43)))::character varying) is not null
	;	