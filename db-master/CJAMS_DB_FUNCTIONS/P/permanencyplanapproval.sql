 DROP FUNCTION IF EXISTS  cjams.permanencyplanapproval(v_securityuserid character varying, v_objectid character varying, v_status integer);
CREATE OR REPLACE FUNCTION cjams.permanencyplanapproval(v_securityuserid character varying, v_objectid character varying, v_status integer, v_routingid uuid DEFAULT null)
 RETURNS character varying
 LANGUAGE plpgsql
AS $function$                                                                                                                     
 
 DECLARE                                                                                                                           
v_permanencyplanid uuid;                                                                                                       
v_intakeservicerequestactorid uuid;
v_intakeserviceid uuid;
v_placementid uuid;
v_servicecaseid uuid;
v_projecteddate timestamp;
v_permanencyplanremainssame boolean; 
v_establisheddate timestamp;
v_enddate timestamp ;  
v_caseworkername character varying;
v_currentstatus character varying;
                                                                                                                                   
 BEGIN                                                                                                                             
                                                                                                                                   
                                                                                                        
	RAISE  NOTICE  'v_status  %',v_status;
	RAISE  NOTICE  'v_permanencyplanid  %',v_objectid;
	RAISE  NOTICE  'v_routingid  %', v_routingid;
 
   
    select permanencyplanid,intakeservicerequestactorid ,intakeserviceid ,servicecaseid ,placementid ,projecteddate,
	establisheddate,enddate,caseworkername, permanencyplanremainssame into v_permanencyplanid,v_intakeservicerequestactorid ,v_intakeserviceid ,v_servicecaseid ,v_placementid ,v_projecteddate,
	v_establisheddate,v_enddate,v_caseworkername, v_permanencyplanremainssame
    from permanencyplan 
    where permanencyplanid=v_objectid :: uuid limit 1;
   
    RAISE  NOTICE  'v_intakeservicerequestactorid  %',v_intakeservicerequestactorid;
  
   if (v_status = 15) then 
		v_currentstatus:='Review';
	end if ;

   if (v_status = 16) then 
		v_currentstatus:='Approved';
	end if ;

	if (v_status = 17) then 
		v_currentstatus:='Rejected';
	end if ;
   
   
   INSERT INTO cjams.permanencyplanhistory
	( permanencyplanid, intakeservicerequestactorid, intakeserviceid, servicecaseid, placementid, projecteddate, 
	establisheddate, enddate, caseworkername, insertedon, insertedby, updatedon, updatedby,status, permanencyplanremainssame, objectid)
	VALUES(v_permanencyplanid,v_intakeservicerequestactorid ,v_intakeserviceid ,v_servicecaseid ,v_placementid ,v_projecteddate,
	v_establisheddate,v_enddate,v_caseworkername, now(), v_securityuserid, now(), v_securityuserid,v_currentstatus, v_permanencyplanremainssame, v_routingid);

                                                                                                                         
                                                                                                                                   
 RETURN 'Success';                                                                                                                 
                                                                                
 END;                                                                                                                              
                                                                                                                                   
 $function$
;
