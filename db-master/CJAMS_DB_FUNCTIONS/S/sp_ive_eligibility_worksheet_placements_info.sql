Drop function if exists cjams.sp_ive_eligibility_worksheet_placements(json);

CREATE OR REPLACE FUNCTION cjams.sp_ive_eligibility_worksheet_placements(reqobj json)
 RETURNS void
 LANGUAGE plpgsql
AS $function$ 

--------------------------------------------
-- B-97901 SILA Placement changes Veera 11-08
--------------------------------------------

DECLARE
	v_clientid bigint;
  	v_removalid bigint;
	v_count bigint;
	v_periodtype varchar;
	v_islapsesinplacement  varchar;
  	v_typeoflapses varchar;
	v_kindoflapses varchar;
	v_placementid uuid;
	v_securityuserid uuid;
	v_placement json;
BEGIN

		v_clientid := reqObj ->> 'clientid';
	  	v_removalid := reqObj ->> 'removalid';
	  	v_periodtype := reqObj ->> 'periodtype';
	  	v_islapsesinplacement := reqObj ->> 'islapsesinplacement';
		v_typeoflapses := reqObj ->> 'typeoflapses';
		v_kindoflapses := reqObj ->> 'kindoflapses';
		v_securityuserid := reqObj ->> 'securityuserid';
		v_placement := reqObj ->> 'silaplacementchange';

		SELECT count(*) INTO v_count FROM tb_foster_care_placement tp WHERE tp.clientid = v_clientid and tp.removalid=v_removalid and tp.periodtype=v_periodtype;

		IF (v_count) = 0
		THEN
				INSERT 
				INTO tb_foster_care_placement(clientid, 
								removalid,
								periodtype,
								islapsesinplacement,
								typeoflapses,
								kindoflapses,
								silaplacementchange,
								insertedby,
								updatedby, 
								insertedon,
								updatedon) 
						VALUES( 
						        v_clientid,
							    v_removalid,
							    v_periodtype,
							    v_islapsesinplacement,
								v_typeoflapses,
								v_kindoflapses,
								v_placement,
								v_securityuserid,
								v_securityuserid, 
								current_timestamp,
								current_timestamp);
		ELSE		
				UPDATE tb_foster_care_placement tp	
				SET 	                 
					 islapsesinplacement = v_islapsesinplacement,
					 typeoflapses = v_typeoflapses,
					 silaplacementchange = v_placement,
					 kindoflapses = v_kindoflapses, updatedby = v_securityuserid,
					 updatedon = current_timestamp
				WHERE tp.clientid = v_clientid and tp.removalid=v_removalid and tp.periodtype=v_periodtype;
				  
		END IF;	
END;
	
$function$
;
