
DROP FUNCTION IF EXISTS cjams.getmaltreatmentfinding_expunge(uuid);

CREATE OR REPLACE FUNCTION cjams.getmaltreatmentfinding_expunge(v_investigationid uuid)
 RETURNS json
 LANGUAGE plpgsql
AS $function$
------------------------------------------------------------------------
-- Revision(s)
-- 09/20/2022 Vineet Tirodkar - To fix json_agg issue in Aurora DB
-- 07/06/2023 Umasankar Raavi --CIDM-7436-Fetching all Document values
-- 08-03-2023 Umasankar Raavi --CIDM-7167- Inserted by name and updated on info
-- 09/05/2024 Anil Kumar Dharni --CIDM-8743 - Returing a new commentaudittrail column
-- 09/24/2024 Vinesh -CIDM-9438-Expungement Update By is not display
-- 11/17/2025 -Umasanakar raavi - CIDM-10890 - CJAMS Manual & Automation Expungement Enhancement - for Sexual Abuse CPS Intakes and Cases
-- 12/18/2025 -Umasanakar raavi - CIDM-10890 - CJAMS Manual & Automation Expungement Enhancement - added check to remove duplicate records
------------------------------------------------------------------------
declare 
    l_investigation json;
    l_count int;
    l_serviceid uuid;
    l_reporteddate timestamp without time zone;
    v_isexpunged integer; 
    v_intakeserviceid uuid; 
BEGIN

-- 1. Get intakeservice ID
SELECT intakeserviceid INTO l_serviceid 
FROM (
    SELECT intakeserviceid FROM investigation WHERE investigationid = v_investigationid
) x LIMIT 1;

v_intakeserviceid := l_serviceid; 

-- 2. Get reported date
SELECT reporteddate INTO l_reporteddate 
FROM (
    SELECT reporteddate FROM expunge.intakeservicerequest_expunge WHERE intakeserviceid = l_serviceid
    UNION ALL
    SELECT reporteddate FROM intakeservicerequest WHERE intakeserviceid = l_serviceid
) y LIMIT 1;

