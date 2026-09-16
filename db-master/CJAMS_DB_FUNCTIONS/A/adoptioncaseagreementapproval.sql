--DROP FUNCTION IF EXISTS cjams.adoptioncaseagreementapproval(v_securityuserid character varying, v_objectid uuid, appeventcode character varying);

CREATE OR REPLACE FUNCTION cjams.adoptioncaseagreementapproval(v_securityuserid character varying, v_objectid uuid, appeventcode character varying)
 RETURNS character varying
 LANGUAGE plpgsql
AS $function$

--------------------------------------------------------------------------------------
--09-01 - Addded agreementtyperefid field for the story CIDM-5203
--------------------------------------------------------------------------------------
                                
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
v_adoptioncaserevisionid uuid;
v_adoptionsuspensionid uuid;
v_adoptionsuspensionrevisionid uuid;
v_caseid bigint;
v_disclosuredate date ;
v_isoverride boolean;
v_tcaamount1 character varying;
v_adoptionid bigint;

v_eventcode character varying;
v_routeddescription character varying;
v_routingstatustypeid integer;
v_adoptioncaseid uuid;

v_newsuspensionenddate timestamp without time zone;
v_newadoptionsuspensionid uuid;
v_agreementrateid uuid;
v_adoptioncaseenddate timestamp without time zone;


BEGIN
	
	RAISE  NOTICE  '  appeventcode  %',appeventcode;
	RAISE  NOTICE  '  v_objectid  %',v_objectid;
RAISE  NOTICE  '  v_objappeventcodeectid  %',appeventcode;

	IF (appeventcode='ASAR') THEN 
		
		SELECT  adoptioncaseid, startdate, enddate   
   		INTO  v_adoptionplanningid , v_agstartdate ,v_agenddate 
		FROM adoptioncaseagreement  
		WHERE   adoptionagreementid =  v_objectid AND activeflag =1 LIMIT  1;
	
	    
 
   		SELECT adoptionagreementrateid, startdate, enddate , paymentamout,provider_id
   		INTO  v_adoptionagreementrateid,v_startdate,v_enddate,v_paymentamount,v_providerid 
		FROM adoptioncaseagreementrate 
		WHERE  adoptionagreementid =  v_objectid  AND activeflag =1 order by insertedon desc LIMIT 1;
		
		
		SELECT adoptionrevisionid 
   		INTO  v_adoptioncaserevisionid
		FROM adoptioncaserevision 
		WHERE  adoptionagreementid =  v_objectid  AND activeflag =1 order by insertedon desc LIMIT 1;
		
       v_agreementrateid := gen_random_uuid();
      update adoptioncaseagreementrate set activeflag=0 where adoptionagreementrateid = v_adoptionagreementrateid::uuid;
      
      INSERT INTO adoptioncaseagreementrate
(adoptionagreementrateid, adoptionagreementid, startdate, enddate, provider_id, paymentamout, isapproval, approvaldate, isspeacialneeds, parent1actorid, parent2actorid, childrelationship, notes, activeflag, effectivedate, insertedby, insertedon, updatedby, updatedon, old_id, specialneedtypekey, specialneedremarks, transactiondate, rateoverwrittensw, status)
SELECT v_agreementrateid, adoptionagreementid, startdate, enddate, provider_id, paymentamout, isapproval, now(), isspeacialneeds, parent1actorid, parent2actorid, childrelationship, notes, 1, effectivedate, insertedby, now(), updatedby, now(), old_id, specialneedtypekey, specialneedremarks, transactiondate, rateoverwrittensw, 'Approved' FROM cjams.adoptioncaseagreementrate
WHERE adoptionagreementrateid=v_adoptionagreementrateid::uuid and activeflag=0 limit 1;

update adoptioncaserevision set activeflag=0,transactiondate=now(), approvaldate=now() WHERE agreementrateid=v_adoptionagreementrateid ;

