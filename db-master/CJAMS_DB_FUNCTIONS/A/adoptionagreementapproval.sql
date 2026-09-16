CREATE OR REPLACE FUNCTION cjams.adoptionagreementapproval(v_securityuserid character varying, v_objectid uuid, appeventcode character varying)
 RETURNS character varying
 LANGUAGE plpgsql
AS $function$

                                
DECLARE    
v_adoptionplanningid  uuid;
v_startdate date;
v_enddate date;
v_agstartdate date;
v_agenddate date;
v_clientid bigint;
v_tcaamount numeric (10,2);
v_providerid bigint;
v_paymentamount  numeric (10,2);
v_subsidyid bigint;
v_adoptionagreementrateid uuid;
v_adoptionagreementid uuid;
v_adoptionsuspensionid uuid;
v_adoptionsuspensionrevisionid uuid;
v_caseid bigint;
v_disclosuredate date ;
v_isoverride boolean;
v_tcaamount1 character varying;
v_adoptionid bigint;
v_agreementrateid uuid;

v_eventcode character varying;
v_routeddescription character varying;
v_routingstatustypeid integer;

BEGIN
	
	RAISE  NOTICE  '  appeventcode  %',appeventcode;
	RAISE  NOTICE  '  v_objectid  %',v_objectid;
RAISE  NOTICE  '  v_objappeventcodeectid  %',appeventcode;

	IF (appeventcode='ASAR') THEN 
		
		SELECT  adoptionplanningid, startdate, enddate   
   		INTO  v_adoptionplanningid , v_agstartdate ,v_agenddate 
		FROM adoptionagreement  
		WHERE  adoptionagreementid  =  v_objectid AND activeflag =1 LIMIT  1;
	
	    
 
   		SELECT adoptionagreementrateid, startdate, enddate , paymentamout,provider_id
   		INTO  v_adoptionagreementrateid,v_startdate,v_enddate,v_paymentamount,v_providerid 
		FROM adoptionagreementrate 
		WHERE  adoptionagreementid =  v_objectid  AND activeflag =1 order by insertedon desc LIMIT 1;
			
		--UPDATE adoptionagreementrate SET  updatedon=now(),approvaldate = now(),status='Approved' 
		--WHERE adoptionagreementid = v_objectid;
		--WHERE adoptionagreementrateid = v_adoptionagreementrateid::uuid;
		v_agreementrateid := gen_random_uuid();
	update adoptionagreementrate set activeflag=0 where adoptionagreementrateid=v_adoptionagreementrateid::uuid;
     
    INSERT INTO adoptionagreementrate
