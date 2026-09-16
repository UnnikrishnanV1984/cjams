 DROP FUNCTION IF EXISTS cjams.addchessierequestlog(v_logdata jsonb);
 CREATE OR REPLACE FUNCTION cjams.addchessierequestlog(v_logdata jsonb, v_userid character varying, v_requestid character varying)
  RETURNS text                                                                                                                                                                                                                                                                                                                                              
  LANGUAGE plpgsql                                                                                                                                                                                                                                                                                                                                          
 AS $function$                                                                                                                                                                                                                                                                                                                                              
 
 DECLARE
 	v_status text;
                                                                                                                                                                                                                                                                                                                                          
 BEGIN

	IF (v_requestid IS NOT NULL) THEN
		UPDATE cjams.chessierequestlog
			SET response=v_logdata, updatedby=v_userid, updatedon=now()
		WHERE id::character varying = v_requestid;
	ELSE
		INSERT INTO cjams.chessierequestlog(id, request, insertedby,updatedby,insertedon,updatedon)
			VALUES(gen_random_uuid(), v_logdata, v_userid,v_userid, now(), now())
		RETURNING "id" INTO v_requestid;
	END IF;

	v_status:='success';

 RETURN v_requestid::CHARACTER VARYING;
 END;
 $function$