-- 3. Check expungement status
SELECT iscaseexpunged INTO v_isexpunged FROM iscaseexpunged('Case',v_intakeserviceid::character varying);



    -- ------------------------------------------------------------------
    -- SCENARIO 1: FULLY EXPUNGED (v_isexpunged = 1) - ENCRYPTED ACCESS
    -- ------------------------------------------------------------------
    IF  v_isexpunged = 1 THEN

        SELECT json_agg(allegation) INTO l_investigation FROM (
	 
		    (
                     SELECT l_reporteddate as reporteddate,
                ima.intakeservicerequestactorid,im.maltreatmentid,im.householdkey,
            im.isjurisdiction,im.countyid,p.personid,im.incidentlocationtypekey,
			 coalesce(IM.Notes,'') notes,
             coalesce(inv.jointinvestigation,false) jointinvestigation,
             coalesce(inv.investigationsummary, '') AS investigationsummary,
            COALESCE(p.firstname,'')||' ' ||COALESCE(p.middlename,'') ||' ' ||COALESCE(p.lastname,'') ||' ' ||COALESCE(p.suffix,'')as personname,
			(SELECT json_agg(r)FROM (
                SELECT mur.roletypekey as role,mur.username 
                FROM maltreatmentjurisdictionuser mur
                WHERE  mur.maltreatmentid = im.maltreatmentid and mur.activeflag = 1
              )r) as roles,
			(select i.fatalitycommentaudittrail::jsonb
             from expunge.investigation_expunge i where i.investigationid =v_investigationid and i.activeflag=1 ORDER BY i.updatedon DESC LIMIT 1) as commentaudittrail,
              (SELECT json_agg(r)FROM (
                SELECT ex.*,u.fullname  
                FROM expungement ex
                left outer join userprofile u  on u.securityusersid =ex.updatedby
                WHERE  ex.maltreatmentid = im.maltreatmentid and im.activeflag = 1
              )r) as expungements,
			  (	SELECT json_agg(auditinfo) AS auditinfo   
					FROM (
						select ps.oldproviderid, ps.newproviderid, ps.providerchange , ps.reasonchange , ps.explainreason, ps.explainreasonlist, u2.fullname as approvedby, u.fullname as requestedby,
                         ps.oldproviderid, ps.newproviderid, ps.updatedon
                    	 from improviderswitchinfo ps
                         left join userprofile u2 on u2.securityusersid = ps.insertedby
                         left join userprofile u on u.securityusersid = ps.updatedby
                         where ps.objectid = im.maltreatmentid
						order by ps.insertedby desc
				) auditinfo  
			),
			(SELECT json_agg(docuphyscian)FROM (
				SELECT  dp.filename,  dp.title,  dp.mime,  dp.numberofbytes, dp.s3bucketpathname,  dp.originalfilename, dp.ecmsdocumentid,
				(select up.fullname as insertedby from userprofile up where up.securityusersid = dp.insertedby),dp.updatedon, dp.uploadstatus, dp.finalstatus                                                                                                                                                                                                                          
				from documentproperties dp where dp.objectid = ia.investigationallegationid and dp.objecttypekey='InvsFindPhysican' and dp.activeflag in (1,3,4,5)
			)docuphyscian) as expert_assessmnts_attachment,
			(SELECT json_agg(docuexpert) FROM(
				SELECT  dp.filename,  dp.title,  dp.mime,  dp.numberofbytes, dp.s3bucketpathname,  dp.originalfilename, dp.ecmsdocumentid,
				(select up.fullname as insertedby from userprofile up where up.securityusersid = dp.insertedby),dp.updatedon, dp.uploadstatus, dp.finalstatus                                                                                                                                                                                                                                
				from documentproperties dp where dp.objectid = ia.investigationallegationid and dp.objecttypekey='InvestigationFindingMed' and dp.activeflag in (1,3,4,5))
			docuexpert )::json as med_assessmnts_attachment ,
			(SELECT json_agg(doculaw) FROM(
				SELECT  dp.filename,  dp.title,  dp.mime,  dp.numberofbytes, dp.s3bucketpathname,  dp.originalfilename, dp.ecmsdocumentid,
				(select up.fullname as insertedby from userprofile up where up.securityusersid = dp.insertedby),dp.updatedon, dp.uploadstatus, dp.finalstatus                                                                                                                                                                                                                                
				from documentproperties dp where dp.objectid = ia.investigationallegationid and dp.objecttypekey='InvsFindlawEnforcement' and dp.activeflag in (1,3,4,5))
			doculaw )::json as law_enforcement_attachment ,
                      ia.investigationallegationid,ia.maltreatmentid,ia.allegationid ,im.enddate,
                      im.incidentlocationtypekey, ia.comments,
					  ia.victim_explanation,
					  ia.sibling_explanation,
					  ia.guardian_explanation,
                      ia.maltreator_explanation,
                      ia.med_assessmnts,
                      ia.expert_assessmnts,
                      ia.collateral_interviews,
                      ia.criminal_history_inv,
                      ia.home_conditions,
                      ia.law_enforcement_inv,
					  ia.injurycomments,
					  ia.incidentdate,ia.insertedon,ia.updatedon,ia.sextrafficking ,alle.name as name,
                	 COALESCE(ia.ischildfatality ,null) ischildfatality,ia.fatalitycomments,
					(SELECT json_agg(ind) FROM (
										SELECT 	(SELECT  array_to_string(array(
																SELECT	DISTINCT REPLACE(ivd.narrative,E'\n','<br>')
																FROM 	referralinvestigationdisposition ivd 
																WHERE	ivd.parentkeyid in (select ial.investigationallegationmaltreatorsid from expunge.investigationallegationmaltreators_expunge ial where ial.investigationallegationid = iai.investigationallegationid)	
																AND 	ivd.narrative IS NOT NULL 
																--ORDER BY ivd.insertedon ASC	
																), '<br><br>') 
														) as dispositionnarrative,
														iai.intakeservicerequestactorid,
                                                        iai.investigationallegationmaltreatorsid,
                                                        iai.othermaltreator,
														iai.oaicesentdate,
														iai.oahearingdatesetflag,
														iai.oahearingdate,
														iai.oanorhearingreason,
														iai.oahearingdecision,
														iai.oahearingdecisiondate,
														iai.oadetails,
														iai.oaappealedflag ,
														iai.oacasenumber,
														iai.oaldssname,
														iai.oarunningmotion,
														iai.oalocaldept,
														iai.oaappellentatrny,
														iai.oahearingheld,
														iai.oalocationofhearing,
														iai.oahearingnarrative,
														iai.oamodificationsmade,
														iai.oarunningmotiondate,
														iai.oatranslator,
														iai.oahearingheldreason,
														iai.oasummarydecisionfileddate,
														CASE
   														 WHEN iai.oasummarydecisionfiledflag IS NULL THEN NULL
   														 WHEN iai.oasummarydecisionfiledflag = 'false'  then  false 
   														 ELSE true
													     END
														as oasummarydecisionfiledflag,														
														CASE
   														 WHEN iai.oacompiledwithoah IS NULL THEN NULL
   														 WHEN iai.oacompiledwithoah='false'  then  false 
   														 ELSE true
													     END
														as oacompiledwithoah,

														iai.ccstayrequestedflag,
														iai.ccstaygrantedflag,
														iai.ccappealedflag,
														iai.cchearingdecisiontypekey, 
														iai.cchearingdecisiondate,
														iai.ccdetails,
														iai.cccasenumber,
														iai.cccompileddate,
														iai.cccourtdecisionflag ,
														iai.cccicuitcourtkey,
														iai.ccldssname,
														iai.ccappellentatrny,
														iai.ccwhoappealed,
														iai.ccnotifiedtodirector,
														iai.ccldssnotifieddate,
														iai.cclocationofhearing,
														iai.cchearingheld,
														iai.cchearingheldreason,
														
														iai.csastayrequestedflag ,
														iai.csastaygrantedflag,
														iai.csaappealedflag,
														iai.csahearingdecisiontypekey,
														iai.csahearingdecisiondate,
														iai.csadetails ,
														iai.csacasenumber,
														iai.csacourtdecisionflag ,
														iai.csacompileddate ,
														iai.csaldssname ,
														iai.csaappellentatrny ,
														iai.csaldssnotifieddate ,
														iai.csanotifiedtodirector ,
														iai.csawhoappealed ,
														iai.csaarguementheld,
														iai.csaarguementnotheldreason,
														
														iai.scicesentdate,
														iai.scconfheldflag ,
														iai.scdecisiontypekey ,
														iai.scconferencedetail ,
														iai.scconferencedate ,
														iai.scicesentdate,
														iai.scappealedby,
														iai.scappealeddate,
														iai.scisappealed,
														iai.scsummarymailed,
														iai.scappealedsetdate,
														iai.scisappealformsent,

														iai.overridefindingtypekey ,
														iai.overridecomments,
														iai.overrideapprflag ,
														
														iai.coastayreqflag ,
														iai.coastaygrantedflag ,
														iai.coaappealedflag ,
														iai.coacourtdecisionflag ,
														iai.coahearingdecisiontypekey ,
														iai.coadetails ,
														iai.coacasenumber ,
														iai.coacompileddate ,
														iai.coaldssname,
														iai.coaappellentatrny,
														iai.activeflag,
														iai.coacertdenieddate,
														iai.coacertgranteddate,
														iai.coacertioraristatus,
														iai.expungementflag,
														iai.insertedon,
														iai.finalizeddate,
														iai.oahmaltreatmenttypeid,
											            iai.ccmaltreatmenttypeid,
											            iai.csmaltreatmenttypeid,
											            iai.coamaltreatmenttypeid,
														iai.coahearingdecisiondate, CASE coalesce( iai.intakeservicerequestactorid :: character varying,'')  WHEN  '' 
							 THEN iai.othermaltreator ELSE concat_ws(' ',pr.firstname,pr.middlename,pr.lastname,pr.suffix) END  displayname ,pr.personid,
							 pr.cjamspid,
							(SELECT RS.description
								FROM  
								   actorrelationship AR 
                          		INNER JOIN 
									relationshiptype RS 
                                ON RS.relationshiptypekey = AR.relationshiptypekey 
                                	AND RS.activeflag = 1 AND AR.activeflag = 1
								Inner Join 
									expunge.intakeservicerequestactor_expunge israa
								on israa.intakeservicerequestactorid = AR.intakeservicerequestactorid 
									and (isra.activeflag = 1 or (isra.activeflag = 0 and isra.updatedby  = 'EXPUNG'))
								WHERE
									AR.person1id = p.personid and AR.person2id = isra.personid
									and israa.intakeserviceid = isra.intakeserviceid
								LIMIT 1
							) AS relationship

						    FROM expunge.Investigationallegationmaltreators_expunge iai
						    JOIN expunge.intakeservicerequestactor_expunge isra ON isra.intakeservicerequestactorid= iai.intakeservicerequestactorid and isra.intakeserviceid is not null --and isra.intakeservicerequestpersontypekey = 'AM'
							and (isra.activeflag = 1 or (isra.activeflag = 0 and isra.updatedby  = 'EXPUNG'))
                             -- AND isra.activeflag =1      commented for expungement to show even though AM role is removed		
						    JOIN person pr ON pr.personid= isra.personid AND pr.activeflag =1
							WHERE iai.investigationallegationid = ia.investigationallegationid and (iai.activeflag = 1 or (iai.activeflag = 0 and iai.updatedby  = 'EXPUNG'))
							order by iai.insertedon asc  )
                     ind )::json as maltreators,
                	 (SELECT json_agg(finding) FROM (
                         	SELECT IFN.investigationfindingtypekey as investigationfindingtypekey,
							IFN.investigationfindingid,
							 (SELECT  array_to_string(array(
															SELECT	DISTINCT REPLACE(ivf.findingcomments,E'\n','<br>')
															FROM 	expunge.investigationfinding_expunge ivf 
															WHERE	ivf.investigationallegationid =  IA.investigationallegationid AND ivf.activeflag =1
															AND 	ivf.findingcomments IS NOT NULL 								
															), '<br><br>') 
														) as findingcomments,
							IFN.isharm,IFN.isharmsubstantial,
							IFN.harmdesc,
							IFN.intentionalinjurydesc,
							IFN.omissiondesc,
							CASE WHEN IFN.finalfinding IS NULL THEN (SELECT iaml.overridefindingtypekey 
									FROM expunge.Investigationallegationmaltreators_expunge iaml 
									WHERE iaml.investigationallegationid = IFN.investigationallegationid AND iaml.activeflag =1 AND iaml.overrideapprflag =1 order by iaml.updatedon desc LIMIT 1) 
							ELSE IFN.finalfinding
							END AS finalfinding,
							(SELECT json_agg(ass)FROM(
								SELECT  
								ifna.firstname,ifna.lastname,
								ifna.comments,PT.typedescription,ifna.professiontypekey,ifna.isassessor
								FROM investigationfindingassessors ifna
								 LEFT JOIN professiontype PT ON ifna.professiontypekey = PT.professiontypekey 
								 WHERE ifna.investigationfindingid = IFN.investigationfindingid
							)ass ):: json as assessors
							FROM expunge.investigationfinding_expunge IFN
							WHERE IFN.investigationallegationid  =  IA.investigationallegationid and IFN.activeflag =1 LIMIT 1 )
                      	finding ) as findings,
                
					(SELECT json_agg(inj) FROM (
                                        SELECT iaai.injurytypekey,it.typedescription FROM investigationallegationinjury IAAI
									    JOIN injurytype it on iaai.injurytypekey =it.injurytypekey
									    AND it.activeflag = 1
										WHERE iaai.investigationallegationid = ia.investigationallegationid AND iaai.activeflag =1 ) 
                     inj )::json as injurytype,		
					(SELECT json_agg(characters) FROM(
                                        SELECT iamc.maltreatmentcharactersticstypekey ,mct.typedescription
										FROM investigationallegationcharacterstics iamc
										JOIN maltreatmentcharactersticstype mct on iamc.maltreatmentcharactersticstypekey = mct.maltreatmentcharactersticstypekey AND mct.activeflag =1 
										WHERE iamc.investigationallegationid = ia.investigationallegationid AND iamc.activeflag =1 )    
                     characters )::json as maltreatmentcharacterstics,
												
					(SELECT json_agg(injchar) FROM(
                                        SELECT iaic.injurycharactersticstypekey,ict.typedescription FROM investigationallegationinjurycharacterstics IAIC
									    JOIN injurycharactersticstype ict
									    ON ict.injurycharactersticstypekey = iaic.injurycharactersticstypekey AND ict.activeflag =1
										WHERE iaic.investigationallegationid = ia.investigationallegationid AND iaic.activeflag =1 )
                    injchar )::json as injurycharacterstics,
                    
                    (SELECT json_agg(docu) FROM(
                                        SELECT doc.s3bucketpathname,doc.originalfilename,doc.documentpropertiesid,doc.rootobjecttypekey, doc.ecmsdocumentid, doc.title, doc.filename , doc.actualdocumentdate, doc.other,
										(select up.fullname as insertedby from userprofile up where up.securityusersid = doc.insertedby), doc.updatedby,doc.updatedon,
										(select attachmentclassificationsubtypekey from documentattachment where documentpropertiesid = doc.documentpropertiesid),
	                                 	(select attachmenttypekey from documentattachment where documentpropertiesid = doc.documentpropertiesid),doc.uploadstatus,doc.finalstatus  
										FROM documentproperties doc
									    inner JOIN expunge.Investigationallegationmaltreators_expunge iai on iai.investigationallegationmaltreatorsid = doc.objectid and iai.investigationallegationid = ia.investigationallegationid
									    where doc.activeflag in (1,3,4,5)
									   )
                    docu )::json as documentprop,
					(SELECT json_agg(history) FROM(SELECT iahis.*, up.fullname FROM investigationallegation_history iahis
													INNER JOIN userprofile up on up.securityusersid = iahis.updatedby
													WHERE iahis.investigationallegationid = IA.investigationallegationid) history)::JSON AS investigationallegation_audit 	
			FROM   Investigationmaltreatment im 
            INNER JOIN expunge.Investigationmaltreatmentactor_expunge ima on ima.maltreatmentid = im.maltreatmentid AND ima.activeflag =1             							     
            INNER JOIN expunge.intakeservicerequestactor_expunge isra1 on isra1.intakeservicerequestactorid = ima.intakeservicerequestactorid and isra1.activeflag = 1
            INNER JOIN person p on p.personid = isra1.personid	
            INNER JOIN expunge.Investigationallegation_expunge ia ON  ia.maltreatmentid = im.maltreatmentid
            LEFT JOIN expunge.investigation_expunge inv on inv.investigationid = IM.investigationid									
    		INNER JOIN allegation  alle on  alle.allegationid = ia.allegationid AND alle.activeflag = 1
			WHERE im.investigationid = v_investigationid
            AND im.activeflag =1 and im.isnotapplicable =0
			 AND ia.investigationmaltreatmentactorid = ima.investigationmaltreatmentactorid 
			AND ia.activeflag =1 )  )as allegation;


    -- ------------------------------------------------------------------
    -- SCENARIO 2: PARTIALLY EXPUNGED (v_isexpunged = 2) - UNION ALL ACCESS
    -- ------------------------------------------------------------------
    ELSIF v_isexpunged = 2 THEN

