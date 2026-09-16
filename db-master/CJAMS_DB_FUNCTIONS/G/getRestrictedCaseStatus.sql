DROP FUNCTION IF EXISTS getrestrictedcasestatus(character varying, character varying);
CREATE OR REPLACE FUNCTION cjams.getrestrictedcasestatus(intakeserviceid character varying, v_userid character varying)
 RETURNS text
 LANGUAGE plpgsql
AS $function$
------------------------------------------------------------------------
-- 09/18/2025 - Veera Nadimpalli Add User Resource table check for policy staff
------------------------------------------------------------------------
DECLARE v_count integer; 
BEGIN
    SELECT count(*) INTO v_count FROM restricteditems WHERE objectid=intakeserviceid and activeflag = 1;
    IF v_count=0 THEN 
      RETURN 'INCL';
    END IF;
	IF v_count>0 THEN  --- B-86146 - Add user role CJAMS Policy & IV-E Roles to View all Restricted Cases CJAMS CW
	



    SELECT COUNT(*) INTO v_count  FROM (
	   select role.name 
	   from muser
	   inner join  rolemapping rm on rm.principalid::int = muser.id 
       inner join role on role.id = rm.roleid
       where muser.securityusersid::varchar = v_userid
	   and rm.activeflag=1 and rm.teamtypekey = 'CW'
	   and role.name in ('IV-E Specialist', 'IV-E Eligibility Analyst', 'IV-E Eligibility Administrator Assistant', 'IV-E Eligibility Quality Assurance', 'IV-E Eligibility Administrator', 'IV-E Liaison', 'IV-E Supervisor', 'Central Policy Staff')
	   
	   union all 
	   
	   select r.name from muser
	   join userresource u on u.userid = muser.id 
       join role r on r.id = u.roleid and r.activeflag = 1
	   where muser.securityusersid::varchar = v_userid
	   and r.name in ('IV-E Specialist', 'IV-E Eligibility Analyst', 'IV-E Eligibility Administrator Assistant', 'IV-E Eligibility Quality Assurance', 'IV-E Eligibility Administrator', 'IV-E Liaison', 'IV-E Supervisor', 'Central Policy Staff')
    );



	IF v_count = 0 THEN  
	  SELECT count(*) INTO v_count FROM restricteditems WHERE objectid=intakeserviceid AND accessuserid=v_userid and activeflag = 1;
	END IF;
	
	  IF v_count>0 THEN 
	    RETURN 'INCLRES';
	  ELSE
	    RETURN 'EXCLUDE';
	  END IF;
	END IF;
END;
$function$
;