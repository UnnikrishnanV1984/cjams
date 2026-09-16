drop function if exists cjams.reviewrecommendationsaddupdate(reviewrecommendation json, v_securityusersid character varying);
CREATE OR REPLACE FUNCTION cjams.reviewrecommendationsaddupdate(reviewrecommendation json, v_securityusersid character varying)
 RETURNS character varying
 LANGUAGE plpgsql
AS $function$ 

DECLARE 

v_reviewrecommendation json;
v_insertedby character varying;
v_reviewrecommendationid uuid;

BEGIN

v_insertedby := v_securityusersid;
v_reviewrecommendation := reviewrecommendation;

IF (v_reviewrecommendation ->> 'reviewrecommendationid') IS NULL THEN 

INSERT INTO reviewrecommendations(reviewrecommendationid ,
			casereviewid,
			recommendation ,
	        goalcompletedate ,
	        workerresponse ,
	        followup,
	        followupdate,
	        insertedon,
	        insertedby,
	        updatedon,
	        updatedby,
			recommendationstatustypekey)
		VALUES ( gen_random_uuid(),
		(v_reviewrecommendation ->> 'casereviewid') :: uuid ,
		v_reviewrecommendation ->>'recommendation',
		(v_reviewrecommendation ->>'goalcompletedate') ::timestamp ,
		v_reviewrecommendation ->> 'workerresponse',
		v_reviewrecommendation ->> 'followup',
		(v_reviewrecommendation ->> 'followupdate') ::timestamp ,
		now(),
        v_insertedby,
		now(),
        v_insertedby ,
		v_reviewrecommendation ->> 'recommendationstatustypekey');
ELSE
	
	select reviewrecommendationid into v_reviewrecommendationid from reviewrecommendations 
	where (casereviewid :: uuid =(v_reviewrecommendation ->> 'casereviewid') :: uuid )
	order by v_securityusersid desc fetch first row only ;
	UPDATE reviewrecommendations SET activeflag = 1,			
 						--	casereviewid =	v_reviewrecommendation ->> 'casereviewid',
							recommendation = v_reviewrecommendation ->> 'recommendation',
							goalcompletedate = (v_reviewrecommendation ->> 'goalcompletedate'):: timestamp, 
							workerresponse = v_reviewrecommendation ->> 'workerresponse',
							followup =	v_reviewrecommendation ->> 'followup',
							followupdate =( v_reviewrecommendation ->> 'followupdate'):: timestamp, 
						--	insertedon = v_reviewrecommendation ->> 'insertedon',
						--	insertedby = v_reviewrecommendation ->> 'insertedby',
							updatedon = now(),
							updatedby = v_insertedby ,
						--	activeflag	= v_reviewrecommendation ->> 'activeflag',	
							recommendationstatustypekey	= v_reviewrecommendation ->> 'recommendationstatustypekey'
					where reviewrecommendationid = v_reviewrecommendationid;
END IF;
    RETURN 'SUCCESS';
END 
$function$
;
