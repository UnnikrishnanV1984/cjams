DROP FUNCTION IF EXISTS cjams.getsubmissiondetails(character varying);
CREATE OR REPLACE FUNCTION cjams.getsubmissiondetails(v_submissionid character varying)
 RETURNS SETOF json
 LANGUAGE plpgsql
AS $function$

BEGIN

RETURN query
 
SELECT 
    json_object_agg (
        ass.datakey,   
    	CASE ass.iscollection 
		WHEN 1 THEN 
			(SELECT
				(SELECT json_agg(json_object_agg) 
					FROM 
					(
						SELECT json_object_agg(sc.datakey,sc.datavalue )  
						FROM submissioncollection sc
						INNER JOIN assessment a ON ass.assessmentid=a.assessmentid AND a.activeflag=1
						WHERE ass.assessmentsubmissionid=sc.assessmentsubmissionid AND ass.iscollection=1
						--AND sc.datakey is not null
						GROUP BY sc.dataindex  
					)json_object_agg
				)
			)::VARCHAR 
    	WHEN 2 THEN  
			(SELECT
				(SELECT json_object_agg(sc.datakey,sc.datavalue) 
				 FROM  submissioncollection sc
				 		INNER JOIN assessment a ON ass.assessmentid=a.assessmentid AND a.activeflag=1
				 WHERE ass.assessmentsubmissionid=sc.assessmentsubmissionid AND ass.iscollection=2
				 --AND sc.datakey is not null
				 GROUP BY sc.dataindex  
				)
			)::VARCHAR
		WHEN 3 THEN  
			(SELECT json_build_object (
				ass.datavalue,
				(SELECT json_agg(json_object_agg) 
					FROM 
					(SELECT json_object_agg(sc.datakey,sc.datavalue) 
					 FROM  submissioncollection sc
							INNER JOIN assessment a ON ass.assessmentid=a.assessmentid AND a.activeflag=1
					 WHERE ass.assessmentsubmissionid=sc.assessmentsubmissionid AND ass.iscollection=3
					 GROUP BY sc.dataindex  
					)json_object_agg
				) )::VARCHAR)
		WHEN 4 THEN  
			(SELECT json_agg(json_object_agg) 
			 FROM	(SELECT json_object_agg(sc.datakey,sc.datavalue) 
					 FROM  submissioncollection sc
							INNER JOIN assessment a ON ass.assessmentid=a.assessmentid AND a.activeflag=1
					 WHERE ass.assessmentsubmissionid=sc.assessmentsubmissionid AND ass.iscollection=4
					 --AND sc.datakey is not null
					 GROUP BY sc.dataindex ) json_object_agg
			 )::VARCHAR 
		ELSE ass.datavalue::VARCHAR END
	)
FROM assessmentsubmission ass
WHERE ass.submissionid=v_submissionid and ass.datakey is not null and ass.activeflag=1
--and ass.datakey is not null
--group by ass.insertedon
--order by ass.insertedon desc
--limit 1
;       
END;

$function$
;
