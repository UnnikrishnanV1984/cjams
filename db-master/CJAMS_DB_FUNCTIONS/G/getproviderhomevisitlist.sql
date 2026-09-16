drop function if exists getproviderhomevisitlist(character varying);
CREATE OR REPLACE FUNCTION cjams.getproviderhomevisitlist(v_applicationid character varying)
 RETURNS TABLE(home_study_visit_id uuid, object_id character varying, narrative character varying, interview_date date, interview_start_time timestamp without time zone, interview_end_time timestamp without time zone, duration numeric, interview_location character varying, personid jsonb, personname jsonb, islocationhome boolean)
 LANGUAGE plpgsql
AS $function$

BEGIN

RETURN Query
		

select pphsv.home_study_visit_id,pphsv.object_id, pphsv.narrative, 
pphsv.interview_date, pphsv.interview_start_time, pphsv.interview_end_time,
pphsv.duration, pphsv.interview_location,
(SELECT Json_agg(personnames) 
			FROM (SELECT p.personid		
					FROM publicproviderhomestudyhouseholdmapping pphsvm
					left join person p on p.personid=pphsvm.personid 					
					WHERE pphsvm.home_study_visit_id = pphsv.home_study_visit_id 
					and pphsvm.active_flag=1
					)
					personnames) :: jsonb AS personid,
	(SELECT Json_agg(personnames) 
			FROM (SELECT 
			(trim( p.firstname ) || ' ' || trim( p.lastname ))::CHARACTER VARYING personname		
					FROM publicproviderhomestudyhouseholdmapping pphsvm
					left join person p on p.personid=pphsvm.personid 					
					WHERE pphsvm.home_study_visit_id = pphsv.home_study_visit_id 
					and pphsvm.active_flag=1
					)
					personnames) :: jsonb AS personname,pphsv.islocationhome

from 
publicproviderhomestudyvisit pphsv
where pphsv.object_id=v_applicationid
and pphsv.active_flag=1
order by pphsv.create_ts desc;

	
    
END;

$function$;
