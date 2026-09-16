DROP FUNCTION IF EXISTS cjams.updateprogressnote(uuid);

Drop Function if EXISTS cjams.updateprogressnote(v_progressnoteid uuid);
CREATE OR REPLACE FUNCTION cjams.updateprogressnote(v_progressnoteid uuid, v_securityusersid character varying)
    RETURNS text
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE 
AS $BODY$

DECLARE 

BEGIN

    UPDATE contactparticipant set activeflag =0, updatedby = v_securityusersid, updatedon = now()
    WHERE  progressnoteid = v_progressnoteid;

     RETURN 'Success';
END;

$BODY$;