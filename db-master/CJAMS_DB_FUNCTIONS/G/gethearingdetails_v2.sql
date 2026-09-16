DROP FUNCTION IF EXISTS cjams.gethearingdetails_v2( character varying, uuid);
DROP FUNCTION IF EXISTS cjams.gethearingdetails_v2( character varying,  uuid,integer,character varying);
DROP FUNCTION IF EXISTS cjams.gethearingdetails_v2( character varying,  uuid,integer,character varying, integer);
DROP FUNCTION IF EXISTS cjams.gethearingdetails_v2( character varying,  uuid,integer, integer);
CREATE OR REPLACE FUNCTION cjams.gethearingdetails_v2(v_objecttypekey character varying, v_objectid uuid, v_isExpungementSuperUser integer, isexpunged integer DEFAULT 0::integer)
 RETURNS json
 LANGUAGE plpgsql
AS $function$      
------------------------------------------------------------------------------------------
--Revisions
--Smitha S - 12/1/2022 - Modifications for CIDM-6076, add dob to hearingclient
--Manasa Kasula - 05/14/2026 - CIDM-11351: Fix to fetch if the hearing client has any active court order consent.
--Surya Arigela 06/05/2026  - CIDM-11401: B-240648 Refinement to TPR - Termination of Parental Rights
--Surya Arigela 06/12/2026  - CIDM-11401: B-240648 Termination of Parental Rights (To determine if Courtorder is created or not)
--Surya Arigela 07/14/2026  - CIDM-11401: B-240648 fix for retrieving hearing parents
------------------------------------------------------------------------------------------                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          
  DECLARE l_hearing json;  
 datechangeofpermanency json; 
 v_isexpunged integer;

 BEGIN  
	v_isexpunged = 0;
	IF v_isExpungementSuperUser= 1 THEN
		v_isexpunged = isexpunged;
	END IF;

    IF v_isexpunged = 1 THEN 

            --------------------------------------------------------------------
            -- FULLY EXPUNGED CASE: existing ENCRYPTED logic (expunge.* tables)
            --------------------------------------------------------------------
			SELECT json_agg(t) INTO l_hearing FROM (
				SELECT (
					SELECT jsonb_build_object
						( 	'intakeservicerequestpetitionid', ich.intakeservicerequestpetitionid
						, 	'petitionid', COALESCE(petitionid, ich.courtcasenumber)
							,'datechangeofpermanency', datechangeofpermanency,
							'intakeservicerequestpetitionactor',
							COALESCE((SELECT json_agg(
									jsonb_build_object(	
									'intakeservicerequestpetitionactorid',intakeservicerequestpetitionactorid
									, 'intakeservicerequestactorid',intakeservicerequestactorid
									, 'petitionactortype',petitionactortype
									, 'Intakeservicerequestpetitionid',Intakeservicerequestpetitionid
									, 'intakeservicerequestactorid',intakeservicerequestactorid
									, 'intakeservicerequestactor',
									(SELECT jsonb_build_object(
											'intakeservicerequestactorid',intakeservicerequestactorid
											, 'personid',personid 
											, 'person',
											(SELECT jsonb_build_object(
														'firstname',firstname
													,  'lastname',lastname
													,  'personid',personid
													,  'cjamspid',cjamspid ::character varying,
													'fullname',concat_ws(' ',coalesce(p.prefx,null),coalesce(p.firstname,null),coalesce(p.middlename,null),coalesce(p.lastname,null),coalesce(p.suffix,null) ):: character varying)
											FROM person p 
											WHERE p.personid = isra.personid AND p.activeflag =1 LIMIT 1)
										)
									FROM expunge.intakeservicerequestactor_expunge isra 
									WHERE isra.intakeservicerequestactorid=pa.intakeservicerequestactorid AND isra.activeflag =1 LIMIT 1)
									)
								)
						FROM intakeservicerequestpetitionactor pa
						WHERE pa.intakeservicerequestpetitionid =ch.intakeservicerequestpetitionid and pa.activeflag=1), '[]')
					) intakeservicerequestpetition
					FROM intakeservicerequestcourthearing ich
						LEFT JOIN intakeservicerequestpetition ip ON ich.intakeservicerequestpetitionid = ip.intakeservicerequestpetitionid
					WHERE ich.intakeservicerequestcourthearingid = ch.intakeservicerequestcourthearingid LIMIT 1)
				,	
				
				--SIMAR hearing client details here
				(SELECT 
					json_agg(
						jsonb_build_object(	
								'hearingclientid', hc.hearingclientid
								, 'personid', hc.personid
								, 'casenumber', hc.courtcasenotx
								, 'clientname', concat_ws(' ', p.prefx,p.firstname,p.middlename,p.lastname,p.suffix)
								, 'otherclientflag', hc.otherclientflag
								, 'annualnoticebenefitdt', hc.annualnoticebenefitdt
								, 'intakeservicerequestactorid', (select isra.intakeservicerequestactorid from expunge.intakeservicerequestactor_expunge isra 
									where isra.personid = hc.personid and (isra.servicecaseid = ich.servicecaseid or isra.intakeserviceid = ich.intakeserviceid) limit 1)		
									, 'dob', p.dob
						)
					 ORDER BY hc.otherclientflag ASC, concat_ws(' ', p.prefx,p.firstname,p.middlename,p.lastname,p.suffix) ASC
					) hearingclientdetails
				FROM intakeservicerequestcourthearing ich
				JOIN hearingclients hc ON hc.courthearingid = ich.intakeservicerequestcourthearingid
				JOIN person p on p.personid = hc.personid
				WHERE ich.intakeservicerequestcourthearingid = ch.intakeservicerequestcourthearingid and hc.activeflag = 1 and ich.activeflag = 1)
				--END	
                ,
                (
                    SELECT COALESCE(json_agg(parent_data), '[]'::json) hearingparents
                    FROM (
                        SELECT jsonb_build_object(
                              'intakeservicerequestactorid', ch.parent1actorid
                            , 'petitionactortype', 'PARENT1'
                            , 'personid', ch.parent1personid
                            , 'name', ch.parent1name
                            , 'unknown', ch.parent1unknown
                        ) AS parent_data
                        WHERE ch.parent1actorid IS NOT NULL
                           OR ch.parent1personid IS NOT NULL
                           OR ch.parent1name IS NOT NULL
                           OR COALESCE(ch.parent1unknown, false) = true

                        UNION ALL

                        SELECT jsonb_build_object(
                              'intakeservicerequestactorid', ch.parent2actorid
                            , 'petitionactortype', 'PARENT2'
                            , 'personid', ch.parent2personid
                            , 'name', ch.parent2name
                            , 'unknown', ch.parent2unknown
                        ) AS parent_data
                        WHERE ch.parent2actorid IS NOT NULL
                           OR ch.parent2personid IS NOT NULL
                           OR ch.parent2name IS NOT NULL
                           OR COALESCE(ch.parent2unknown, false) = true
                    ) parents
                )
				, ch.*
				,	CASE WHEN COALESCE(ch.hearingstatustypekey,'') IN ('CONCULD','DISMIS') THEN true ELSE false END ::bool isconcluded,
                EXISTS (
                    SELECT 1
                    FROM cjams.intakeservreqcourtorder co
                    JOIN cjams.tprdetails td
                      ON td.intakeservreqcourtorderid = co.intakeservicerequestpetitionid
                     AND td.activeflag = 1
                    WHERE co.intakeservicerequesthearingid = ch.intakeservicerequestcourthearingid
                      AND co.activeflag = 1
                ) AS istprcourtordercreated,
				(select string_agg(TO_CHAR(mr.meetingdate, 'mm/dd/yyyy')::varchar,',' order by mr.meetingdate desc) from meetingrecording mr
				inner join meetingrecordinghearingdetail mrhd on mrhd.meetingrecordingid =mr.meetingrecordingid and mrhd.activeflag =1
			where	
					mrhd.intakeservicerequestcourthearingid = ch.intakeservicerequestcourthearingid
					and mrhd.activeflag = 1 ) as datechangeofpermanency
				FROM intakeservicerequestcourthearing ch 
				-- left join meetingrecordinghearingdetail mrhd on mrhd.intakeservicerequestcourthearingid =ch.intakeservicerequestcourthearingid  and mrhd.activeflag=1
		--		 left join meetingrecording mr on mr.meetingrecordingid= (select mrhd.meetingrecordingid from meetingrecordinghearingdetail mrhd
		--		  where mrhd.intakeservicerequestcourthearingid =ch.intakeservicerequestcourthearingid  and mrhd.activeflag=1 order by mrhd.insertedon  desc limit 1)
				WHERE  CASE LOWER(v_objecttypekey) WHEN 'servicecase' THEN ch.servicecaseid = v_objectid ELSE ch.intakeserviceid = v_objectid END  
				and ch.activeflag = 1
			) t ;
		
	ELSIF v_isexpunged = 2 THEN 
		----------------------------------------------------------------------------
		--Partial expungement
        -----------------------------------------------------------------------------
			SELECT json_agg(t) INTO l_hearing FROM (
				SELECT (
					SELECT jsonb_build_object
						( 	'intakeservicerequestpetitionid', ich.intakeservicerequestpetitionid
						,   'petitionid', COALESCE(petitionid, ich.courtcasenumber)
, 'petitiontypekey', ip.petitiontypekey
, 'datechangeofpermanency', datechangeofpermanency,
							'intakeservicerequestpetitionactor',
							COALESCE((SELECT json_agg(
									jsonb_build_object(	
									'intakeservicerequestpetitionactorid',intakeservicerequestpetitionactorid
									, 'intakeservicerequestactorid',intakeservicerequestactorid
									, 'petitionactortype',petitionactortype
									, 'Intakeservicerequestpetitionid',Intakeservicerequestpetitionid
									, 'intakeservicerequestactorid',intakeservicerequestactorid
									, 'intakeservicerequestactor',
									(SELECT jsonb_build_object(
											'intakeservicerequestactorid',intakeservicerequestactorid
											, 'personid',personid 
											, 'person',
											(SELECT jsonb_build_object(
														'firstname',firstname
													,  'lastname',lastname
													,  'personid',personid
													,  'cjamspid',cjamspid ::character varying,
													'fullname',concat_ws(' ',coalesce(p.prefx,null),coalesce(p.firstname,null),coalesce(p.middlename,null),coalesce(p.lastname,null),coalesce(p.suffix,null) ):: character varying)
											FROM person p 
											WHERE p.personid = isra.personid AND p.activeflag =1 LIMIT 1)
										)
									FROM expunge.intakeservicerequestactor_expunge isra 
									WHERE isra.intakeservicerequestactorid=pa.intakeservicerequestactorid AND isra.activeflag =1
									UNION
									SELECT jsonb_build_object(
											'intakeservicerequestactorid',intakeservicerequestactorid
											, 'personid',personid 
											, 'person',
											(SELECT jsonb_build_object(
														'firstname',firstname
													,  'lastname',lastname
													,  'personid',personid
													,  'cjamspid',cjamspid ::character varying,
													'fullname',concat_ws(' ',coalesce(p.prefx,null),coalesce(p.firstname,null),coalesce(p.middlename,null),coalesce(p.lastname,null),coalesce(p.suffix,null) ):: character varying)
											FROM person p 
											WHERE p.personid = isra.personid AND p.activeflag =1 LIMIT 1)
										)
									FROM intakeservicerequestactor isra 
									WHERE isra.intakeservicerequestactorid=pa.intakeservicerequestactorid AND isra.activeflag =1
									LIMIT 1
									)
									)
								)
						FROM intakeservicerequestpetitionactor pa
						WHERE pa.intakeservicerequestpetitionid =ch.intakeservicerequestpetitionid and pa.activeflag=1), '[]')
					) intakeservicerequestpetition
					FROM intakeservicerequestcourthearing ich
						LEFT JOIN intakeservicerequestpetition ip ON ich.intakeservicerequestpetitionid = ip.intakeservicerequestpetitionid
					WHERE ich.intakeservicerequestcourthearingid = ch.intakeservicerequestcourthearingid LIMIT 1)
				,	
				
				--SIMAR hearing client details here
				(SELECT 
					json_agg(
						jsonb_build_object(	
								'hearingclientid', hc.hearingclientid
								, 'personid', hc.personid
								, 'casenumber', hc.courtcasenotx
								, 'clientname', concat_ws(' ', p.prefx,p.firstname,p.middlename,p.lastname,p.suffix)
								, 'otherclientflag', hc.otherclientflag
								, 'annualnoticebenefitdt', hc.annualnoticebenefitdt
								, 'intakeservicerequestactorid', (select isra.intakeservicerequestactorid from expunge.intakeservicerequestactor_expunge isra 
									where isra.personid = hc.personid and (isra.servicecaseid = ich.servicecaseid or isra.intakeserviceid = ich.intakeserviceid)
									UNION 
									select isra.intakeservicerequestactorid from intakeservicerequestactor isra 
									where isra.personid = hc.personid and (isra.servicecaseid = ich.servicecaseid or isra.intakeserviceid = ich.intakeserviceid) limit 1
									)		
									, 'dob', p.dob
						)
					 ORDER BY hc.otherclientflag ASC, concat_ws(' ', p.prefx,p.firstname,p.middlename,p.lastname,p.suffix) ASC
					) hearingclientdetails
				FROM intakeservicerequestcourthearing ich
				JOIN hearingclients hc ON hc.courthearingid = ich.intakeservicerequestcourthearingid
				JOIN person p on p.personid = hc.personid
				WHERE ich.intakeservicerequestcourthearingid = ch.intakeservicerequestcourthearingid and hc.activeflag = 1 and ich.activeflag = 1)
                ,
                (
                    SELECT COALESCE(json_agg(parent_data), '[]'::json) hearingparents
                    FROM (
                        SELECT jsonb_build_object(
                              'intakeservicerequestactorid', ch.parent1actorid
                            , 'petitionactortype', 'PARENT1'
                            , 'personid', ch.parent1personid
                            , 'name', ch.parent1name
                            , 'unknown', ch.parent1unknown
                        ) AS parent_data
                        WHERE ch.parent1actorid IS NOT NULL
                           OR ch.parent1personid IS NOT NULL
                           OR ch.parent1name IS NOT NULL
                           OR COALESCE(ch.parent1unknown, false) = true

                        UNION ALL

                        SELECT jsonb_build_object(
                              'intakeservicerequestactorid', ch.parent2actorid
                            , 'petitionactortype', 'PARENT2'
                            , 'personid', ch.parent2personid
                            , 'name', ch.parent2name
                            , 'unknown', ch.parent2unknown
                        ) AS parent_data
                        WHERE ch.parent2actorid IS NOT NULL
                           OR ch.parent2personid IS NOT NULL
                           OR ch.parent2name IS NOT NULL
                           OR COALESCE(ch.parent2unknown, false) = true
                    ) parents
                )
				, ch.*
				,	CASE WHEN COALESCE(ch.hearingstatustypekey,'') IN ('CONCULD','DISMIS') THEN true ELSE false END ::bool isconcluded,
                EXISTS (
                    SELECT 1
                    FROM cjams.intakeservreqcourtorder co
                    JOIN cjams.tprdetails td
                      ON td.intakeservreqcourtorderid = co.intakeservicerequestpetitionid
                     AND td.activeflag = 1
                    WHERE co.intakeservicerequesthearingid = ch.intakeservicerequestcourthearingid
                      AND co.activeflag = 1
                ) AS istprcourtordercreated,
				(select string_agg(TO_CHAR(mr.meetingdate, 'mm/dd/yyyy')::varchar,',' order by mr.meetingdate desc) from meetingrecording mr
				inner join meetingrecordinghearingdetail mrhd on mrhd.meetingrecordingid =mr.meetingrecordingid and mrhd.activeflag =1
			where	
					mrhd.intakeservicerequestcourthearingid = ch.intakeservicerequestcourthearingid
					and mrhd.activeflag = 1 ) as datechangeofpermanency
				FROM intakeservicerequestcourthearing ch 
				WHERE  CASE LOWER(v_objecttypekey) WHEN 'servicecase' THEN ch.servicecaseid = v_objectid ELSE ch.intakeserviceid = v_objectid END  
				and ch.activeflag = 1
			) t ;

	ELSE   

 	SELECT json_agg(t) INTO l_hearing FROM (
		SELECT (
			SELECT jsonb_build_object
				( 	'intakeservicerequestpetitionid', ich.intakeservicerequestpetitionid
				, 	'petitionid', COALESCE(petitionid, ich.courtcasenumber)
				, 'petitiontypekey', ip.petitiontypekey
					,'datechangeofpermanency', datechangeofpermanency,
					'intakeservicerequestpetitionactor',
					COALESCE((SELECT json_agg(
							jsonb_build_object(	
							  'intakeservicerequestpetitionactorid',intakeservicerequestpetitionactorid
							, 'intakeservicerequestactorid',intakeservicerequestactorid
							, 'petitionactortype',petitionactortype
							, 'Intakeservicerequestpetitionid',Intakeservicerequestpetitionid
							, 'intakeservicerequestactorid',intakeservicerequestactorid
							, 'intakeservicerequestactor',
							  (SELECT jsonb_build_object(
									  'intakeservicerequestactorid',intakeservicerequestactorid
									, 'personid',personid 
									, 'person',
									  (SELECT jsonb_build_object(
												'firstname',firstname
											 ,  'lastname',lastname
											 ,  'personid',personid
											 ,  'cjamspid',cjamspid ::character varying,
											 'fullname',concat_ws(' ',coalesce(p.prefx,null),coalesce(p.firstname,null),coalesce(p.middlename,null),coalesce(p.lastname,null),coalesce(p.suffix,null) ):: character varying)
									   FROM person p 
									   WHERE p.personid =isra.personid AND p.activeflag =1 LIMIT 1)
									  )
							   FROM intakeservicerequestactor isra 
							   WHERE isra.intakeservicerequestactorid=pa.intakeservicerequestactorid AND isra.activeflag =1 LIMIT 1)
							  )
						)
				   FROM intakeservicerequestpetitionactor pa
				   WHERE pa.intakeservicerequestpetitionid =ch.intakeservicerequestpetitionid and pa.activeflag=1), '[]')
			   ) intakeservicerequestpetition
			FROM intakeservicerequestcourthearing ich
				 LEFT JOIN intakeservicerequestpetition ip ON ich.intakeservicerequestpetitionid = ip.intakeservicerequestpetitionid
			WHERE ich.intakeservicerequestcourthearingid = ch.intakeservicerequestcourthearingid LIMIT 1)
		,	
		
		--SIMAR hearing client details here
		(SELECT 
			json_agg(
				jsonb_build_object(	
						  'hearingclientid', hc.hearingclientid
						, 'personid', hc.personid
						, 'casenumber', hc.courtcasenotx
						, 'clientname', concat_ws(' ', p.prefx,p.firstname,p.middlename,p.lastname,p.suffix)
                        , 'otherclientflag', hc.otherclientflag
                        , 'annualnoticebenefitdt', hc.annualnoticebenefitdt
						, 'intakeservicerequestactorid', (select isra.intakeservicerequestactorid from intakeservicerequestactor isra 
							where isra.personid = hc.personid and (isra.servicecaseid = ich.servicecaseid or isra.intakeserviceid = ich.intakeserviceid) limit 1)		
							 , 'dob', p.dob
				)
			 ORDER BY hc.otherclientflag ASC, concat_ws(' ', p.prefx,p.firstname,p.middlename,p.lastname,p.suffix) ASC
					) hearingclientdetails
		FROM intakeservicerequestcourthearing ich
		JOIN hearingclients hc ON hc.courthearingid = ich.intakeservicerequestcourthearingid
		JOIN person p on p.personid = hc.personid
		WHERE ich.intakeservicerequestcourthearingid = ch.intakeservicerequestcourthearingid and hc.activeflag = 1 and ich.activeflag = 1)
		--END	

        ,
        (
            SELECT COALESCE(json_agg(parent_data), '[]'::json) hearingparents
            FROM (
                SELECT jsonb_build_object(
                      'intakeservicerequestactorid', ch.parent1actorid
                    , 'petitionactortype', 'PARENT1'
                    , 'personid', ch.parent1personid
                    , 'name', ch.parent1name
                    , 'unknown', ch.parent1unknown
                ) AS parent_data
                WHERE ch.parent1actorid IS NOT NULL
                   OR ch.parent1personid IS NOT NULL
                   OR ch.parent1name IS NOT NULL
                   OR COALESCE(ch.parent1unknown, false) = true

                UNION ALL

                SELECT jsonb_build_object(
                      'intakeservicerequestactorid', ch.parent2actorid
                    , 'petitionactortype', 'PARENT2'
                    , 'personid', ch.parent2personid
                    , 'name', ch.parent2name
                    , 'unknown', ch.parent2unknown
                ) AS parent_data
                WHERE ch.parent2actorid IS NOT NULL
                   OR ch.parent2personid IS NOT NULL
                   OR ch.parent2name IS NOT NULL
                   OR COALESCE(ch.parent2unknown, false) = true
            ) parents
        )
		 , ch.*
		 ,	CASE WHEN COALESCE(ch.hearingstatustypekey,'') IN ('CONCULD','DISMIS') THEN true ELSE false END ::bool isconcluded,
                EXISTS (
                    SELECT 1
                    FROM cjams.intakeservreqcourtorder co
                    JOIN cjams.tprdetails td
                      ON td.intakeservreqcourtorderid = co.intakeservicerequestpetitionid
                     AND td.activeflag = 1
                    WHERE co.intakeservicerequesthearingid = ch.intakeservicerequestcourthearingid
                      AND co.activeflag = 1
                ) AS istprcourtordercreated,
		  (select string_agg(TO_CHAR(mr.meetingdate, 'mm/dd/yyyy')::varchar,',' order by mr.meetingdate desc) from meetingrecording mr
		inner join meetingrecordinghearingdetail mrhd on mrhd.meetingrecordingid =mr.meetingrecordingid and mrhd.activeflag =1
	where	
			mrhd.intakeservicerequestcourthearingid = ch.intakeservicerequestcourthearingid
			and mrhd.activeflag = 1 ) as datechangeofpermanency
		 FROM intakeservicerequestcourthearing ch 
		 -- left join meetingrecordinghearingdetail mrhd on mrhd.intakeservicerequestcourthearingid =ch.intakeservicerequestcourthearingid  and mrhd.activeflag=1
--		 left join meetingrecording mr on mr.meetingrecordingid= (select mrhd.meetingrecordingid from meetingrecordinghearingdetail mrhd
--		  where mrhd.intakeservicerequestcourthearingid =ch.intakeservicerequestcourthearingid  and mrhd.activeflag=1 order by mrhd.insertedon  desc limit 1)
		 WHERE  CASE LOWER(v_objecttypekey) WHEN 'servicecase' THEN ch.servicecaseid = v_objectid ELSE ch.intakeserviceid = v_objectid END  
		 and ch.activeflag = 1
	 ) t ;
	 END IF;
	 RETURN l_hearing;
 END;                                                                                                                                                                                                                                                                                                                                                                                  
                                                                                                                                                                                                                                                                                                                                                                                       
 $function$
;
