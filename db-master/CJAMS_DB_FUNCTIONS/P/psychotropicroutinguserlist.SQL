-- 10/18/2023 prasanna sai kommineni -- CIDM-9541 B-206485 : CW-Psychotropic Medications - Secondary Review
-- 03/17/2026 vamshikri.byreddy - CIDM-10987 B-236421 : CW-Psychotropic Secondary all request dashboard

DROP FUNCTION IF exists cjams.psychotropicroutinguserlist(usersid character varying,roletypekey character varying);
CREATE OR REPLACE FUNCTION cjams.psychotropicroutinguserlist(usersid character varying,roletypekey character varying)
RETURNS  json
    LANGUAGE 'plpgsql'
 
AS $function$

declare 

v_UserSID character varying;
v_securityusersid character varying;
v_roletypekey character varying;

v_result json;
-- v_ldssid uuid;
begin
v_securityusersid :=usersid;
v_roletypekey := roletypekey;


-- select countyid into v_ldssid from v_userprofile u where u.securityusersid = v_securityusersid;


select json_agg(a) INTO  v_result from (select securityusersid,email,firstname||' '|| lastname as displayname,cjamspid,up.roletypekey   from 
v_userprofile up

where up.roletypekey in (v_roletypekey)  )a;




RETURN v_result;
end;

$function$;