( adoptionagreementrateid,adoptionagreementid, startdate, enddate, provider_id, paymentamout, isapproval, approvaldate, isspeacialneeds, parent1actorid, parent2actorid, childrelationship, notes, activeflag, effectivedate, insertedby, insertedon, updatedby, updatedon, old_id, specialneedtypekey, specialneedremarks, transactiondate, rateoverwrittensw, status)
SELECT  v_agreementrateid,adoptionagreementid, startdate, enddate, provider_id, paymentamout, isapproval, now(), isspeacialneeds, parent1actorid, parent2actorid, childrelationship, notes, 1, effectivedate, insertedby, insertedon, updatedby, now(), old_id, specialneedtypekey, specialneedremarks, transactiondate, rateoverwrittensw, 'Approved'
FROM cjams.adoptionagreementrate
WHERE adoptionagreementrateid=v_adoptionagreementrateid::uuid and activeflag=0 limit 1;

		--UPDATE adoptionrevision SET approvalstatustypekey = '3047' , approvaldate = now() 
		--WHERE subsidyagreementid = v_objectid ;
		
	 update adoptionrevision set activeflag=0, updatedon=now(), updatedby=v_securityuserid where subsidyagreementrateid = v_adoptionagreementrateid::uuid;
	   
	    INSERT INTO cjams.adoptionrevision
     ( subsidyagreementid, adoptionid, transactiondate, agreementtypetypekey, adoptivemotherid, adoptivefatherid, agreementstartdate, agreementenddate, paymentamt, "comments", isssaapproval, ssaapprovaldate, ischildmedicallyfragile, primbasissplneedstypekey, approvalstatustypekey, approvaldate, isoriginal, insertedon, insertedby, updatedon, updatedby, activeflag, providerid, alternateid,subsidyagreementrateid)
      SELECT  subsidyagreementid, adoptionid, transactiondate, agreementtypetypekey, adoptivemotherid, adoptivefatherid, agreementstartdate, agreementenddate, paymentamt, "comments", isssaapproval, ssaapprovaldate, ischildmedicallyfragile, primbasissplneedstypekey, '3047', now(), isoriginal, insertedon, insertedby, updatedon, updatedby, 1, providerid, alternateid,v_agreementrateid
      from adoptionrevision WHERE subsidyagreementrateid= v_adoptionagreementrateid::uuid and activeflag=0 order by insertedon desc limit 1;
	
	 
		 SELECT p.cjamspid , (isr.servicecasenumber:: bigint) 
    	INTO v_clientid ,v_caseid
		FROM adoptionplanning ga
		INNER JOIN permanencyplan tbp ON ga.permanencyplanid = tbp.permanencyplanid 
		INNER JOIN intakeservicerequestactor isra ON isra.intakeservicerequestactorid = tbp.intakeservicerequestactorid 
		INNER JOIN person p ON p.personid = isra.personid AND p.activeflag= 1
		INNER JOIN servicecase isr ON isr.servicecaseid = ga.servicecaseid AND isr.activeflag =1
		WHERE ga.adoptionplanningid = v_adoptionplanningid AND ga.activeflag =1 LIMIT 1;
 
		
		SELECT rr.eventcode,rr.routeddescription,rr.routingstatustypeid 
 		INTO v_eventcode,v_routeddescription,v_routingstatustypeid  
 		FROM routing rr
		WHERE rr.eventcode  = 'ASAR'  AND rr.activeflag = 1  
		AND rr.objectid=v_objectid :: character varying ORDER BY rr.insertedon DESC LIMIT 1 ;

		if v_routingstatustypeid =16 then 
			
			UPDATE routing SET activeflag=0 WHERE objectid =v_adoptionagreementrateid :: character varying and eventcode='AARR';
			UPDATE routing SET activeflag=0 WHERE objectid =v_objectid :: character varying and routingstatustypeid=15 and activeflag=1 and eventcode='ASAR';
			
		INSERT INTO routing(
					eventcode, fromsecurityusersid, tosecurityusersid, teamid, 
					FROMroleid, toroleid,objectid , routingstatustypeid,activeflag,
					insertedby,  updatedby,insertedon,updatedon, isreviewrequest,
					servicerequestnumber,remarks,routeddescription)
				SELECT  'AARR', R.tosecurityusersid, R.fromsecurityusersid, R.teamid, 
				 		R.toroleid,R.FROMroleid,v_adoptionagreementrateid :: character varying, 16,1,
						R.insertedby,  R.updatedby,now(),now(), R.isreviewrequest, 
						R.servicerequestnumber,'Adoption Agreement Rate Approved','Adoption Agreement Rate Approved' 
						FROM routing as R 
						WHERE R.objectid = v_adoptionagreementrateid :: character varying and eventcode='AARR'
						AND R.activeflag=0 order by insertedon desc limit 1;
			end if;	 
		
		
 /* 	-- remove this
  	INSERT INTO cjams.tb_client_eligibility 
            (start_dt, 
             end_dt, 
             eligibility_type_cd, 
             eligibility_status_cd, 
             client_id, 
             removal_id, 
             create_user_id, 
             update_user_id, 
             delete_sw, 
             adoption_id, 
             case_id, 
             data_valid_sw, 
             client_merge_id, 
             guardian_subsidy_id, 
             transactionid, 
             create_ts, 
             update_ts)   
		SELECT 
			adp.finalizationdate::date,
			null,  
			'2934', 
			'2909', 
			v_clientid, 
			null,
			adp.insertedby,
			adp.updatedby, 
			'N',
			(select app.alternateid from adoptionplanning app inner join adoptionagreement agg on agg.adoptionplanningid=app.adoptionplanningid where agg.adoptionagreementid=v_objectid::uuid ),
			null ,
			null,
			null,
		    null,
			null,
			now(),
			now()
 		FROM adoptionagreement adp where adp.adoptionagreementid=v_objectid::uuid ;
*/
	ELSIF (appeventcode='ADSR') THEN

		RAISE  NOTICE  '  inside appeventcode  %',appeventcode;
			SELECT rr.eventcode,rr.routeddescription,rr.routingstatustypeid 
 		INTO v_eventcode,v_routeddescription,v_routingstatustypeid  
 		FROM routing rr
		WHERE rr.eventcode  = 'ADSR'  AND rr.activeflag = 1  
		AND rr.objectid=v_objectid :: character varying ORDER BY rr.insertedon DESC LIMIT 1 ;

	RAISE  NOTICE  '  inside v_routingstatustypeid  %',v_routingstatustypeid;