SELECT json_agg(allegation) INTO l_investigation
FROM (
    WITH
    intakeservicerequestactor_combined AS (
        SELECT
            ia.intakeservicerequestactorid,
            ia.intakeserviceid,
            ia.activeflag,
            ia.updatedby,
            ia.personid AS personid_decr
        FROM expunge.intakeservicerequestactor_expunge ia
        WHERE ia.intakeserviceid = v_intakeserviceid
            AND ia.activeflag = 1
        UNION ALL
        SELECT
            ia.intakeservicerequestactorid,
            ia.intakeserviceid,
            ia.activeflag,
            ia.updatedby,
            ia.personid AS personid_decr
        FROM intakeservicerequestactor ia
        WHERE ia.intakeserviceid = v_intakeserviceid
            AND (ia.activeflag = 1 or (ia.activeflag = 0 and ia.updatedby  = 'EXPUNG'  and coalesce(ia.isexpunged,0) != 1))      
    ),
    investigationallegation_combined AS (
        SELECT
            ia.investigationid, 
            ia.investigationallegationid,
            ia.maltreatmentid,
            ia.investigationmaltreatmentactorid,
            ia.allegationid,
            ia.incidentdate,
            ia.insertedon,
            ia.updatedon,
            ia.sextrafficking,
            ia.ischildfatality,
            ia.fatalitycomments,
            ia.activeflag,
            ia.comments,
            ia.victim_explanation ,
            ia.sibling_explanation,
            ia.guardian_explanation,
            ia.maltreator_explanation,
            ia.med_assessmnts,
            ia.expert_assessmnts,
            ia.collateral_interviews,
            ia.criminal_history_inv,
            ia.home_conditions,
            ia.law_enforcement_inv,
            ia.injurycomments
        FROM expunge.investigationallegation_expunge ia
        WHERE ia.investigationid = v_investigationid
            AND ia.activeflag = 1
        UNION ALL
        SELECT
            ia.investigationid, 
            ia.investigationallegationid,
            ia.maltreatmentid,
            ia.investigationmaltreatmentactorid,
            ia.allegationid,
            ia.incidentdate,
            ia.insertedon,
            ia.updatedon,
            ia.sextrafficking,
            ia.ischildfatality,
            ia.fatalitycomments,
            ia.activeflag,
            ia.comments::text AS comments,
            ia.victim_explanation::text AS victim_explanation,
            ia.sibling_explanation::text AS sibling_explanation,
            ia.guardian_explanation::text AS guardian_explanation,
            ia.maltreator_explanation::text AS maltreator_explanation,
            ia.med_assessmnts::text AS med_assessmnts,
            ia.expert_assessmnts::text AS expert_assessmnts,
            ia.collateral_interviews::text AS collateral_interviews,
            ia.criminal_history_inv::text AS criminal_history_inv,
            ia.home_conditions::text AS home_conditions,
            ia.law_enforcement_inv::text AS law_enforcement_inv,
            ia.injurycomments::text AS injurycomments
        FROM investigationallegation ia
        WHERE ia.investigationid = v_investigationid
            AND ia.activeflag = 1
    ),
    investigationallegationmaltreators_combined AS (
        SELECT
            iai.investigationallegationmaltreatorsid,
            iai.investigationallegationid,
            iai.intakeservicerequestactorid,
            iai.othermaltreator,
            iai.oaicesentdate,
            iai.oahearingdatesetflag,
            iai.oahearingdate,
            iai.oanorhearingreason,
            iai.oahearingdecision,
            iai.oahearingdecisiondate,
            iai.oadetails,
            iai.oaappealedflag,
            iai.oacasenumber,
            iai.oaldssname,
            iai.oarunningmotion,
            iai.oalocaldept,
            iai.oaappellentatrny,
            iai.oahearingheld,
            iai.oalocationofhearing,
            iai.oahearingnarrative,
            iai.oamodificationsmade,
            iai.oarunningmotiondate,
            iai.oatranslator,
            iai.oahearingheldreason,
            iai.oasummarydecisionfileddate,
            CASE
                WHEN iai.oasummarydecisionfiledflag IS NULL THEN NULL
                WHEN iai.oasummarydecisionfiledflag = 'false' THEN FALSE
                ELSE TRUE
            END AS oasummarydecisionfiledflag,
            CASE
                WHEN iai.oacompiledwithoah IS NULL THEN NULL
                WHEN iai.oacompiledwithoah = 'false' THEN FALSE
                ELSE TRUE
            END AS oacompiledwithoah,
            iai.ccstayrequestedflag,
            iai.ccstaygrantedflag,
            iai.ccappealedflag,
            iai.cchearingdecisiontypekey,
            iai.cchearingdecisiondate,
            iai.ccdetails,
            iai.cccasenumber,
            iai.cccompileddate,
            iai.cccourtdecisionflag,
            iai.cccicuitcourtkey,
            iai.ccldssname,
            iai.ccappellentatrny,
            iai.ccwhoappealed,
            iai.ccnotifiedtodirector,
            iai.ccldssnotifieddate,
            iai.cclocationofhearing,
            iai.cchearingheld,
            iai.cchearingheldreason,
            iai.csastayrequestedflag,
            iai.csastaygrantedflag,
            iai.csaappealedflag,
            iai.csahearingdecisiontypekey,
            iai.csahearingdecisiondate,
            iai.csadetails,
            iai.csacasenumber,
            iai.csacourtdecisionflag,
            iai.csacompileddate,
            iai.csaldssname,
            iai.csaappellentatrny,
            iai.csaldssnotifieddate,
            iai.csanotifiedtodirector,
            iai.csawhoappealed,
            iai.csaarguementheld,
            iai.csaarguementnotheldreason,
            iai.scicesentdate,
            iai.scconfheldflag,
            iai.scdecisiontypekey,
            iai.scconferencedetail,
            iai.scconferencedate,
            iai.scappealedby,
            iai.scappealeddate,
            iai.scisappealed,
            iai.scsummarymailed,
            iai.scappealedsetdate,
            iai.scisappealformsent,
            iai.overridefindingtypekey,
            iai.overridecomments,
            iai.overrideapprflag,
            iai.coastayreqflag,
            iai.coastaygrantedflag,
            iai.coaappealedflag,
            iai.coacourtdecisionflag,
            iai.coahearingdecisiontypekey,
            iai.coadetails,
            iai.coacasenumber,
            iai.coacompileddate,
            iai.coaldssname,
            iai.coaappellentatrny,
            iai.activeflag,
            iai.updatedby,
            iai.updatedon,
            iai.coacertdenieddate,
            iai.coacertgranteddate,
            iai.coacertioraristatus,
            iai.expungementflag,
            iai.insertedon,
            iai.finalizeddate,
            iai.oahmaltreatmenttypeid,
            iai.ccmaltreatmenttypeid,
            iai.csmaltreatmenttypeid,
            iai.coamaltreatmenttypeid,
            iai.coahearingdecisiondate
        FROM expunge.investigationallegationmaltreators_expunge iai
        INNER JOIN investigationallegation_combined ia
            ON ia.investigationallegationid = iai.investigationallegationid
        WHERE ia.investigationid = v_investigationid and iai.activeflag=1 
        UNION ALL
        SELECT
            iai.investigationallegationmaltreatorsid,
            iai.investigationallegationid,
            iai.intakeservicerequestactorid,
            iai.othermaltreator,
            iai.oaicesentdate,
            iai.oahearingdatesetflag,
            iai.oahearingdate,
            iai.oanorhearingreason::text AS oanorhearingreason,
            iai.oahearingdecision::text AS oahearingdecision,
            iai.oahearingdecisiondate,
            iai.oadetails::text AS oadetails,
            iai.oaappealedflag,
            iai.oacasenumber,
            iai.oaldssname::text AS oaldssname,
            iai.oarunningmotion,
            iai.oalocaldept,
            iai.oaappellentatrny::text AS oaappellentatrny,
            iai.oahearingheld::text AS oahearingheld,
            iai.oalocationofhearing::text AS oalocationofhearing,
            iai.oahearingnarrative::text AS oahearingnarrative,
            iai.oamodificationsmade::text AS oamodificationsmade,
            iai.oarunningmotiondate,
            iai.oatranslator,
            iai.oahearingheldreason::text AS oahearingheldreason,
            iai.oasummarydecisionfileddate,
            iai.oasummarydecisionfiledflag::boolean AS oasummarydecisionfiledflag,
            iai.oacompiledwithoah::boolean AS oacompiledwithoah,
            iai.ccstayrequestedflag,
            iai.ccstaygrantedflag,
            iai.ccappealedflag,
            iai.cchearingdecisiontypekey::text AS cchearingdecisiontypekey,
            iai.cchearingdecisiondate,
            iai.ccdetails::text AS ccdetails,
            iai.cccasenumber::text AS cccasenumber,
            iai.cccompileddate,
            iai.cccourtdecisionflag,
            iai.cccicuitcourtkey::text AS cccicuitcourtkey,
            iai.ccldssname::text AS ccldssname,
            iai.ccappellentatrny::text AS ccappellentatrny,
            iai.ccwhoappealed,
            iai.ccnotifiedtodirector,
            iai.ccldssnotifieddate,
            iai.cclocationofhearing::text AS cclocationofhearing,
            iai.cchearingheld::text AS cchearingheld,
            iai.cchearingheldreason::text AS cchearingheldreason,
            iai.csastayrequestedflag,
            iai.csastaygrantedflag,
            iai.csaappealedflag,
            iai.csahearingdecisiontypekey::text AS csahearingdecisiontypekey,
            iai.csahearingdecisiondate,
            iai.csadetails::text AS csadetails,
            iai.csacasenumber::text AS csacasenumber,
            iai.csacourtdecisionflag,
            iai.csacompileddate,
            iai.csaldssname::text AS csaldssname,
            iai.csaappellentatrny::text AS csaappellentatrny,
            iai.csaldssnotifieddate,
            iai.csanotifiedtodirector,
            iai.csawhoappealed::text AS csawhoappealed,
            iai.csaarguementheld::text AS csaarguementheld,
            iai.csaarguementnotheldreason,
            iai.scicesentdate,
            iai.scconfheldflag,
            iai.scdecisiontypekey::text AS scdecisiontypekey,
            iai.scconferencedetail::text AS scconferencedetail,
            iai.scconferencedate,
            iai.scappealedby::text AS scappealedby,
            iai.scappealeddate,
            iai.scisappealed,
            iai.scsummarymailed,
            iai.scappealedsetdate,
            iai.scisappealformsent::text AS scisappealformsent,
            iai.overridefindingtypekey::text AS overridefindingtypekey,
            iai.overridecomments::text AS overridecomments,
            iai.overrideapprflag,
            iai.coastayreqflag,
            iai.coastaygrantedflag,
            iai.coaappealedflag,
            iai.coacourtdecisionflag,
            iai.coahearingdecisiontypekey,
            iai.coadetails::text AS coadetails,
            iai.coacasenumber,
            iai.coacompileddate,
            iai.coaldssname::text AS coaldssname,
            iai.coaappellentatrny::text AS coaappellentatrny,
            iai.activeflag,
            iai.updatedby,
            iai.updatedon,
            iai.coacertdenieddate,
            iai.coacertgranteddate,
            iai.coacertioraristatus,
            iai.expungementflag,
            iai.insertedon,
            iai.finalizeddate,
            iai.oahmaltreatmenttypeid,
            iai.ccmaltreatmenttypeid,
            iai.csmaltreatmenttypeid,
            iai.coamaltreatmenttypeid,
            iai.coahearingdecisiondate
        FROM investigationallegationmaltreators iai
        INNER JOIN investigationallegation_combined ia
            ON ia.investigationallegationid = iai.investigationallegationid
        WHERE ia.investigationid = v_investigationid and (iai.activeflag = 1 or (iai.activeflag = 0 and iai.updatedby  = 'EXPUNG' and coalesce(iai.isexpunged,0) != 1))
    ),
    investigationfinding_combined AS (
        SELECT
            ifn.investigationfindingid,
            ifn.investigationallegationid,
            ifn.isharm,
            ifn.isharmsubstantial,
            ifn.activeflag,
            ifn.investigationfindingtypekey,
            ifn.harmdesc,
            ifn.intentionalinjurydesc,
            ifn.omissiondesc,
            CASE
                WHEN ifn.finalfinding IS NULL THEN NULL
                ELSE ifn.finalfinding
            END AS finalfinding_text,
            ifn.updatedon
        FROM expunge.investigationfinding_expunge ifn
        INNER JOIN investigationallegation_combined ia
            ON ia.investigationallegationid = ifn.investigationallegationid
        WHERE ia.investigationid = v_investigationid and ifn.activeflag=1
        UNION ALL
        SELECT
            ifn.investigationfindingid,
            ifn.investigationallegationid,
            ifn.isharm,
            ifn.isharmsubstantial,
            ifn.activeflag,
            ifn.investigationfindingtypekey::text AS investigationfindingtypekey,
            ifn.harmdesc::text AS harmdesc,
            ifn.intentionalinjurydesc::text AS intentionalinjurydesc,
            ifn.omissiondesc::text AS omissiondesc,
            ifn.finalfinding::text AS finalfinding_text,
            ifn.updatedon
        FROM investigationfinding ifn
        INNER JOIN investigationallegation ia
            ON ia.investigationallegationid = ifn.investigationallegationid
        WHERE ia.investigationid = v_investigationid and ifn.activeflag=1
    )
    (
        SELECT
            l_reporteddate as reporteddate,
            ima.intakeservicerequestactorid,
            im.maltreatmentid,
            im.householdkey,
            im.isjurisdiction,
            im.countyid,
            p.personid,
            im.incidentlocationtypekey,
            coalesce(IM.Notes,'') notes,
            coalesce(inv.jointinvestigation,false) jointinvestigation,
            coalesce(inv.investigationsummary, '') AS investigationsummary,
            COALESCE(p.firstname,'')||' ' ||COALESCE(p.middlename,'') ||' ' ||COALESCE(p.lastname,'') ||' ' ||COALESCE(p.suffix,'')as personname,
            (SELECT json_agg(r)FROM (
                SELECT mur.roletypekey as role,mur.username 
                FROM maltreatmentjurisdictionuser mur
                WHERE  mur.maltreatmentid = im.maltreatmentid and mur.activeflag = 1
            )r) as roles,
            (SELECT i.fatalitycommentaudittrail::jsonb
             FROM investigation i
             WHERE i.investigationid = v_investigationid and i.activeflag=1
             ORDER BY i.updatedon DESC LIMIT 1) as commentaudittrail,
            (SELECT json_agg(r)FROM (
                SELECT ex.*,u.fullname  
                FROM expungement ex
                left outer join userprofile u  on u.securityusersid =ex.updatedby
                WHERE  ex.maltreatmentid = im.maltreatmentid and im.activeflag = 1
            )r) as expungements,
            
            (	SELECT json_agg(auditinfo) AS auditinfo   
                FROM (
                    select ps.oldproviderid, ps.newproviderid, ps.providerchange , ps.reasonchange , ps.explainreason, ps.explainreasonlist, u2.fullname as approvedby, u.fullname as requestedby,
                           ps.oldproviderid, ps.newproviderid, ps.updatedon
                    from improviderswitchinfo ps
                    left join userprofile u2 on u2.securityusersid = ps.insertedby
                    left join userprofile u on u.securityusersid = ps.updatedby
                    where ps.objectid = im.maltreatmentid
                    order by ps.insertedby desc
                ) auditinfo  
            ),
            (SELECT json_agg(docuphyscian)FROM (
                SELECT  dp.filename,  dp.title,  dp.mime,  dp.numberofbytes, dp.s3bucketpathname,  dp.originalfilename, dp.ecmsdocumentid,
                (select up.fullname as insertedby from userprofile up where up.securityusersid = dp.insertedby),dp.updatedon, dp.uploadstatus, dp.finalstatus                                                                                                                                                                                                                          
                from documentproperties dp where dp.objectid = ia.investigationallegationid and dp.objecttypekey='InvsFindPhysican' and dp.activeflag in (1,3,4,5)
            )docuphyscian) as expert_assessmnts_attachment,
            (SELECT json_agg(docuexpert) FROM(
                SELECT  dp.filename,  dp.title,  dp.mime,  dp.numberofbytes, dp.s3bucketpathname,  dp.originalfilename, dp.ecmsdocumentid,
                (select up.fullname as insertedby from userprofile up where up.securityusersid = dp.insertedby),dp.updatedon, dp.uploadstatus, dp.finalstatus                                                                                                                                                                                                                                
                from documentproperties dp where dp.objectid = ia.investigationallegationid and dp.objecttypekey='InvestigationFindingMed' and dp.activeflag in (1,3,4,5))
            docuexpert )::json as med_assessmnts_attachment ,
            (SELECT json_agg(doculaw) FROM(
                SELECT  dp.filename,  dp.title,  dp.mime,  dp.numberofbytes, dp.s3bucketpathname,  dp.originalfilename, dp.ecmsdocumentid,
                (select up.fullname as insertedby from userprofile up where up.securityusersid = dp.insertedby),dp.updatedon, dp.uploadstatus, dp.finalstatus                                                                                                                                                                                                                                
                from documentproperties dp where dp.objectid = ia.investigationallegationid and dp.objecttypekey='InvsFindlawEnforcement' and dp.activeflag in (1,3,4,5))
            doculaw )::json as law_enforcement_attachment ,
            ia.investigationallegationid,ia.maltreatmentid,ia.allegationid ,im.enddate,
            im.incidentlocationtypekey,
            ia.comments::text as comments,
            ia.victim_explanation::text as victim_explanation,
            ia.sibling_explanation::text as sibling_explanation,
            ia.guardian_explanation::text as guardian_explanation,
            ia.maltreator_explanation::text as maltreator_explanation,
            ia.med_assessmnts::text as med_assessmnts,
            ia.expert_assessmnts::text as expert_assessmnts,
            ia.collateral_interviews::text as collateral_interviews,
            ia.criminal_history_inv::text as criminal_history_inv,
            ia.home_conditions::text as home_conditions,
            ia.law_enforcement_inv::text as law_enforcement_inv,
            ia.injurycomments::text as injurycomments,
            ia.incidentdate,ia.insertedon,ia.updatedon,ia.sextrafficking ,alle.name as name,
            COALESCE(ia.ischildfatality ,null) ischildfatality,ia.fatalitycomments,
            (SELECT json_agg(ind) FROM (
                SELECT
                    (SELECT  array_to_string(array(
                        SELECT DISTINCT REPLACE(ivd.narrative,E'\n','<br>')
                        FROM referralinvestigationdisposition ivd 
                        WHERE ivd.parentkeyid in (
                            select ial.investigationallegationmaltreatorsid
                            from investigationallegationmaltreators_combined ial
                            where ial.investigationallegationid = iai.investigationallegationid
                        )
                        AND ivd.narrative IS NOT NULL 
                    ), '<br><br>')) as dispositionnarrative,
                    iai.intakeservicerequestactorid,
                    iai.investigationallegationmaltreatorsid,
                    iai.othermaltreator,
                    iai.oaicesentdate,
                    iai.oahearingdatesetflag,
                    iai.oahearingdate,
                    iai.oanorhearingreason,
                    iai.oahearingdecision,
                    iai.oahearingdecisiondate,
                    iai.oadetails,
                    iai.oaappealedflag,
                    iai.oacasenumber,
                    iai.oaldssname,
                    iai.oarunningmotion,
                    iai.oalocaldept,
                    iai.oaappellentatrny,
                    iai.oahearingheld,
                    iai.oalocationofhearing,
                    iai.oahearingnarrative,
                    iai.oamodificationsmade,
                    iai.oarunningmotiondate,
                    iai.oatranslator,
                    iai.oahearingheldreason,
                    iai.oasummarydecisionfileddate,
                    iai.oasummarydecisionfiledflag,
                    iai.oacompiledwithoah,
                    iai.ccstayrequestedflag,
                    iai.ccstaygrantedflag,
                    iai.ccappealedflag,
                    iai.cchearingdecisiontypekey,
                    iai.cchearingdecisiondate,
                    iai.ccdetails,
                    iai.cccasenumber,
                    iai.cccompileddate,
                    iai.cccourtdecisionflag,
                    iai.cccicuitcourtkey,
                    iai.ccldssname,
                    iai.ccappellentatrny,
                    iai.ccwhoappealed,
                    iai.ccnotifiedtodirector,
                    iai.ccldssnotifieddate,
                    iai.cclocationofhearing,
                    iai.cchearingheld,
                    iai.cchearingheldreason,
                    iai.csastayrequestedflag,
                    iai.csastaygrantedflag,
                    iai.csaappealedflag,
                    iai.csahearingdecisiontypekey,
                    iai.csahearingdecisiondate,
                    iai.csadetails,
                    iai.csacasenumber,
                    iai.csacourtdecisionflag,
                    iai.csacompileddate,
                    iai.csaldssname,
                    iai.csaappellentatrny,
                    iai.csaldssnotifieddate,
                    iai.csanotifiedtodirector,
                    iai.csawhoappealed,
                    iai.csaarguementheld,
                    iai.csaarguementnotheldreason,
                    iai.scicesentdate,
                    iai.scconfheldflag,
                    iai.scdecisiontypekey,
                    iai.scconferencedetail,
                    iai.scconferencedate,
                    iai.scappealedby,
                    iai.scappealeddate,
                    iai.scisappealed,
                    iai.scsummarymailed,
                    iai.scappealedsetdate,
                    iai.scisappealformsent,
                    iai.overridefindingtypekey,
                    iai.overridecomments,
                    iai.overrideapprflag,
                    iai.coastayreqflag,
                    iai.coastaygrantedflag,
                    iai.coaappealedflag,
                    iai.coacourtdecisionflag,
                    iai.coahearingdecisiontypekey,
                    iai.coadetails,
                    iai.coacasenumber,
                    iai.coacompileddate,
                    iai.coaldssname,
                    iai.coaappellentatrny,
                    iai.activeflag,
                    iai.coacertdenieddate,
                    iai.coacertgranteddate,
                    iai.coacertioraristatus,
                    iai.expungementflag,
                    iai.insertedon,
                    iai.finalizeddate,
                    iai.oahmaltreatmenttypeid,
                    iai.ccmaltreatmenttypeid,
                    iai.csmaltreatmenttypeid,
                    iai.coamaltreatmenttypeid,
                    iai.coahearingdecisiondate,
                    CASE coalesce( iai.intakeservicerequestactorid :: character varying,'')  WHEN  '' 
                        THEN iai.othermaltreator
                        ELSE concat_ws(' ',pr.firstname,pr.middlename,pr.lastname,pr.suffix)
                    END displayname,
                    pr.personid,
                    pr.cjamspid,
                    (SELECT RS.description
                        FROM actorrelationship AR 
                        INNER JOIN relationshiptype RS 
                            ON RS.relationshiptypekey = AR.relationshiptypekey 
                            AND RS.activeflag = 1 AND AR.activeflag = 1
                        INNER JOIN intakeservicerequestactor_combined israa
                            on israa.intakeservicerequestactorid = AR.intakeservicerequestactorid 
                        WHERE
                            AR.person1id = p.personid and AR.person2id = isra.personid_decr
                            and israa.intakeserviceid = isra.intakeserviceid
                        LIMIT 1
                    ) AS relationship
                FROM investigationallegationmaltreators_combined iai
                JOIN intakeservicerequestactor_combined isra
                    ON isra.intakeservicerequestactorid = iai.intakeservicerequestactorid
                    AND isra.intakeserviceid is not null

                JOIN person pr
                    ON pr.personid = isra.personid_decr AND pr.activeflag = 1
                WHERE iai.investigationallegationid = ia.investigationallegationid

                order by iai.insertedon asc
            ) ind )::json as maltreators,
            (SELECT json_agg(finding) FROM (
                SELECT
                    IFN.investigationfindingtypekey::text as investigationfindingtypekey,
                    IFN.investigationfindingid,
                    (SELECT array_to_string(array(
                        SELECT DISTINCT REPLACE(ivf.findingcomments,E'\n','<br>')
                        FROM expunge.investigationfinding_expunge ivf 
                        WHERE ivf.investigationallegationid = IA.investigationallegationid AND ivf.activeflag =1
                        AND ivf.findingcomments IS NOT NULL
                        UNION
                        SELECT DISTINCT REPLACE(ivf_n.findingcomments::text,E'\n','<br>')
                        FROM investigationfinding ivf_n
                        WHERE ivf_n.investigationallegationid = IA.investigationallegationid AND ivf_n.activeflag =1
                        AND ivf_n.findingcomments IS NOT NULL
                    ), '<br><br>')) as findingcomments,
                    IFN.isharm,
                    IFN.isharmsubstantial,
                    IFN.harmdesc::text as harmdesc,
                    IFN.intentionalinjurydesc::text as intentionalinjurydesc,
                    IFN.omissiondesc::text as omissiondesc,
                    CASE WHEN IFN.finalfinding_text IS NULL THEN (
                        SELECT iaml.overridefindingtypekey::text
                        FROM investigationallegationmaltreators_combined iaml
                        WHERE iaml.investigationallegationid = IFN.investigationallegationid
                        AND iaml.overrideapprflag = 1
                        ORDER BY iaml.updatedon DESC LIMIT 1
                    )
                    ELSE IFN.finalfinding_text::text
                    END AS finalfinding,
                    (SELECT json_agg(ass)FROM(
                        SELECT  
                            ifna.firstname,ifna.lastname,
                            ifna.comments,PT.typedescription,ifna.professiontypekey,ifna.isassessor
                        FROM investigationfindingassessors ifna
                        LEFT JOIN professiontype PT ON ifna.professiontypekey = PT.professiontypekey 
                        WHERE ifna.investigationfindingid = IFN.investigationfindingid
                    )ass ):: json as assessors
                FROM investigationfinding_combined IFN
                WHERE IFN.investigationallegationid  =  IA.investigationallegationid and IFN.activeflag =1 LIMIT 1
            ) finding ) as findings,
            (SELECT json_agg(inj) FROM (
                SELECT iaai.injurytypekey,it.typedescription FROM investigationallegationinjury IAAI
                JOIN injurytype it on iaai.injurytypekey =it.injurytypekey
                AND it.activeflag = 1
                WHERE iaai.investigationallegationid = ia.investigationallegationid AND iaai.activeflag =1 )
            inj )::json as injurytype,
            (SELECT json_agg(characters) FROM(
                SELECT iamc.maltreatmentcharactersticstypekey ,mct.typedescription
                FROM investigationallegationcharacterstics iamc
                JOIN maltreatmentcharactersticstype mct on iamc.maltreatmentcharactersticstypekey = mct.maltreatmentcharactersticstypekey AND mct.activeflag =1 
                WHERE iamc.investigationallegationid = ia.investigationallegationid AND iamc.activeflag =1 )
            characters )::json as maltreatmentcharacterstics,
            (SELECT json_agg(injchar) FROM(
                SELECT iaic.injurycharactersticstypekey,ict.typedescription FROM investigationallegationinjurycharacterstics IAIC
                JOIN injurycharactersticstype ict
                ON ict.injurycharactersticstypekey = iaic.injurycharactersticstypekey AND ict.activeflag =1
                WHERE iaic.investigationallegationid = ia.investigationallegationid AND iaic.activeflag =1 )
            injchar )::json as injurycharacterstics,
            (SELECT json_agg(docu) FROM(
                SELECT doc.s3bucketpathname,doc.originalfilename,doc.documentpropertiesid,doc.rootobjecttypekey, doc.ecmsdocumentid, doc.title, doc.filename , doc.actualdocumentdate, doc.other,
                (select up.fullname as insertedby from userprofile up where up.securityusersid = doc.insertedby), doc.updatedby,doc.updatedon,
                (select attachmentclassificationsubtypekey from documentattachment where documentpropertiesid = doc.documentpropertiesid),
                (select attachmenttypekey from documentattachment where documentpropertiesid = doc.documentpropertiesid),doc.uploadstatus,doc.finalstatus  
                FROM documentproperties doc
                inner JOIN (
                    SELECT investigationallegationmaltreatorsid, investigationallegationid
                    FROM expunge.investigationallegationmaltreators_expunge
                    UNION ALL
                    SELECT investigationallegationmaltreatorsid, investigationallegationid
                    FROM investigationallegationmaltreators
                    WHERE NOT EXISTS (SELECT 1 FROM expunge.investigationallegationmaltreators_expunge e WHERE e.investigationallegationmaltreatorsid = investigationallegationmaltreators.investigationallegationmaltreatorsid)
                ) iai on iai.investigationallegationmaltreatorsid = doc.objectid and iai.investigationallegationid = ia.investigationallegationid
                where doc.activeflag in (1,3,4,5)
            ) docu )::json as documentprop,
            (SELECT json_agg(history) FROM(
                SELECT iahis.*, up.fullname FROM investigationallegation_history iahis
                INNER JOIN userprofile up on up.securityusersid = iahis.updatedby
                WHERE iahis.investigationallegationid = IA.investigationallegationid
            ) history)::JSON AS investigationallegation_audit
        FROM Investigationmaltreatment im
        INNER JOIN investigationmaltreatmentactor ima
            on ima.maltreatmentid = im.maltreatmentid AND ima.activeflag = 1
        INNER JOIN intakeservicerequestactor_combined isra1
            on isra1.intakeservicerequestactorid = ima.intakeservicerequestactorid 
        INNER JOIN person p
            on p.personid = isra1.personid_decr
        INNER JOIN investigationallegation_combined ia
            ON ia.maltreatmentid = im.maltreatmentid
        LEFT JOIN investigation inv
            on inv.investigationid = IM.investigationid
        INNER JOIN allegation alle
            on alle.allegationid = ia.allegationid AND alle.activeflag = 1
        WHERE im.investigationid = v_investigationid
            AND im.activeflag = 1 and im.isnotapplicable = 0
            AND ia.investigationmaltreatmentactorid = ima.investigationmaltreatmentactorid
    )
) as allegation;


    
    END IF;

    raise notice 'l_investigation --> %', l_investigation;
    return l_investigation;        
END;
$function$
;
