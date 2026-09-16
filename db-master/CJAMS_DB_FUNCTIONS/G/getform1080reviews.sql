DROP FUNCTION IF EXISTS getform1080reviews(varchar, varchar);
CREATE OR REPLACE FUNCTION cjams.getform1080reviews(v_usersid VARCHAR, v_servicereqno VARCHAR)
RETURNS TABLE (
  caseid UUID,
  servicerequestnumber VARCHAR,
  intakenumber VARCHAR,
  servreqtype VARCHAR,
  classkey VARCHAR,
  updatedon TIMESTAMP,
  clientname VARCHAR,
  intakeserreqstatustypekey VARCHAR,
  assignedon TIMESTAMP,
  submitteduser VARCHAR,
  isgroup BOOLEAN,
  comments text,
  appevent VARCHAR,
  dadetails JSON,
  sdm JSON,
  eventdescription VARCHAR,
  objectid VARCHAR,
  personid VARCHAR,
  client_id BIGINT,
  service_log_id INTEGER,
  permanencyplanid UUID
)
LANGUAGE plpgsql AS $$
------------------------------------------------------------------------------------------------------
-- 07/18/2025 - CIDM-10473 - Simar Singh - Added logic to pull Form 1080 review items for all A, B & C
------------------------------------------------------------------------------------------------------

BEGIN
  RETURN QUERY
--FORM1080A
select
distinct on (un.objectcasenumber, un.body)
 case when f.objecttype != 'intake' then f.objectid::uuid else null end
, un.objectcasenumber
, ''::varchar
, case
    when f.objecttype = 'servicecase' then 'Service Case'::varchar
    else 'CHILD'::varchar
  end
, case when f.objecttype != 'intake' then
			(SELECT srst.classkey
				FROM servicerequestsubtype as srst
				join intakeservicerequest ISR ON srst.servicerequestsubtypeid=ISR.intakeservicerequestclassid 
				where isr.intakeserviceid=f.objectid::uuid
				AND srst.activeflag=1 limit 1)
		else 'Intake'
	end
, un.updatedon :: timestamp
, ''::varchar -- maybe get from personid
, ''::varchar
, un.insertedon :: timestamp
, cast(up.lastname ||',    ' ||up.firstname as character varying) submitteduser
, false
, coalesce(un.subject,'')::text
, 'FORM1080'::varchar
, null ::json
, null ::json
, 'Form 1080A Review' ::varchar
, un.objectid ::varchar
, f.personid:: character varying,
null ::BIGINT,
null ::Integer,
null ::uuid
from usernotification un
join form1080a f on un.objectid = f.objectid and un.activeflag = 1
JOIN userprofile up on up.securityusersid = un.insertedby  and up.activeflag  =1
where 
f.activeflag = 1 and un.body ilike 'form 1080a%' and f.status='Review'
and un.securityusersid = v_usersid
and un.objectcasenumber LIKE COALESCE(v_servicereqno, '') ||'%'
union all
--Form 1080B
select
distinct on (un.objectcasenumber, un.body)
 case when f.objecttype != 'intake' then f.objectid::uuid else null end
, un.objectcasenumber
, ''::varchar
, case
    when f.objecttype = 'servicecase' then 'Service Case'::varchar
    else 'CHILD'::varchar
  end
, case when f.objecttype != 'intake' then
			(SELECT srst.classkey
				FROM servicerequestsubtype as srst
				join intakeservicerequest ISR ON srst.servicerequestsubtypeid=ISR.intakeservicerequestclassid 
				where isr.intakeserviceid=f.objectid::uuid
				AND srst.activeflag=1 limit 1)
		else 'Intake'
	end
, un.updatedon :: timestamp
, ''::varchar -- maybe get from personid
, ''::varchar
, un.insertedon :: timestamp
, cast(up.lastname ||',    ' ||up.firstname as character varying) submitteduser
, false
, coalesce(un.subject,'')::text
, 'FORM1080'::varchar
, null ::json
, null ::json
, 'Form 1080B Review' ::varchar
, un.objectid ::varchar
, f.personid:: character varying,
null ::BIGINT,
null ::Integer,
null ::uuid
from usernotification un
join form1080b f on un.objectid = f.objectid and un.activeflag = 1
JOIN userprofile up on up.securityusersid = un.insertedby  and up.activeflag  =1
where 
f.activeflag = 1 and un.body ilike 'form 1080b%' and f.status='Review'
and un.securityusersid = v_usersid
and un.objectcasenumber LIKE COALESCE(v_servicereqno, '') ||'%'
UNION ALL
--FORM1080C
select
distinct on (un.objectcasenumber, un.body)
 case when f.objecttype != 'intake' then f.objectid::uuid else null end
, un.objectcasenumber
, ''::varchar
, case
    when f.objecttype = 'servicecase' then 'Service Case'::varchar
    else 'CHILD'::varchar
  end
, case when f.objecttype != 'intake' then
			(SELECT srst.classkey
				FROM servicerequestsubtype as srst
				join intakeservicerequest ISR ON srst.servicerequestsubtypeid=ISR.intakeservicerequestclassid 
				where isr.intakeserviceid=f.objectid::uuid
				AND srst.activeflag=1 limit 1)
		else 'Intake'
	end
, un.updatedon :: timestamp
, ''::varchar -- maybe get from personid
, ''::varchar
, un.insertedon :: timestamp
, cast(up.lastname ||',    ' ||up.firstname as character varying) submitteduser
, false
, coalesce(un.subject,'')::text
, 'FORM1080'::varchar
, null ::json
, null ::json
, 'Form 1080C Review' ::varchar
, un.objectid ::varchar
, f.personid:: character varying,
null ::BIGINT,
null ::Integer,
null ::uuid
from usernotification un
join form1080c f on un.objectid = f.objectid and un.activeflag = 1
JOIN userprofile up on up.securityusersid = un.insertedby and up.activeflag  =1
where 
f.activeflag = 1 and un.body ilike 'form 1080c%' and f.status='Review'
and un.securityusersid = v_usersid
and un.objectcasenumber LIKE COALESCE(v_servicereqno, '') ||'%';
END;
$$;