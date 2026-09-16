DROP FUNCTION IF EXISTS cjams.gethearingdetails(v_objecttypekey character varying, v_objectid uuid);
CREATE OR REPLACE FUNCTION cjams.gethearingdetails(v_objecttypekey character varying, v_objectid uuid)
 RETURNS json
 LANGUAGE plpgsql
AS $function$                                                                                                                                                                                                                                                                                                                                                                           
  DECLARE l_hearing json;                                                                                                                                                                                                                                                                                                                                                                                     
 BEGIN     

 	SELECT json_agg(t) INTO l_hearing FROM (
		SELECT (
			SELECT jsonb_build_object
				( 	'intakeservicerequestpetitionid', ich.intakeservicerequestpetitionid
				, 	'petitionid', COALESCE(petitionid, ich.courtcasenumber)
				, 	'intakeservicerequestpetitionactor',
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
		 , *
		 ,	CASE WHEN COALESCE(ch.hearingstatustypekey,'') IN ('CONCULD','DISMIS') THEN true ELSE false END ::bool isconcluded
		 FROM intakeservicerequestcourthearing ch 
		 WHERE  CASE LOWER(v_objecttypekey) WHEN 'servicecase' THEN ch.servicecaseid = v_objectid ELSE ch.intakeserviceid = v_objectid END 
	 ) t ;
	 RETURN l_hearing;
 END;                                                                                                                                                                                                                                                                                                                                                                                  
                                                                                                                                                                                                                                                                                                                                                                                       
 $function$
;
