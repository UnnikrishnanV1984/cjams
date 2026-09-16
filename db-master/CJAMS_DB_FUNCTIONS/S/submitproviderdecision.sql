CREATE OR REPLACE FUNCTION cjams.submitproviderdecision(objectls json)
 RETURNS text
 LANGUAGE plpgsql
AS $function$ 

declare
v_fromsecurityuserid character varying;
v_appstatus character varying;
v_objectid character varying;


begin
v_fromsecurityuserid:= objectls->>'fromsecurityuserid';
v_appstatus:= objectls->>'status';
v_objectid:= objectls->>'objectid';
	
INSERT INTO tb_provider_decision
(decisionid, eventcode, fromsecurityusersid, fromroleid, objectid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, status, decisiondate,
toroleid,tosecurityusersid)
VALUES(gen_random_uuid(),objectls->>'eventcode', v_fromsecurityuserid, objectls->>'fromroleid', v_objectid, 1, v_fromsecurityuserid, now(), v_fromsecurityuserid,
now(), false, objectls->>'remarks', v_appstatus,  (objectls->>'decisiondate')::timestamp,objectls->>'toroleid',objectls->>'tosecurityusersid');

if(v_appstatus = 'Submitted')
then

update tb_provider_applicant set application_status = v_appstatus where applicant_id = v_objectid;

end if;

RETURN 'success';
end;
$function$
