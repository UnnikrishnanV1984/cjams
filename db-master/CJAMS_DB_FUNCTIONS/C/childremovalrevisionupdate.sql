drop FUNCTION if exists cjams.childremovalrevisionupdate(v_childremovalid uuid, v_exitdate timestamp without time zone, v_removalexitreason character varying, v_returntransts timestamp without time zone);

-- DROP FUNCTION cjams.childremovalrevisionupdate(v_childremovalid uuid, v_exitdate, v_removalexitreason, v_returntransts, v_transferagency, v_otherpublicagency, v_locationofadoption);

-- CREATE OR REPLACE FUNCTION cjams.childremovalrevisionupdate(v_childremovalid uuid, v_exitdate timestamp without time zone, v_removalexitreason character varying, v_returntransts timestamp without time zone, v_transferagency character varying, v_otherpublicagency character varying, v_locationofadoption character varying)
 DROP FUNCTION if exists cjams.childremovalrevisionupdate(v_childremovalid uuid, v_exitdate timestamp without time zone, v_removalexitreason character varying, v_returntransts timestamp without time zone, v_transferagency character varying, v_otherpublicagency character varying, v_locationofadoption character varying);
 DROP FUNCTION if exists cjams.childremovalrevisionupdate(v_childremovalid uuid, v_exitdate timestamp without time zone, v_removalexitreason character varying, v_returntransts timestamp without time zone, v_transferagency character varying, v_otherpublicagency character varying, v_locationofadoption character varying,v_childremovalluggage boolean ,v_luggageprovided boolean,v_luggagecomments character varying,v_placementdisposableortrashbag boolean);
CREATE OR REPLACE FUNCTION cjams.childremovalrevisionupdate(v_childremovalid uuid, v_exitdate timestamp without time zone, v_removalexitreason character varying, v_returntransts timestamp without time zone, v_transferagency character varying, v_otherpublicagency character varying, v_locationofadoption character varying,v_childremovalluggage boolean ,v_luggageprovided boolean,v_luggagecomments character varying,v_placementdisposableortrashbag boolean,v_luggageupdatedby character varying,v_luggageupdatedon timestamp)


 RETURNS text
 LANGUAGE plpgsql
AS $function$
------------------------------------------------------------------
--Revision(s)

-------------------------------------
-- Revision(s)
--03/13/2025-Veera - CIDM-10047-Child-Removal-table-returntime-column.
------------------------------------

--01/13/2025-CIDM-10008 -Smitha Somasekharan -changes for adding luggage indicator questions in childremoval
----------------------------------------------------------------------------
DECLARE
 
v_intakeservreqchildremovalhistoryid uuid;

BEGIN
	
	 INSERT INTO intakeservreqchildremoval_history 
     SELECT gen_random_uuid ()
      		, null
      		, 'REVISION'::character varying
            , *
     FROM intakeservreqchildremoval 
     WHERE intakeservreqchildremovalid = v_childremovalid
     RETURNING intakeservreqchildremovalhistoryid INTO v_intakeservreqchildremovalhistoryid;

     UPDATE cjams.intakeservreqchildremoval_history  
     SET exitdate = v_exitdate,
       returntime = v_exitdate,
     	 removalexitreason = v_removalexitreason,
     	 returntransts = v_returntransts,
       transferagency = v_transferagency,
       otherpublicagency = v_otherpublicagency,
       locationofadoption = v_locationofadoption,
       childremovalluggage =v_childremovalluggage,
       luggageprovided =v_luggageprovided,
       luggagecomments =v_luggagecomments,
       placementdisposableortrashbag =v_placementdisposableortrashbag,
       luggageupdatedby =v_luggageupdatedby,
       luggageupdatedon =v_luggageupdatedon
     WHERE intakeservreqchildremovalhistoryid = v_intakeservreqchildremovalhistoryid;
	
RETURN 'Success';
		
END;
$function$
;