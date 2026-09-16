DROP FUNCTION if exists cjams.addupdateexternalapilogs( json, text, text, character varying, character varying);

CREATE OR REPLACE FUNCTION cjams.addupdateexternalapilogs(v_object json, request text, response text, responsestatus character varying, addorupdate character varying)
 RETURNS json
 LANGUAGE plpgsql
AS $function$ 
------------------------------------------------------------------------
-- SQL Stored Procedure
-- Author: Chandra Ramasamy
-- Date Created :03/20/2023
-- To track extenral APIs. First insert the request. then once get the response, update the response from API call
-- Add 
/*select cjams.addupdateexternalapilogs(
'{
"objectid" : "test1234",
"objecttype" : "jira",
"objectsubtype" : "Servicecase"
"insertedby" : "0ef306e4-7034-448f-8f9a-088f73c2b8fc",
"updatedby":"0ef306e4-7034-448f-8f9a-088f73c2b8fc"
}'::json,
'{
"supportid" : "S1234567"

}'::text,

'resp'::text,
'success',
'add'
);*/
--Update
/*
select cjams.addupdateexternalapilogs(
'{
"externalapilogsid" : "73065c71-c3a6-4f5c-ad19-d7f3af8a8c65",
"updatedby":"0ef306e4-7034-448f-8f9a-088f73c2b8fc"
}'::json,
''::text,

'resp'::text,
'error',
'update'
); 
 
 */


DECLARE 

v_result json;
v_externalapilogsid varchar;
v_response text;
v_request text;
v_responsestatus varchar;
begin
v_response := response;
v_request := request;
v_responsestatus := responsestatus;

raise notice '>>>Before if condition.v_response >>> %',v_response;
raise notice '>>>Before if condition.v_request >>> %',v_request;
raise notice '>>>Before if condition.v_responsestatus >>> %',v_responsestatus;
raise notice '>>>Before if condition.v_object >>> %',v_object;
raise notice '>>>Before if condition.addorupdate >>> %',addorupdate;

if (addorupdate	= 'add') then
	
insert 	into
		cjams.externalapilogs (
		objectid,
		objecttype,
		objectsubtype,
		request,
		response,
		responsestatus,
		activeflag,
		insertedon,
		insertedby,
		updatedon,
		updatedby)
	values(
	v_object ->> 'objectid',
	v_object ->> 'objecttype',
	v_object ->> 'objectsubtype',
	v_request,
	v_response,
	v_responsestatus,
	1,
	now(),
	v_object ->> 'insertedby',
	now(),
	v_object ->> 'insertedby') RETURNING "externalapilogsid" INTO  v_externalapilogsid;


else 

raise notice '>>>>else condition>>> v_object ->> externalapilogsid>>>> %',v_object ->> 'externalapilogsid';
update
	cjams.externalapilogs
set
	response = v_response,
	responsestatus = v_responsestatus,	
	updatedon = now(),
	updatedby = v_object ->> 'updatedby'
where
	externalapilogsid = (v_object ->> 'externalapilogsid')::uuid;
v_externalapilogsid:= 'success';
end if;

    SELECT json_agg(a) into v_result FROM 
		(
		select v_externalapilogsid    
			
		) a;

RETURN v_result;

END;

$function$
;