INSERT INTO adoptioncaserevision
(adoptionagreementid, transactiondate, agreementtypetypekey, adoptivemotherid, adoptivefatherid, agreementstartdate, agreementenddate, paymentamt, "comments", isssaapproval, ssaapprovaldate, ischildmedicallyfragile, primbasissplneedstypekey, approvalstatustypekey, approvaldate, isoriginal, insertedon, insertedby, updatedon, updatedby, activeflag, providerid, alternateid, agreementrateid)
SELECT  adoptionagreementid, transactiondate, agreementtypetypekey, adoptivemotherid, adoptivefatherid, agreementstartdate, agreementenddate, paymentamt, "comments", isssaapproval, ssaapprovaldate, ischildmedicallyfragile, primbasissplneedstypekey, '3047', approvaldate, isoriginal, insertedon, insertedby, updatedon, updatedby, 1, providerid, alternateid
,v_agreementrateid FROM adoptioncaserevision
WHERE agreementrateid=v_adoptionagreementrateid and activeflag=0 order by insertedon desc limit 1;

		SELECT rr.eventcode,rr.routeddescription,rr.routingstatustypeid 
 		INTO v_eventcode,v_routeddescription,v_routingstatustypeid  
 		FROM routing rr
		WHERE rr.eventcode  = 'ASAR'  AND rr.activeflag = 1  
		AND rr.objectid=v_objectid :: character varying ORDER BY rr.insertedon DESC LIMIT 1 ;

		if v_routingstatustypeid =16 then 
			
			UPDATE routing SET activeflag=0 WHERE objectid =v_objectid :: character varying and eventcode='AARR';
			UPDATE routing SET activeflag=0 WHERE objectid =v_objectid :: character varying and routingstatustypeid=15 and activeflag=1 and eventcode='ASAR';
			update adoptioncaseagreementrevision set activeflag=0 where adoptioncaseagreementid = v_objectid::uuid;
		   
			INSERT INTO cjams.adoptioncaseagreementrevision
			( adoptioncaseagreementid, isofferedsubsidy, offeraccepteddate, startdate, enddate, finalizationdate, isunderappeal, parent1signdate, parent2signdate, ldssdate, issubsidypaid, activeflag, effectivedate, insertedby, insertedon, updatedby, updatedon, old_id, ismedassist, parent1providerid, parent2providerid, parent1providername, parent2providername, issingleparent, singleparentadoptioncheck, adoptiveparent1signature, adoptiveparent2signature, ldssdirectorsignature, agreementcomments, childplacedby, childplacedfrom,agreementtyperefid, providerid, adoptiveparent1id, adoptiveparent2id, approvalstatustypekey, approvaldate)
			SELECT  adoptioncaseagreementid, isofferedsubsidy, offeraccepteddate, startdate, enddate, finalizationdate, isunderappeal, parent1signdate, parent2signdate, ldssdate, issubsidypaid, 1, effectivedate, insertedby, now(), updatedby, now(), old_id, ismedassist, parent1providerid, parent2providerid, parent1providername, parent2providername, issingleparent, singleparentadoptioncheck, adoptiveparent1signature, adoptiveparent2signature, ldssdirectorsignature, agreementcomments, childplacedby, childplacedfrom,agreementtyperefid, providerid, adoptiveparent1id, adoptiveparent2id, '3047', now()
			FROM cjams.adoptioncaseagreementrevision 
			WHERE adoptioncaseagreementid= v_objectid and activeflag=0 order by insertedon desc limit 1;
			
			SELECT  enddate into v_adoptioncaseenddate
			FROM cjams.adoptioncaseagreementrevision 
			WHERE adoptioncaseagreementid= v_objectid and activeflag=1 order by insertedon desc limit 1;

			if v_adoptioncaseenddate is not null then
				update adoptioncaseagreement set enddate= v_adoptioncaseenddate 
					where adoptionagreementid = v_objectid::uuid
					and enddate <> v_adoptioncaseenddate;
			
				update adoptioncase set enddate= v_adoptioncaseenddate 
					where adoptioncaseid = (select adoptioncaseid from adoptioncaseagreement 
											where adoptionagreementid = v_objectid::uuid and activeflag= 1)
					and enddate <> v_adoptioncaseenddate;
			end if;

		end if;	 
 
				
		SELECT p.cjamspid ,ac.adoptioncaseid
    	INTO v_clientid,v_adoptioncaseid
		FROM adoptioncaseagreement acag		
		INNER join adoptioncase ac on acag.adoptioncaseid=ac.adoptioncaseid		
		INNER JOIN adoptioncaseactor  aca ON ac.adoptioncaseid = aca.adoptioncaseid 		
		INNER JOIN person p ON p.personid = aca.personid AND p.activeflag= 1		
		WHERE acag.adoptionagreementid = v_objectid::uuid AND acag.activeflag =1 LIMIT 1;

	ELSIF (appeventcode = 'AARR' ) THEN

 
 

	ELSIF (appeventcode = 'ADSR' ) THEN

		UPDATE adoptioncasesuspension SET activeflag=0, updatedon = now() WHERE adoptionsuspensionid = v_objectid;

		INSERT INTO cjams.adoptioncasesuspension (adoptioncaseid, transactiondate, suspensionreasontypekey, suspensionbegindate, 
												suspensionenddate,  approvalstatustypekey, approvaldate, 
												isoriginal, insertedon, insertedby, updatedon, updatedby, activeflag, effectivedate, 
												old_id, suspensionremarks, alternateid, adoptionagreementid)
		select adoptioncaseid, transactiondate, suspensionreasontypekey, suspensionbegindate, suspensionenddate, 
				'3047', now(), isoriginal, now(), v_securityuserid, now(), v_securityuserid, 1, effectivedate, old_id, 
				suspensionremarks, alternateid, adoptionagreementid FROM adoptioncasesuspension 
		WHERE adoptionsuspensionid = v_objectid RETURNING "adoptionsuspensionid" INTO v_newadoptionsuspensionid ; 


 	INSERT INTO routing(
					eventcode, fromsecurityusersid, tosecurityusersid, teamid, FROMroleid, toroleid,objectid , routingstatustypeid, 
					activeflag,
					insertedby,  updatedby,insertedon,updatedon, isreviewrequest,
					servicerequestnumber,remarks,routeddescription)
				SELECT  'ADSR', R.fromsecurityusersid, R.tosecurityusersid, R.teamid, 
				 		R.FROMroleid,R.toroleid,v_newadoptionsuspensionid :: character varying, 16,1,
						R.insertedby,  R.updatedby,now(),now(), R.isreviewrequest, 
						R.servicerequestnumber,'Adoption Suspension Approved','Adoption Suspension Approved' 
						FROM routing as R 
						WHERE R.objectid = v_objectid :: character varying
						AND R.activeflag=1; 
 
 
			
 		UPDATE routing SET activeflag=0 WHERE objectid =v_objectid :: character varying and eventcode='ADSR'  and routingstatustypeid=16;
		

 			update adoptioncasesuspensionrevision set activeflag = 0, updatedon=now() , transactiondate = now() ,approvaldate = now()  where adoptionsuspensionid = v_objectid ;	

			INSERT INTO adoptioncasesuspensionrevision( adoptionsuspensionid, adoptioncaseid, transactiondate, suspensionreasontypekey, 
												suspensionbegindate, suspensionenddate,  approvalstatustypekey, 
												approvaldate, isoriginal, insertedon, insertedby, updatedon, updatedby, activeflag, 
												effectivedate, old_id, suspensionremarks, alternateid, adoptionagreementid)
				SELECT  v_newadoptionsuspensionid, adoptioncaseid, now(), suspensionreasontypekey, suspensionbegindate, suspensionenddate, 
				 '3047', now(), isoriginal, now(), v_securityuserid, now(), v_securityuserid, 1, 
				effectivedate, old_id, suspensionremarks, alternateid, adoptionagreementid FROM adoptioncasesuspensionrevision 
				WHERE adoptionsuspensionid = v_objectid and approvalstatustypekey='3045' order by insertedon desc limit 1 returning "suspensionenddate" INTO v_newsuspensionenddate ;

		update adoptioncasesuspension set suspensionenddate =	v_newsuspensionenddate  where adoptionsuspensionid=v_newadoptionsuspensionid;
		 
	END IF;



	
RETURN  'Success';

END;
 

$function$
;