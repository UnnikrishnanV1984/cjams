DROP FUNCTION IF EXISTS  cjams.getinvestigationallegation_expunge(uuid);
CREATE OR REPLACE FUNCTION cjams.getinvestigationallegation_expunge(v_investigationid uuid)
 RETURNS json
 LANGUAGE plpgsql
AS $function$

------------------------------------------------------------------------
-- Revision(s)
-- 07/08/2024 - Kapila Mandhadi - CIDM-8743 - added a comments field when user changing contributing factor dropdown value
-- 11/17/2025 -Umasanakar raavi - CIDM-10890 - CJAMS Manual & Automation Expungement Enhancement - for Sexual Abuse CPS Intakes and Cases
-- 11/17/2025 Umasanakar raavi - CIDM-10890 - CJAMS Manual & Automation Expungement Enhancement--Removed EXPUNG condition and restricted intakeservicerequestactor filtering to active records only
------------------------------------------------------------------------

DECLARE  l_investigation  json;
DECLARE  l_count  int;
l_serviceid  uuid;
v_isexpunged integer;

BEGIN

    SELECT count(1) INTO l_count FROM Investigationmaltreatment WHERE investigationid = v_investigationid;
    SELECT intakeserviceid INTO l_serviceid FROM investigation WHERE investigationid = v_investigationid;

    SELECT iscaseexpunged INTO v_isexpunged FROM iscaseexpunged('Case',l_serviceid::character varying);

    IF v_isexpunged = 1 THEN