RAISE  NOTICE  '  inside v_routeddescription  %',v_routeddescription;

	 	if v_routingstatustypeid =16 then 
			
   		v_adoptionsuspensionid:=v_objectid;
   /*	
   	INSERT INTO routing(
					eventcode, fromsecurityusersid, tosecurityusersid, teamid, 
					FROMroleid, toroleid,objectid , routingstatustypeid,activeflag,
					insertedby,  updatedby,insertedon,updatedon, isreviewrequest,
					servicerequestnumber,remarks,routeddescription)
				SELECT  'ADSR', R.tosecurityusersid, R.fromsecurityusersid, R.teamid, 
				 		R.toroleid,R.FROMroleid,v_objectid :: character varying, 16,1,
						R.insertedby,  R.updatedby,now(),now(), R.isreviewrequest, 
						R.servicerequestnumber,'Adoption Suspension Approved','Adoption Suspension Approved' 
						FROM routing as R 
						WHERE R.objectid = v_objectid :: character varying
						AND R.activeflag=1;   */
					
   			RAISE  NOTICE  '  inside v_adoptionsuspensionid  %',v_adoptionsuspensionid;
		update adoptionsuspensionrevision set approvalstatustypekey = '3047',approvaldate = now()::date 
 		where adoptionsuspensionid = v_adoptionsuspensionid ;
		
		update adoptionsuspension set approvalstatustypekey = '3047',updatedon=now() ,approvaldate = now() 
 		where adoptionsuspensionid = v_adoptionsuspensionid ;
 	
 	
 
 
  		end if;
   	/*	SELECT adoptionagreementid 
   		INTO v_adoptionagreementid 
  		FROM adoptionsuspensionrevision WHERE adoptionsuspensionrevisionid = v_adoptionsuspensionrevisionid;
	
		SELECT  adoptionplanningid, startdate, enddate, 0     
		INTO  v_adoptionplanningid , v_agstartdate , v_agenddate, v_tcaamount1 
		FROM  adoptionagreement  
		WHERE  adoptionagreementid  =  v_adoptionagreementid AND activeflag =1 LIMIT  1;
	
	    v_tcaamount:=  CASE COALESCE(v_tcaamount1,'') WHEN '' THEN 0 ELSE CAST( v_tcaamount1 as numeric) END;


  	 	SELECT adoptionagreementrateid,startdate,enddate, paymentamout,provider_id 
  	 	INTO v_adoptionagreementrateid,v_startdate,v_enddate,v_paymentamount,v_providerid 
		FROM adoptionagreementrate 
		WHERE  adoptionagreementid =  v_adoptionagreementid AND activeflag =1 LIMIT 1;
	
		SELECT p.cjamspid , (isr.servicecasenumber:: bigint)  
		INTO v_clientid ,v_caseid
		FROM adoptionplanning ga
		INNER JOIN permanencyplan tbp ON ga.permanencyplanid = tbp.permanencyplanid 
		INNER JOIN intakeservicerequestactor isra ON isra.intakeservicerequestactorid = tbp.intakeservicerequestactorid 
		INNER JOIN person p ON p.personid = isra.personid AND p.activeflag= 1
		INNER JOIN servicecase isr ON isr.servicecaseid = ga.servicecaseid AND isr.activeflag =1
		WHERE ga.adoptionplanningid = v_adoptionplanningid AND ga.activeflag =1 LIMIT 1;
	
	--NEED TO COMMAND
		INSERT INTO tb_adoption_suspension_revision( transaction_dt,suspension_reason_cd,suspension_begin_dt,suspension_end_date,suspension_tx,approval_status_cd,approval_dt,
					delete_sw,adoptionsuspensionrevisionid,create_ts,create_user_id,update_ts,update_user_id)
		SELECT transactiondate, suspensionreasontypekey, suspensionbegindate, suspensionenddate, suspensionremarks,'3047', now(),'N', adoptionsuspensionrevisionid,'','admin','','admin' 
		FROM cjams.adoptionsuspensionrevision 
		WHERE adoptionsuspensionrevisionid = v_adoptionsuspensionrevisionid AND activeflag = 1 LIMIT 1 ;  
	
		*/
  	
  	
	

	ELSIF (appeventcode = 'AARR' ) THEN

 

	END IF;
	
RETURN  'Success';

END;
 

$function$
;
