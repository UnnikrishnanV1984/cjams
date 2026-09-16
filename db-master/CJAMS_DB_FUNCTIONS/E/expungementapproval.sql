DROP FUNCTION IF EXISTS  cjams.expungementapproval(v_securityuserid character varying, v_objectid uuid, v_status integer);
CREATE OR REPLACE FUNCTION cjams.expungementapproval(v_securityuserid character varying, v_objectid uuid, v_status integer)
 RETURNS character varying
 LANGUAGE plpgsql
AS $function$                                                                                                                     
                                                                                                                                   
                                                                                                                                   
 DECLARE                                                                                                                           
 v_servicerequestnumber character varying;                                                                                                       
 v_intakeserviceid uuid;
 v_intakeservicerequestactorid uuid;
 v_maltreatmentid uuid;
v_investigationallegationid uuid;
                                                                                           
                                                                                                                                   
 BEGIN                                                                                                                             
                                                                                                                                   
 IF v_status = 16 THEN                                                                                                     
                                                                                                                                   
	RAISE  NOTICE  'v_status  %',v_status;
	RAISE  NOTICE  'v_objectid  %',v_objectid;
	 
/*	select servicerequestnumber into  v_servicerequestnumber 
	from routing 
	where eventcode = 'EXPR' and objectid=v_objectid :: character varying 
	order by insertedon desc limit 1;

	RAISE  NOTICE  'v_servicerequestnumber  %',v_servicerequestnumber;

    select intakeserviceid into v_intakeserviceid
    from intakeservicerequest 
    where servicerequestnumber=v_servicerequestnumber limit 1;
   
    RAISE  NOTICE  'v_intakeserviceid  %',v_intakeserviceid;  */
   
    select maltreatmentid into v_maltreatmentid
    from expungement 
    where expungementid=v_objectid limit 1;
   
    RAISE  NOTICE  'v_maltreatmentid  %',v_maltreatmentid;
  /* 
   
   	select ISRPN.intakeservicerequestactorid into v_intakeservicerequestactorid
    from  intakeservicerequestactor ISRPN
	inner join referencevalues at on	
			at.ref_key = isrpn.intakeservicerequestpersontypekey
	inner join actor as ac on
		ISRPN.actorid = ac.actorid			
	where	isrpn.actorid = ac.actorid
		and (isrpn.intakeserviceid = v_intakeserviceid  OR isrpn.intakenumber =v_servicerequestnumber  )
		and isrpn.activeflag = 1 
    	and at.referencetypeid   in (175,176)
	    limit 1;
    	
	RAISE  NOTICE  'v_intakeservicerequestactorid  %',v_intakeservicerequestactorid;	   

 */
    RAISE  NOTICE  'v_maltreatmentid  %',v_maltreatmentid;
   
   
	   select ia.investigationallegationid  into v_investigationallegationid
	   
	   FROM   Investigationmaltreatment im 
            INNER JOIN Investigationmaltreatmentactor ima on ima.maltreatmentid = im.maltreatmentid AND ima.activeflag =1             							     
            INNER JOIN intakeservicerequestactor isra on isra.intakeservicerequestactorid = ima.intakeservicerequestactorid
            INNER JOIN person p on p.personid = isra.personid	
            INNER JOIN Investigationallegation ia ON  ia.maltreatmentid = im.maltreatmentid
            LEFT JOIN investigation inv on inv.investigationid = IM.investigationid									
    		INNER JOIN allegation  alle on  alle.allegationid = ia.allegationid AND alle.activeflag = 1
			WHERE im.maltreatmentid=v_maltreatmentid --.investigationid = v_investigationid
            AND im.activeflag =1 
			 AND ia.investigationmaltreatmentactorid = ima.investigationmaltreatmentactorid AND ia.activeflag =1 limit 1;   
    
			 RAISE  NOTICE  'v_investigationallegationid  %',v_investigationallegationid;
			
	   select intakeservicerequestactorid  into v_intakeservicerequestactorid from Investigationallegationmaltreators 
   where investigationallegationid=v_investigationallegationid;
            RAISE  NOTICE  'v_intakeservicerequestactorid  %',v_intakeservicerequestactorid;                                                        
  
	update Investigationallegationmaltreators set expungementflag=1 
   	where  investigationallegationid=v_investigationallegationid;
   
   update intakeservicerequestactor set activeflag=1 ,updatedby = v_securityuserid,updatedon=now() ,spexpungementflag=1  
   where   intakeservicerequestpersontypekey='AM' and intakeservicerequestactorid =  v_intakeservicerequestactorid ;
                                                                
 END IF;                                                                                                                           
                                                                                                                                   
 RETURN 'Success';                                                                                                                 
                                                                                
 END;                                                                                                                              
                                                                                                                                   
 $function$
;