if  (COALESCE(l_count,0)  =0)    THEN
    SELECT  json_agg(a)  INTO  l_investigation  FROM  (
  	    SELECT  p.personid,
                      MAX(  p.firstname  ||  '  '||  p.lastname)  personname,
		p.dateofdeath,p.dob,
		      rs.description  as  relationship,  
                      MAX(isa.intakeservicerequestactorid  ::  character  varying    )  intakeservicerequestactorid
            FROM  expunge.intakeservicerequestactor_expunge  isa  
            INNER  JOIN  expunge.actor_expunge  a  ON  a.actorid  =  isa.actorid  and  a.activeflag  =1
            INNER JOIN actortype act on act.actortype = isa.intakeservicerequestpersontypekey and act.activeflag = 1 
            INNER  JOIN  person  p  ON  p.personid  =  a.personid  
            AND  p.activeflag  =1  
	    LEFT  JOIN  actorrelationship  ar  on  isa.intakeservicerequestactorid  =  ar.intakeservicerequestactorid  and  ar.activeflag  =1
	    LEFT  JOIN  relationshiptype  rs   ON  rs.relationshiptypekey  =  ar.relationshiptypekey  
            AND  rs.activeflag  =  1  
            WHERE  isa.intakeserviceid  =l_serviceid  AND isa.intakeservicerequestpersontypekey = 'CHILD'
            AND  isa.activeflag  =1
            AND  act.rolegroup = 'C'  
            GROUP  BY  p.personid,rs.description,p.dateofdeath,p.dob
    )as  a;
  ELSE
      SELECT  json_agg(a)  INTO  l_investigation  
              FROM  (
	  SELECT  isra.actorid,ima.intakeservicerequestactorid,im.maltreatmentid,im.householdkey,im.providerid,im.providername,im.providerphonenumber,
                        im.isjurisdiction,im.countyid,p.personid,im.incidentlocationtypekey,im.isnotapplicable,im.notapplicablecomments,
                        CASE  (im.isreported) WHEN  'true'  THEN  'reported' ELSE   'identifer' end as isreported,
                        COALESCE(p.firstname,'')||'  '  ||COALESCE(p.lastname,'')  as  personname,p.dateofdeath,p.dob,
                            rs.description  as  relationship,
			
			(SELECT  json_agg(r)FROM  (
                                SELECT  mur.roletypekey  as  role,mur.username  
                                FROM  maltreatmentjurisdictionuser  mur
                                WHERE    mur.maltreatmentid  =  im.maltreatmentid  and  mur.activeflag  =  1
                            )r)  as  roles,
		        (SELECT  json_agg(a)  FROM(
                                          SELECT  ia.investigationallegationid,ia.maltreatmentid,ia.allegationid,ia.sextrafficking,ia.enddate,
                                          ia.isapproximatedate,ia.timeofincidence,
                                          ia.incidentlocationtypekey,
                                          ia.name,
                                          ia.indicators,
                                          ia.comments,
					  ia.injurycomments,
					  ia.incidentdate,ia.sextrafficking  ,alle.name  as  allegationname,ia.isproviderinvolved,ia.outcome,
                    COALESCE(ia.ischildfatality ,null) ischildfatality,ia.fatalitycomments,
					 rv.description as allegationstatusdesc,
					 ia.investigationallegationstatus as investigationalegationstatuskey,ia.relationshiptypekey,rst.description as relationtypedesc,
					 	  (	SELECT json_agg(auditinfo) AS auditinfo   
					FROM (
						select ps.oldproviderid, newproviderid, providerchange ,reasonchange , explainreason, explainreasonlist, u2.fullname as approvedby, u.fullname as requestedby, ps.updatedon
                    	 from improviderswitchinfo ps
                         left join userprofile u2 on u2.securityusersid = ps.insertedby
                         left join userprofile u on u.securityusersid = ps.updatedby
                         where ps.objectid = im.maltreatmentid
						order by ps.insertedby desc
				) auditinfo  
			),					 
					(SELECT  json_agg(ind)  FROM  (
                                                        SELECT  iai.intakeservicerequestactorid  ,  
                                                	  CASE  coalesce(  iai.intakeservicerequestactorid  ::  character  varying,'')    WHEN    ''  
							  THEN  iai.othermaltreator  ELSE  (pr.lastname  ||',  '  ||  pr.firstname  )  END    Personname  ,pr.personid,
                                                        (SELECT  
                                                      	RS.description      FROM  expunge.intakeservicerequestactor_expunge  ISR  
                                                                      INNER  JOIN  actorrelationship  AR  
                                                                    ON  AR.intakeservicerequestactorid  =  ISR.intakeservicerequestactorid  
                                                		      AND  AR.activeflag  =  1  
                                                    			  INNER  JOIN  relationshiptype  RS  
                                                                    ON  RS.relationshiptypekey  =  AR.relationshiptypekey  
                                                                          AND  RS.activeflag  =  1  
                                                          WHERE  ISR.intakeservicerequestactorid  =    iai.intakeservicerequestactorid  
                                                          --AND  ISR.ISPRIMARY  =TRUE
                                                          AND  ISR.intakeserviceid  =  l_serviceid  LIMIT  1)
                                                          AS  relationship  
						        FROM  expunge.Investigationallegationmaltreators_expunge  iai
						        LEFT  JOIN  expunge.intakeservicerequestactor_expunge  isra  ON  isra.intakeservicerequestactorid=  iai.intakeservicerequestactorid
                                                          AND  isra.activeflag  =1            		
						        LEFT  JOIN  person  pr  ON  pr.personid=  isra.personid  AND  pr.activeflag  =1
							WHERE  iai.investigationallegationid  =  ia.investigationallegationid)
                                          ind  )::json  as  maltreators,
							
					(SELECT  json_agg(inj)  FROM  (
                                                                                SELECT  iaai.injurytypekey,it.typedescription  FROM  investigationallegationinjury  IAAI
									        JOIN  injurytype  it  on  iaai.injurytypekey  =it.injurytypekey
									        AND  it.activeflag  =  1
										WHERE  iaai.investigationallegationid  =  ia.investigationallegationid  AND  iaai.activeflag  =1  )  
                                          inj  )::json  as  injurytype,		
					(SELECT  json_agg(characters)  FROM(
                                                                                SELECT  iamc.maltreatmentcharactersticstypekey  ,mct.typedescription
										FROM  investigationallegationcharacterstics  iamc
										JOIN  maltreatmentcharactersticstype  mct  on  iamc.maltreatmentcharactersticstypekey  =  mct.maltreatmentcharactersticstypekey  AND  mct.activeflag  =1  
										WHERE  iamc.investigationallegationid  =  ia.investigationallegationid  AND  iamc.activeflag  =1  )        
                                          characters  )::json  as  maltreatmentcharactersticstypekey,
												
			
					(SELECT  json_agg(injchar)  FROM(
                                                                                SELECT  iaic.injurycharactersticstypekey,ict.typedescription  FROM  investigationallegationinjurycharacterstics  IAIC
									        JOIN  injurycharactersticstype  ict
									        ON  ict.injurycharactersticstypekey  =  iaic.injurycharactersticstypekey  AND  ict.activeflag  =1
										WHERE  iaic.investigationallegationid  =  ia.investigationallegationid  AND  iaic.activeflag  =1  )
                                        injchar  )::json  as  injurycharactersticstype,
					
					(SELECT  json_agg(providermaltreatment)  FROM(
						SELECT  pmt.typedescription,pmt.providermaltreatmenttypekey
						FROM  allegationprovidermaltreatment  apm
						INNER  JOIN  providermaltreatmenttype  pmt  ON  pmt.providermaltreatmenttypekey  =  apm.providermaltreatmenttypekey  AND  pmt.activeflag  =1
						WHERE  apm.investigationallegationid  =  ia.investigationallegationid  AND  apm.activeflag  =1  )
                                        providermaltreatment  )::json  as  providermaltreatment,
                                        
        
                                         (SELECT  json_agg(indicator)  FROM(
						SELECT  distinct(iai.indicatorid),ind.indicatorname
						FROM expunge.investigationallegation_expunge IAA
						 inner join investigationallegationindicator  iai on IAA.investigationallegationid=iai.investigationallegationid
						INNER  JOIN  "indicator"  ind  ON  iai.indicatorid  =  ind.indicatorid  AND  iai.activeflag  =1
						WHERE  IAA.investigationid=ia.investigationid  and iaa.maltreatmentid=im.maltreatmentid AND  IAA.activeflag  =1   )
                                        indicator  )::json  as  indicator ,
                            (SELECT  json_agg(indicator)  FROM(
										select * from expungement ex where  ex.maltreatmentid = ia.maltreatmentid and 
										    ex.activeflag  =1   )
                                        indicator  )::json  as  expungement,ia.expungementflag,im.isnotapplicable,im.notapplicablecomments
			FROM  expunge.investigationallegation_expunge  ia  
        		JOIN  allegation    alle  on    alle.allegationid  =  ia.allegationid  AND  alle.activeflag  =  1
        		left join referencevalues rv on rv.ref_key=ia.investigationallegationstatus and rv.activeflag=1
        		left join relationshiptype rst on rst.relationshiptypekey  =  ia.relationshiptypekey and rst.activeflag=1
			WHERE  ia.maltreatmentid  =  im.maltreatmentid
									--AND  ia.investigationmaltreatmentactorid  =  ima.investigationmaltreatmentactorid 
									AND  ia.activeflag  =1  )  a)  as  investigationallegation
									FROM  Investigationmaltreatment  im  
									LEFT  JOIN  expunge.investigationmaltreatmentactor_expunge  ima  on  ima.maltreatmentid  =  im.maltreatmentid  AND  ima.activeflag  =1                          							          
                                                                        LEFT  JOIN  expunge.intakeservicerequestactor_expunge  isra  on  isra.intakeservicerequestactorid  =  ima.intakeservicerequestactorid
									LEFT  JOIN  actorrelationship  ar  on  isra.intakeservicerequestactorid  =  ar.intakeservicerequestactorid  and  ar.activeflag  =1
									LEFT  JOIN  relationshiptype  rs  
									ON  rs.relationshiptypekey  =  ar.relationshiptypekey  
										AND  rs.activeflag  =  1  
										
                      							LEFT  JOIN  person  p  on  p.personid  =  isra.personid	
                      						--	left join referencevalues rv on rv.ref_key=ia.investigationallegationstatus
  									WHERE  im.investigationid  =  v_investigationid
									AND  im.activeflag  =1    
      		UNION  ALL
		
                  SELECT  isa.actorid,isa.intakeservicerequestactorid,  
                            	  NULL  ::uuid,
                                  null  householdkey, null providerid,null providername,null providerphonenumber, null    isjurisdiction,
                                  null    countyid,P.personid,NULL,NULL,NULL, null isreported,
                  		MAX(COALESCE(P.firstname,'')||'  '  ||COALESCE(P.lastname,''))  as  personname,
				p.dateofdeath,p.dob,
				rs.description  as  relationship,
				null    ::  json  as  role,
                	        null  ::  json  as  investigationallegation
		
		          FROM    expunge.intakeservicerequestactor_expunge  isa    
                          INNER  JOIN  expunge.actor_expunge  a  ON  a.actorid  =  isa.actorid
                                          AND  a.activeflag  =1
                          INNER  JOIN  person  P  ON  P.personid  =  a.personid  
                                          AND  P.activeflag  =1  
                          INNER JOIN actortype act ON act.actortype = isa.intakeservicerequestpersontypekey 
                          				  AND act.activeflag = 1 
			  LEFT  JOIN  actorrelationship  ar  on  isa.intakeservicerequestactorid  =  ar.intakeservicerequestactorid  and  ar.activeflag  =1
			  LEFT  JOIN  relationshiptype  rs  
                          ON  rs.relationshiptypekey  =  ar.relationshiptypekey  
                          AND  rs.activeflag  =  1  		  
			  WHERE  ISA.intakeserviceid  =l_serviceid                          
              	  	  AND  isa.activeflag    =1  AND  act.rolegroup = 'C' AND isa.intakeservicerequestpersontypekey = 'CHILD'
              		  AND  P.personid  NOT  IN  (
                        		SELECT  insra.personid  FROM    expunge.intakeservicerequestactor_expunge  insra
					INNER  JOIN  expunge.investigationmaltreatmentactor_expunge  ima
					ON  insra.intakeservicerequestactorid  =  ima.intakeservicerequestactorid
                                			INNER  JOIN    Investigationmaltreatment  im      
                                			ON  IM.maltreatmentid  =  ima.maltreatmentid
                                			AND  IM.investigationid  =  v_investigationid
                        				AND  IM.activeflag  =1          )  
                              GROUP  by      ISA.actorid,ISA.intakeservicerequestactorid,P.personid,rs.description
		)a  ;
