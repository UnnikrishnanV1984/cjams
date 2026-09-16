DROP FUNCTION IF EXISTS cjams.updatereviewer(v_appeventcode character varying, v_objectid character varying, v_fromuserid character varying, v_securityusersid character varying);

CREATE OR REPLACE FUNCTION cjams.updatereviewer(v_appeventcode character varying, v_objectid character varying, v_fromuserid character varying, v_securityusersid character varying)
 RETURNS text
 LANGUAGE plpgsql
AS $function$

/*Declare Local Variables*/
DECLARE 
	l_fromroletypekey character varying;
	l_isreviewrequest boolean;
	l_servicerequestnumber character varying;
	l_objecttypekey character varying;
	l_fromteamid uuid;
	l_responsibilitytypekey character varying; 
	l_caseassignmentid uuid;
	l_assignuser json;

BEGIN 

/*Logged in user team details*/ 

	SELECT  tm.teamid  INTO l_fromteamid
	FROM    teammemberassignment tma 
			INNER JOIN  teammember tm ON tm.teammemberid = tma.teammemberid AND tm.activeflag =1
			INNER JOIN team t on t.teamid = tm.teamid  and t.activeflag =1
	WHERE  	tma.SecurityUsersId = v_fromuserid
		AND	tma.activeflag =1; 

	select role.roletypekey INTO l_fromroletypekey  from rolemapping rm
	join role on role.id = rm.roleid and role.activeflag = 1 
	join muser on muser.id = rm.principalid::int and muser.activeflag = 1 and rm.activeflag = 1 and rm.teamtypekey = 'CW'
	where muser.securityusersid = v_fromuserid;

/*Get Asignee from Routing Table*/
	SELECT json_agg(a) INTO l_assignuser
	FROM ( 	SELECT  	r.isreviewrequest, r.servicerequestnumber, r.objecttypekey
					, 	r.tosecurityusersid ,r.routeddescription,r.toroleid,r.teamid
			FROM routing r 
			WHERE r.objectid  = v_objectid 
				AND r.eventcode = v_appeventcode AND r.activeflag =1
			) a; 

   UPDATE routing SET activeflag =0 WHERE  objectid  = v_objectid AND eventcode = v_appeventcode AND activeflag =1;
   
   INSERT INTO routing(eventcode, fromsecurityusersid, tosecurityusersid, teamid, 
					   	fromroleid, toroleid, objectid , routingstatustypeid, activeflag,
					   	insertedby,  updatedby, insertedon, updatedon, isreviewrequest,
					   	servicerequestnumber, objecttypekey,routeddescription)
			SELECT  	v_appeventcode, v_fromuserid, rec.tosecurityusersid, rec.teamid, 
						l_fromroletypekey, rec.toroleid, v_objectid ,4 ,1,
						v_securityusersid, v_securityusersid, now(), now(), rec.isreviewrequest, 
						rec.servicerequestnumber, rec.objecttypekey, rec.routeddescription 
			FROM		json_to_recordset(l_assignuser) as rec 
											(	tosecurityusersid character varying
											,	servicerequestnumber character varying
											,	isreviewrequest bool
											, 	objecttypekey character varying
											, 	routeddescription text
											, 	toroleid character varying
											, 	teamid uuid
											);

	RETURN 'SUCCESS';
 
END;

$function$
;
