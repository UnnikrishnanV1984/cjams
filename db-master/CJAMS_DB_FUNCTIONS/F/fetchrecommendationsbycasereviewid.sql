DROP function if exists fetchrecommendationsbycasereviewid(uuid);

CREATE OR REPLACE FUNCTION cjams.fetchrecommendationsbycasereviewid(case_review_id uuid)
 RETURNS TABLE(reviewrecommendationid uuid, casereviewid uuid, recommendation character varying,
	            goalcompletedate timestamp, workerresponse character varying,
	            followup character varying, followupdate timestamp, insertedon timestamp,
            	insertedby character varying, updatedon timestamp, updatedby character varying,
	            activeflag integer, recommendationstatustypekey character varying,
                old_id character varying)
 LANGUAGE plpgsql
AS $function$

begin
	
	RETURN query
    SELECT rr.reviewrecommendationid, rr.casereviewid, rr.recommendation, rr.goalcompletedate, 
            rr.workerresponse, rr.followup, rr.followupdate, rr.insertedon, rr.insertedby,
            rr.updatedon, rr.updatedby, rr.activeflag, rr.recommendationstatustypekey, rr.old_id
    FROM reviewrecommendations rr
    WHERE rr.casereviewid = case_review_id and rr.activeflag=1;

END;

$function$
;