END  IF; 

ELSIF v_isexpunged = 2 THEN
   
IF (COALESCE(l_count,0) = 0) THEN
           SELECT json_agg(a) INTO l_investigation
        FROM (
            --------------------------------------------------------------------------
            -- COMMON TABLE EXPRESSIONS (CTEs) FOR EXPUNGED/NORMAL UNION & EXPUNGEMENT
            --------------------------------------------------------------------------
            WITH
            -- 1. intakeservicerequestactor_combined: Defines all key fields with _decr alias
            intakeservicerequestactor_combined AS (
                -- Expunged records
                SELECT
                    ia.intakeservicerequestactorid,
                    ia.intakeserviceid,
                    ia.actorid,
                    ia.activeflag,
                    ia.updatedby,
                    ia.personid AS personid_decr,
                    ia.intakeservicerequestpersontypekey AS intakeservicerequestpersontypekey_decr
                FROM expunge.intakeservicerequestactor_expunge ia
                INNER JOIN expunge.actor_expunge a ON a.actorid = ia.actorid AND a.activeflag = 1
                WHERE ia.intakeserviceid = l_serviceid AND ia.activeflag = 1 
                UNION ALL
                -- Normal records 
                SELECT
                    ia.intakeservicerequestactorid,
                    ia.intakeserviceid,
                    ia.actorid,
                    ia.activeflag,
                    ia.updatedby,
                    a.personid AS personid_decr,
                    ia.intakeservicerequestpersontypekey AS intakeservicerequestpersontypekey_decr
                FROM intakeservicerequestactor ia
                INNER JOIN actor a ON a.actorid = ia.actorid AND a.activeflag = 1
                WHERE ia.intakeserviceid = l_serviceid AND ia.activeflag = 1
            )
            
            
            SELECT 
                p.personid,
                MAX(p.firstname || ' ' || p.lastname) personname,
                p.dateofdeath, p.dob,
                rs.description AS relationship, 
                MAX(isa.intakeservicerequestactorid :: character varying) intakeservicerequestactorid
            FROM intakeservicerequestactor_combined isa 
            INNER JOIN actortype act ON act.actortype = isa.intakeservicerequestpersontypekey_decr 
                AND act.activeflag = 1 
            INNER JOIN person p ON p.personid = isa.personid_decr 
                AND p.activeflag = 1 
            LEFT JOIN actorrelationship ar ON isa.intakeservicerequestactorid = ar.intakeservicerequestactorid AND ar.activeflag = 1
            LEFT JOIN relationshiptype rs ON rs.relationshiptypekey = ar.relationshiptypekey AND rs.activeflag = 1 
            WHERE isa.intakeserviceid = l_serviceid 
              AND isa.intakeservicerequestpersontypekey_decr = 'CHILD' 
              AND isa.activeflag = 1
              AND act.rolegroup = 'C' 
            GROUP BY p.personid, rs.description, p.dateofdeath, p.dob
        ) AS a;

    ELSE 

        SELECT json_agg(a) INTO l_investigation
        FROM (
            --------------------------------------------------------------------------
            --  EXPUNGED/NORMAL UNION & EXPUNGEMENT
            --------------------------------------------------------------------------
            WITH
            -- 1. intakeservicerequestactor_combined 
            intakeservicerequestactor_combined AS (
                SELECT
                    ia.intakeservicerequestactorid, ia.intakeserviceid, ia.actorid, ia.activeflag, ia.updatedby,
                    ia.personid AS personid_decr,
                    ia.intakeservicerequestpersontypekey AS intakeservicerequestpersontypekey_decr
                FROM expunge.intakeservicerequestactor_expunge ia
                INNER JOIN expunge.actor_expunge a ON a.actorid = ia.actorid AND a.activeflag = 1
                WHERE ia.intakeserviceid = l_serviceid AND ia.activeflag = 1
                UNION ALL
                SELECT
                    ia.intakeservicerequestactorid, ia.intakeserviceid, ia.actorid, ia.activeflag, ia.updatedby,
                    a.personid AS personid_decr,
                    ia.intakeservicerequestpersontypekey AS intakeservicerequestpersontypekey_decr
                FROM intakeservicerequestactor ia
                INNER JOIN actor a ON a.actorid = ia.actorid AND a.activeflag = 1
                WHERE ia.intakeserviceid = l_serviceid AND ia.activeflag = 1 
            ),

            -- 2. investigationallegation_combined 
            investigationallegation_combined AS (
                SELECT
                    ia.investigationallegationid, ia.maltreatmentid, ia.allegationid, ia.sextrafficking, ia.enddate,
                    ia.isapproximatedate, ia.timeofincidence, ia.isproviderinvolved, ia.outcome, ia.investigationallegationstatus,
                    ia.relationshiptypekey, ia.indicators, ia.incidentdate, ia.ischildfatality, ia.fatalitycomments, ia.expungementflag, ia.activeflag,
                    ia.updatedby,
                    ia.incidentlocationtypekey,
                    ia.name,
                    ia.comments,
                    ia.injurycomments
                FROM expunge.investigationallegation_expunge ia
                WHERE ia.investigationid = v_investigationid AND  ia.activeflag = 1
                UNION ALL
                SELECT
                    ia.investigationallegationid, ia.maltreatmentid, ia.allegationid, ia.sextrafficking, ia.enddate,
                    ia.isapproximatedate, ia.timeofincidence, ia.isproviderinvolved, ia.outcome, ia.investigationallegationstatus,
                    ia.relationshiptypekey, ia.indicators, ia.incidentdate, ia.ischildfatality, ia.fatalitycomments, ia.expungementflag, ia.activeflag,
                    ia.updatedby,
                    ia.incidentlocationtypekey::text AS incidentlocationtypekey,
                    ia.name::varchar(256) AS name,
                    ia.comments::text AS comments,
                    ia.injurycomments::text AS injurycomments
                FROM investigationallegation ia
                WHERE ia.investigationid = v_investigationid AND ia.activeflag = 1
            ),

            -- 3. investigationallegationmaltreators_combined
            investigationallegationmaltreators_combined AS (
                SELECT
                    iai.investigationallegationid, iai.intakeservicerequestactorid, iai.othermaltreator, iai.activeflag, iai.updatedby
                FROM expunge.investigationallegationmaltreators_expunge iai
                WHERE iai.activeflag = 1 
                UNION ALL
                SELECT
                    iai.investigationallegationid, iai.intakeservicerequestactorid, iai.othermaltreator, iai.activeflag, iai.updatedby
                FROM investigationallegationmaltreators iai
                WHERE iai.activeflag = 1
            )

            -- Start of UNION ALL Block
            SELECT 
                isra.actorid, ima.intakeservicerequestactorid, im.maltreatmentid, im.householdkey, im.providerid, 
                im.providername, im.providerphonenumber, im.isjurisdiction, im.countyid, p.personid, 
                im.incidentlocationtypekey, im.isnotapplicable, im.notapplicablecomments,
                CASE (im.isreported) WHEN 'true' THEN 'reported' ELSE 'identifer' end as isreported,
                COALESCE(p.firstname,'')||' ' ||COALESCE(p.lastname,'') AS personname, p.dateofdeath, p.dob,
                rs.description AS relationship,
                
                -- Roles Sub-query
                (SELECT json_agg(r)FROM (
                    SELECT mur.roletypekey AS role, mur.username 
                    FROM maltreatmentjurisdictionuser mur
                    WHERE mur.maltreatmentid = im.maltreatmentid AND mur.activeflag = 1
                )r) AS roles,
                
                -- Investigationallegation Sub-query
                (SELECT json_agg(a_ia) FROM (
                    SELECT 
                        ia.investigationallegationid, ia.maltreatmentid, ia.allegationid, ia.sextrafficking, ia.enddate,
                        ia.isapproximatedate, ia.timeofincidence, ia.incidentlocationtypekey, ia.name, ia.indicators, 
                        ia.comments, ia.injurycomments, ia.incidentdate, ia.sextrafficking, alle.name AS allegationname, 
                        ia.isproviderinvolved, ia.outcome, COALESCE(ia.ischildfatality ,null) ischildfatality, ia.fatalitycomments,
                        rv.description AS allegationstatusdesc, ia.investigationallegationstatus AS investigationalegationstatuskey, 
                        ia.relationshiptypekey, rst.description AS relationtypedesc,
                        
                        -- Audit Info Sub-query
                        ( SELECT json_agg(auditinfo) AS auditinfo
                        FROM 
                        ( 
                            select ps.oldproviderid, newproviderid, providerchange ,reasonchange , explainreason, explainreasonlist, u2.fullname as approvedby, u.fullname as requestedby, ps.updatedon
                            from improviderswitchinfo ps
                            left join userprofile u2 on u2.securityusersid = ps.insertedby
                            left join userprofile u on u.securityusersid = ps.updatedby
                            where ps.objectid = im.maltreatmentid 
                            order by ps.insertedby desc
                        ) auditinfo
                        ),
                        -- Maltreators Sub-query
                        (SELECT json_agg(ind) FROM (
                            SELECT iai.intakeservicerequestactorid,  
                                CASE COALESCE(iai.intakeservicerequestactorid :: character varying,'') WHEN '' THEN iai.othermaltreator 
                                    ELSE (pr.lastname ||', ' || pr.firstname ) 
                                END AS Personname, pr.personid,
                                
                                (SELECT RS.description  
                                FROM intakeservicerequestactor_combined ISR 
                                INNER JOIN actorrelationship AR  ON AR.intakeservicerequestactorid = ISR.intakeservicerequestactorid  AND AR.activeflag = 1  
                                INNER JOIN relationshiptype RS  ON RS.relationshiptypekey = AR.relationshiptypekey  AND RS.activeflag = 1  
                                WHERE ISR.intakeservicerequestactorid = iai.intakeservicerequestactorid  AND ISR.intakeserviceid = l_serviceid LIMIT 1) AS relationship  
                                
                            FROM investigationallegationmaltreators_combined iai 
                            LEFT JOIN intakeservicerequestactor_combined isra 
                                ON isra.intakeservicerequestactorid = iai.intakeservicerequestactorid AND (isra.activeflag = 1 OR isra.updatedby = 'EXPUNG') 
                            LEFT JOIN person pr ON pr.personid = isra.personid_decr AND pr.activeflag = 1 
                            WHERE iai.investigationallegationid = ia.investigationallegationid AND iai.activeflag = 1        
                        ) ind)::json AS maltreators,
                        
                        -- Other subqueries use combined IA table
                        (SELECT json_agg(inj) FROM (SELECT iaai.injurytypekey, it.typedescription FROM investigationallegationinjury IAAI JOIN injurytype it ON iaai.injurytypekey = it.injurytypekey AND it.activeflag = 1 WHERE iaai.investigationallegationid = ia.investigationallegationid AND iaai.activeflag = 1 ) inj)::json AS injurytype,       
                        (SELECT json_agg(characters) FROM(SELECT iamc.maltreatmentcharactersticstypekey ,mct.typedescription FROM investigationallegationcharacterstics iamc JOIN maltreatmentcharactersticstype mct ON iamc.maltreatmentcharactersticstypekey = mct.maltreatmentcharactersticstypekey AND mct.activeflag = 1 WHERE iamc.investigationallegationid = ia.investigationallegationid AND iamc.activeflag = 1 ) characters )::json AS maltreatmentcharactersticstypekey,
                        (SELECT json_agg(injchar) FROM(SELECT iaic.injurycharactersticstypekey, ict.typedescription FROM investigationallegationinjurycharacterstics IAIC JOIN injurycharactersticstype ict ON ict.injurycharactersticstypekey = iaic.injurycharactersticstypekey AND ict.activeflag = 1 WHERE iaic.investigationallegationid = ia.investigationallegationid AND iaic.activeflag = 1 ) injchar )::json AS injurycharactersticstype,
                        (SELECT json_agg(providermaltreatment) FROM(SELECT pmt.typedescription, pmt.providermaltreatmenttypekey FROM allegationprovidermaltreatment apm INNER JOIN providermaltreatmenttype pmt ON pmt.providermaltreatmenttypekey = apm.providermaltreatmenttypekey AND pmt.activeflag = 1 WHERE apm.investigationallegationid = ia.investigationallegationid AND apm.activeflag = 1 ) providermaltreatment )::json AS providermaltreatment,
                        
                        -- Indicators Sub-query
                        (SELECT json_agg(indicator) FROM(SELECT distinct(iai.indicatorid), ind.indicatorname FROM investigationallegation_combined IAA inner join investigationallegationindicator iai on IAA.investigationallegationid = iai.investigationallegationid INNER JOIN "indicator" ind ON iai.indicatorid = ind.indicatorid AND iai.activeflag = 1 WHERE IAA.maltreatmentid=im.maltreatmentid AND IAA.activeflag = 1 ) indicator )::json AS indicator,
                        
                        -- Expungement Sub-query
                        (SELECT json_agg(indicator) FROM(select * from expungement ex where ex.maltreatmentid = ia.maltreatmentid AND ex.activeflag = 1 ) indicator )::json AS expungement,
                            
                        ia.expungementflag, im.isnotapplicable, im.notapplicablecomments
                        
                    FROM investigationallegation_combined ia 
                    JOIN allegation alle ON alle.allegationid = ia.allegationid AND alle.activeflag = 1
                    LEFT JOIN referencevalues rv ON rv.ref_key=ia.investigationallegationstatus and rv.activeflag = 1
                    LEFT JOIN relationshiptype rst ON rst.relationshiptypekey = ia.relationshiptypekey and rst.activeflag = 1
                    WHERE ia.maltreatmentid = im.maltreatmentid AND (ia.activeflag = 1 OR ia.updatedby = 'EXPUNG') 
                ) a_ia)::json AS investigationallegation
                
            FROM Investigationmaltreatment im  
            LEFT JOIN investigationmaltreatmentactor ima ON ima.maltreatmentid = im.maltreatmentid AND ima.activeflag = 1 
            LEFT JOIN intakeservicerequestactor_combined isra ON isra.intakeservicerequestactorid = ima.intakeservicerequestactorid 
                AND (isra.activeflag = 1 OR isra.updatedby = 'EXPUNG') 
            LEFT JOIN actorrelationship ar ON isra.intakeservicerequestactorid = ar.intakeservicerequestactorid AND ar.activeflag = 1
            LEFT JOIN relationshiptype rs ON rs.relationshiptypekey = ar.relationshiptypekey AND rs.activeflag = 1 
            LEFT JOIN person p ON p.personid = isra.personid_decr 
            WHERE im.investigationid = v_investigationid AND im.activeflag = 1  
            
            UNION ALL
            
            -- UNION ALL (For children not associated with a maltreatment)
            SELECT 
                isa.actorid, isa.intakeservicerequestactorid,  
                NULL ::uuid AS maltreatmentid,
                NULL AS householdkey, NULL AS providerid, NULL AS providername, NULL AS providerphonenumber, NULL AS isjurisdiction,
                NULL AS countyid, P.personid, NULL AS incidentlocationtypekey, NULL AS isnotapplicable, NULL AS notapplicablecomments, NULL AS isreported,
                MAX(COALESCE(P.firstname,'')||' ' ||COALESCE(P.lastname,'')) AS personname,
                p.dateofdeath, p.dob,
                rs.description AS relationship,
                NULL :: json AS roles,
                NULL :: json AS investigationallegation
            FROM intakeservicerequestactor_combined isa 
            INNER JOIN actortype act ON act.actortype = isa.intakeservicerequestpersontypekey_decr  
                AND act.activeflag = 1 
            INNER JOIN person P ON P.personid = isa.personid_decr AND P.activeflag = 1 
            LEFT JOIN actorrelationship ar ON isa.intakeservicerequestactorid = ar.intakeservicerequestactorid AND ar.activeflag = 1
            LEFT JOIN relationshiptype rs  ON rs.relationshiptypekey = ar.relationshiptypekey AND rs.activeflag = 1 
            WHERE ISA.intakeserviceid = l_serviceid 
                AND (isa.activeflag = 1 OR isa.updatedby = 'EXPUNG')
                AND act.rolegroup = 'C' 
                AND isa.intakeservicerequestpersontypekey_decr = 'CHILD'  
                AND P.personid NOT IN (
                    SELECT insra.personid_decr 
                    FROM intakeservicerequestactor_combined insra 
                    INNER JOIN investigationmaltreatmentactor ima ON insra.intakeservicerequestactorid = ima.intakeservicerequestactorid 
                    INNER JOIN Investigationmaltreatment im ON IM.maltreatmentid = ima.maltreatmentid
                        AND IM.investigationid = v_investigationid
                        AND IM.activeflag = 1 
                ) 
            GROUP BY ISA.actorid, ISA.intakeservicerequestactorid, P.personid, rs.description, p.dateofdeath, p.dob
        ) AS a;

    END IF;

      END IF;  
          
RETURN  l_investigation;                
END;

$function$
;
