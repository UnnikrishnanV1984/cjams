DROP FUNCTION IF EXISTS cjams.publishexpungreport (varchar, json) ;

CREATE OR REPLACE FUNCTION cjams.publishexpungreport (v_entitykey varchar, v_entity json) 
RETURNS void 
 LANGUAGE plpgsql
AS $function$
BEGIN
-----------------------------------------------------------------------------
-- Revision(s) 
-- Modified BY		Modified DATE	Comments 
-- Sarma Bandi		04/16/2020		Added Order by and Limit 1 around the Completion date logic.
-- Vineet Tirodkar	08/23/2023		To fix value too long for type character varying(50) error (CIDM-7750)
-----------------------------------------------------------------------------
/*ALLEGATION*/
	IF (v_entitykey='ALLEG')  THEN 
        WITH MALT AS ( SELECT    *    
              FROM    json_to_recordset(v_entity ) AS X
                        ( "cpsid" character varying
                         , "intakeserviceid" uuid
                         , "intakeservicerequestactorid" uuid
                         , "personid" uuid
                         , "investigationallegationid" uuid
                         , "investigationfindingtypekey" character varying
                         , "reporteddate" date
                         , "completiondate" date)
        )
        INSERT INTO expungementreport (
					 referralid,chessieuserid, workerid, countytypekey, chessieclientid, 
					 expungementtypekey, expungementdate, startdate,
					 cisid, old_id, finalizeddate,  intakeserviceid ,
					 findingtypekey, invtypekey, maltreatmenttypekey,
					 insertedon, insertedby, updatedon, updatedby, activeflag,
					 maltreaterid, maltreatercisid, victimid, victincisid,
					 cisclientid, suid, requestuserid, completiondate,
					 maltreatername, victimname, invname
					) 
                SELECT  
                    REPLACE(iM.cpsid,'CW','')  refferalid
					, COALESCE((SELECT tosupervisoridno FROM caseassignment ca WHERE ca.objectid = im.intakeserviceid AND ca.responsibilitytypekey ='family' LIMIT 1), 'NA')   chessieuserid
					, COALESCE((SELECT ca.toworkeridno FROM caseassignment ca WHERE ca.objectid = im.intakeserviceid AND ca.responsibilitytypekey ='family' LIMIT 1), COALESCE(ia.insertedby,'NA'))   workerid
					, COALESCE((SELECT c.statecountycode FROM caseassignment ca INNER JOIN county c ON c.countyid = ca.toldssid
							WHERE ca.objectid = im.intakeserviceid AND ca.responsibilitytypekey ='family' ORDER BY ca.startdate DESC LIMIT 1), 'NA')
                    , p.cjamspid 
                    , 'A'
                    , NOW() expungement_dt
					, (SELECT insertedon FROM investigation iv WHERE iv.intakeserviceid = im.intakeserviceid LIMIT 1)  startdate
					, COALESCE(p.cisclientid ,'NA') cisclientid
					, NULL old_id 
					, (SELECT invmal.finalizeddate FROM  Investigationallegationmaltreators invmal 
						WHERE invmal.investigationallegationid =im.investigationallegationid AND invmal.intakeservicerequestactorid =im.intakeservicerequestactorid
						LIMIT 1)
					, im.intakeserviceid
					, im.investigationfindingtypekey
					, a.name invname
					, CASE a.name	WHEN 'Mental Injury- Abuse' THEN '2628'
									WHEN 'Mental Injury- Neglect' THEN '2629'
									WHEN 'Neglect' THEN '2630'
									WHEN 'Physical Abuse' THEN '2631'
									WHEN 'Sexual Abuse' THEN '2633'
									ELSE  a.name
					  END  								maltreatmenttypekey  
					, NOW()								create_ts
					, 'CJAMS'							create_user_id
					, NOW()								update_ts
					, 'CJAMS'							update_user_id
					, 1									activeflag
					, p.cjamspid 						maltreaterid
					, COALESCE(p.cisclientid ,'NA') 	maltreatercisid
					, victm.victionpid 					victimid
					, victm.victimcisid					victincisid
					, COALESCE(p.cisclientid ,'NA') 	cisclientid
					, 0									suid
					, 'N/A' 							requestuserid 
					, (SELECT statusdate FROM intakeservicerequestdispositioncode 
						WHERE intakeserviceid = im.intakeserviceid AND intakeserreqstatustypeid = '7995cecb-062d-406c-8ea9-b1da4b1877d8'
					   ORDER BY 1 desc
					   LIMIT 1 -- Sarma Bandi: 04/06/2020
					   ) completiondate	
					, CONCAT_WS(' ',btrim(p.firstname),btrim(p.middlename),btrim(p.lastname)) maltreatername 
                    , victm.victimname 
					, (SELECT referralname FROM investigation iv WHERE iv.intakeserviceid = im.intakeserviceid LIMIT 1)
					FROM 	MALT im 
					INNER JOIN investigationallegation ia ON ia.investigationallegationid = im.investigationallegationid 
					INNER JOIN person p ON p.personid = im.personid 
					INNER JOIN allegation a ON a.allegationid = ia.allegationid 
					INNER JOIN (SELECT 	CONCAT_WS(' ',btrim(pv.firstname),btrim(pv.middlename),btrim(pv.lastname)) victimname 
										, pv.cjamspid victionpid
										, COALESCE(pv.cisclientid ,'NA') victimcisid
										, invact.investigationmaltreatmentactorid
								FROM  	investigationmaltreatmentactor invact 
										INNER JOIN intakeservicerequestactor isra ON isra.intakeservicerequestactorid = invact.intakeservicerequestactorid
										INNER JOIN person pv ON pv.personid = isra.personid 
								) victm ON victm.investigationmaltreatmentactorid = ia.investigationmaltreatmentactorid;
	ELSEIF (v_entitykey='REFCL')  THEN  /*### REFERRAL CLIENT */
            WITH PERS AS ( SELECT * FROM json_to_recordset(v_entity ) AS X( "personid" uuid, "intakeserviceid" uuid, "personname" character varying )
            )    
			INSERT INTO expungementreport (
				 referralid,chessieuserid, workerid, countytypekey, 
				 expungementtypekey, expungementdate, startdate,
				 chessieclientid, cisid, old_id, intakeserviceid ,
				 insertedon, insertedby, updatedon, updatedby, activeflag,
				 maltreaterid, maltreatercisid, victimid, victincisid,
				 cisclientid, suid, requestuserid, invname
				) 
			SELECT 	DISTINCT
					REPLACE(ir.servicerequestnumber,'CW','')  refferalid
					, COALESCE((SELECT tosupervisoridno FROM caseassignment ca WHERE ca.objectid = ir.intakeserviceid AND ca.responsibilitytypekey ='family' LIMIT 1), 'NA')   chessieuserid
					, COALESCE((SELECT ca.toworkeridno FROM caseassignment ca WHERE ca.objectid = ir.intakeserviceid AND ca.responsibilitytypekey ='family' LIMIT 1), COALESCE(ir.insertedby,'NA'))   workerid
					, COALESCE((SELECT u.primarycountycd FROM muser m INNER JOIN userprofile u ON u.securityusersid = m.securityusersid 
						WHERE ir.insertedby IN (m.username, m.securityusersid)  LIMIT 1), 'NA')
					, 'C' expungementtypekey
					, now()::date
					, (SELECT insertedon FROM investigation iv WHERE iv.intakeserviceid = ir.intakeserviceid LIMIT 1)  startdate
					,  COALESCE(p.cjamspid,0)   		chessieclientid
					, COALESCE(p.cisclientid, 'NA'	)	CIS_CLIENT_ID
					, NULL old_id
					, ir.intakeserviceid 
					, NOW()								insertedon
					, 'CJAMS'							insertedby
					, NOW()								updatedon
					, 'CJAMS'							updatedby
					, 1									activeflag
					, 0 								maltreaterid
					, 'NA' 								maltreatercisid
					, 0 								victimid
					, 'NA' 								victincisid
					,  COALESCE(p.cisclientid, 'NA') 	cisclientid
					, 0									suid
					, 'N/A' 							requestuserid 
					, prs.personname
			FROM 	PERS prs 
                    INNER JOIN intakeservicerequest ir  ON ir.intakeserviceid = prs.intakeserviceid 
					INNER JOIN person p ON p.personid = prs.personid ; 
	ELSIF (v_entitykey='INVT')  THEN /*### INVESTIGATION EXPUNG  */
        WITH INVT AS ( SELECT * FROM json_to_recordset(v_entity ) AS X( "intakeserviceid" uuid, "investigationid" uuid, "cisclientid" character varying, "cjamspid" bigint)
        )
        INSERT INTO expungementreport (
				 referralid,chessieuserid, workerid, countytypekey, 
				 expungementtypekey, expungementdate, startdate,
				 chessieclientid, cisid, old_id, intakeserviceid ,
				 insertedon, insertedby, updatedon, updatedby, activeflag,
				 maltreaterid, maltreatercisid, victimid, victincisid,
				 cisclientid, suid, requestuserid, completiondate, finalizeddate, invname
				) 
			SELECT 	DISTINCT
					REPLACE(ir.servicerequestnumber,'CW','')  refferalid
					, COALESCE((SELECT tosupervisoridno FROM caseassignment ca WHERE ca.objectid = ir.intakeserviceid AND ca.responsibilitytypekey ='family' LIMIT 1), 'NA')   chessieuserid
					, COALESCE((SELECT ca.toworkeridno FROM caseassignment ca WHERE ca.objectid = ir.intakeserviceid AND ca.responsibilitytypekey ='family' LIMIT 1), COALESCE(ir.insertedby,'NA'))   workerid
					, COALESCE((SELECT c.statecountycode FROM caseassignment ca INNER JOIN county c ON c.countyid = ca.toldssid
							WHERE ca.objectid = ir.intakeserviceid AND ca.responsibilitytypekey ='family' ORDER BY ca.startdate DESC LIMIT 1), 'NA')
					, 'I' expungementtypekey
					, now()::date
					, (SELECT insertedon FROM investigation iv WHERE iv.intakeserviceid = ir.intakeserviceid LIMIT 1)  startdate
					, COALESCE(inv.cjamspid, 0)
					, COALESCE(inv.cisclientid,'NA')
					, NULL old_id
					, ir.intakeserviceid 
					, NOW()						insertedon
					, 'CJAMS'					insertedby
					, NOW()						updatedon
					, 'CJAMS'					updatedby
					, 1							activeflag
					, 0 						maltreaterid
					, 'NA' 						maltreatercisid
					, 0 						victimid
					, 'NA' 						victincisid
					, COALESCE(inv.cisclientid,'NA')
					, 0							suid
					, 'NA' 						requestuserid 
					, (SELECT statusdate FROM intakeservicerequestdispositioncode 
						WHERE intakeserviceid = ir.intakeserviceid AND intakeserreqstatustypeid = '7995cecb-062d-406c-8ea9-b1da4b1877d8'
						ORDER BY 1 DESC 
						LIMIT 1 -- Sarma Bandi: 04/06/2020
					   ) completiondate	
					, (SELECT 	MAX(im.finalizeddate) finalizeddate FROM investigationallegationmaltreators im
								INNER JOIN intakeservicerequestactor isa ON im.intakeservicerequestactorid = isa.intakeservicerequestactorid
						WHERE	isa.intakeserviceid = ir.intakeserviceid
						GROUP BY isa.intakeserviceid
						UNION ALL
						SELECT statusdate FROM intakeservicerequestdispositioncode dc 
						WHERE dc.intakeserviceid = ir.intakeserviceid AND intakeserreqstatustypeid = '7995cecb-062d-406c-8ea9-b1da4b1877d8'
						LIMIT 1)
					, (SELECT referralname FROM investigation iv WHERE iv.intakeserviceid = ir.intakeserviceid LIMIT 1)
			FROM 	INVT inv 
                    INNER JOIN intakeservicerequest ir  ON ir.intakeserviceid = inv.intakeserviceid 
					INNER JOIN investigation i  ON i.intakeserviceid = inv.intakeserviceid ; 
	ELSEIF (v_entitykey='SCRNOUT')  THEN  /*### SCREENOUT INTAKE*/	
		RAISE NOTICE '%', v_entity;
	 WITH SCRNOUT AS ( SELECT * FROM json_to_recordset(v_entity ) AS X( "cpsid" character varying, "intakeserviceid" uuid  )
            )    
			INSERT INTO expungementreport (
				 referralid,chessieuserid, workerid, countytypekey, 
				 expungementtypekey, expungementdate, startdate,
				 chessieclientid, cisid, old_id, intakeserviceid ,
				 insertedon, insertedby, updatedon, updatedby, activeflag,
				 maltreaterid, maltreatercisid, victimid, victincisid,
				 cisclientid, suid, requestuserid, invname
				) 	
			 SELECT 	DISTINCT
					REPLACE(ir.servicerequestnumber,'CW','')  refferalid
					, COALESCE((SELECT tosupervisoridno FROM caseassignment ca WHERE ca.objectid = sc.intakeserviceid AND ca.responsibilitytypekey ='family' LIMIT 1), 'NA')   chessieuserid
					, COALESCE((SELECT ca.toworkeridno FROM caseassignment ca WHERE ca.objectid = sc.intakeserviceid AND ca.responsibilitytypekey ='family' LIMIT 1), COALESCE(ir.insertedby,'NA'))   workerid
					, COALESCE((SELECT u.primarycountycd FROM muser m INNER JOIN userprofile u ON u.securityusersid = m.securityusersid 
									WHERE ir.insertedby IN (m.username, m.securityusersid)  LIMIT 1), 'NA')
					, 'S' expungementtypekey
					, now()::date
					, (SELECT insertedon FROM investigation iv WHERE iv.intakeserviceid = sc.intakeserviceid LIMIT 1)  startdate
					,  0  chessieclientid
					,  'NA'	CIS_CLIENT_ID
					, NULL old_id
					, ir.intakeserviceid 
					, NOW()						insertedon
					, 'CJAMS'					insertedby
					, NOW()						updatedon
					, 'CJAMS'					updatedby
					, 1							activeflag
					, 0 						maltreaterid
					, 'NA' 						maltreatercisid
					, 0 						victimid
					, 'NA' 						victincisid
					, 'NA'						cisclientid
					, 0							suid
					, 'N/A' 					requestuserid 
					, (SELECT formattedreferralname FROM intakeservicerequest iv WHERE iv.intakeserviceid = ir.intakeserviceid LIMIT 1)
			FROM 	SCRNOUT sc 
                    INNER JOIN intakeservicerequest ir  ON ir.intakeserviceid = sc.intakeserviceid; 
				
	ELSIF  (v_entitykey='SRVCL')  THEN  /*### SERVICECASE CLIENT */
			INSERT INTO expungementreport (
					 referralid,chessieuserid, workerid, countytypekey, 
					 expungementtypekey, expungementdate, startdate,
					 chessieclientid, cisid, old_id, intakeserviceid ,
					 insertedon, insertedby, updatedon, updatedby, activeflag,
					 maltreaterid, maltreatercisid, victimid, victincisid,
					 cisclientid, suid, requestuserid, invname
					) 
				SELECT	DISTINCT
						sc.servicecasenumber  refferalid
						, COALESCE((SELECT tosupervisoridno FROM caseassignment ca WHERE ca.objectid = sc.intakeserviceid AND ca.responsibilitytypekey ='family' LIMIT 1), 'NA')   chessieuserid
						, COALESCE((SELECT ca.toworkeridno FROM caseassignment ca WHERE ca.objectid = sc.intakeserviceid AND ca.responsibilitytypekey ='family' LIMIT 1), COALESCE(sc.insertedby,'NA'))   workerid
						, COALESCE((SELECT c.statecountycode FROM caseassignment ca INNER JOIN county c ON c.countyid = ca.toldssid
								WHERE ca.objectid = sc.intakeserviceid AND ca.responsibilitytypekey ='family' LIMIT 1), 'NA')
						, 'C' expungementtypekey
						, now()::date
						, sc.insertedon startdate
						, COALESCE(p.cjamspid,0)   chessieclientid
						, COALESCE(p.cisclientid, 'NA'	)		CIS_CLIENT_ID
						, p.old_id
						, NULL
						, NOW()						insertedon
						, 'CJAMS'					insertedby
						, NOW()						updatedon
						, 'CJAMS'					updatedby
						, 1							activeflag
						, 0 						maltreaterid
						, 'NA' 						maltreatercisid
						, 0 						victimid
						, 'NA' 						victincisid
						, 'NA'						cisclientid
						, 0							suid
						, 'NA' 						requestuserid 
						, 'NA'
				FROM 	servicecase sc 
						INNER JOIN intakeservicerequestactor ira ON ira.servicecaseid = sc.servicecaseid 
						INNER JOIN person p ON p.personid = ira.personid 
				WHERE	sc.servicecaseid = v_entityid
				AND 	(v_personid IS NULL OR p.personid = v_personid);  
	END IF;	 	
			
END;
 
$function$
;
