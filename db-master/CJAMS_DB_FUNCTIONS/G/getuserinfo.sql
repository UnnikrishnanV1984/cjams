DROP FUNCTION IF EXISTS getuserinfo(v_tokenid character varying);
DROP FUNCTION IF EXISTS getuserinfo(v_tokenid character varying,v_email_id character varying);
CREATE OR REPLACE FUNCTION getuserinfo(v_tokenid character varying,v_email_id character varying)
 RETURNS TABLE(responsecode integer, responsemsg character varying, userdata json)
 LANGUAGE plpgsql
AS $function$

declare  retunjson  json;
l_userid bigint;
l_count  bigint;

BEGIN
--- Giving priority To open AM email

IF  v_email_id IS NOT NULL THEN 
  select count(*) into l_count from userprofile where lower(email)=lower(v_email_id) and activeflag=1;
  IF(l_count=0) THEN 
    RETURN QUERY 
	SELECT 401,  'could not find open AM email not present' ::character varying ,null::json;
  ELSE
   SELECT  row_to_json  (t)  into  retunjson  from  (
	SELECT    mu.realm,mu.email,mu.emailverified,  mu.id,  mu.securityusersid,  mu.username,mu.agencyid,
			  tm.roletypekey,tm.loadnumber,  t.teamid    ,  t.teamname  teamname,up.teamtypekey,tt.description  teamtypedesc,
			  tma.teammemberid, t.countyid, up.fullname 
		FROM 			muser  mu  
		INNER  JOIN  	userprofile  up  ON  up.securityusersid  =  mu.securityusersid  AND  up.activeflag  =1
		INNER  JOIN  	teammemberassignment  tma  ON  tma.securityusersid  =  up.securityusersid  AND  tma.activeflag  =1
		INNER  JOIN  	teammember  tm  ON  tm.teammemberid  =  tma.teammemberid  AND  tm.activeflag  =1
		INNER  JOIN  	team  t  ON  t.teamid  =  tm.teamid    AND  t.activeflag  =1
		INNER  JOIN  	teamtype  tt  ON  tt.teamtypekey  =  t.teamtypekey  AND  tt.activeflag  =1 
		WHERE  lower(up.email)    = lower(v_email_id)   AND mu.activeflag  =1 

  )  as  t;
    RETURN  QUERY SELECT 200,  'Found open AM email' ::character varying ,   retunjson;
   END IF;
ELSE

SELECT userid INTO l_userid  FROM accesstoken  WHERE id = v_tokenid AND activeflag  =1;
IF (COALESCE(l_userid,0)=0 ) THEN
	RETURN QUERY 
	SELECT 404,  'could not find accessToken' ::character varying ,null::json;
ELSE
SELECT  row_to_json  (t)  into  retunjson  from  (
	SELECT    mu.realm,mu.email,mu.emailverified,  mu.id,  mu.securityusersid,  mu.username,mu.agencyid,
			  tm.roletypekey,tm.loadnumber,  t.teamid    ,  t.teamname  teamname,up.teamtypekey,tt.description  teamtypedesc,
			  tma.teammemberid, t.countyid, up.fullname 
		FROM 			muser  mu  
		INNER  JOIN  	userprofile  up  ON  up.securityusersid  =  mu.securityusersid  AND  up.activeflag  =1
		INNER  JOIN  	teammemberassignment  tma  ON  tma.securityusersid  =  up.securityusersid  AND  tma.activeflag  =1
		INNER  JOIN  	teammember  tm  ON  tm.teammemberid  =  tma.teammemberid  AND  tm.activeflag  =1
		INNER  JOIN  	team  t  ON  t.teamid  =  tm.teamid    AND  t.activeflag  =1
		INNER  JOIN  	teamtype  tt  ON  tt.teamtypekey  =  t.teamtypekey  AND  tt.activeflag  =1 
		WHERE  mu.id    = l_userid   AND mu.activeflag  =1 

  )  as  t;
    RETURN  QUERY SELECT 200,  'Found access token' ::character varying ,   retunjson;
 END IF;
END IF;
	END  
  $function$
;
