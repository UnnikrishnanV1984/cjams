DROP FUNCTION IF EXISTS cjams.getreviewdetails(character varying,character varying,integer,integer);
DROP FUNCTION IF EXISTS cjams.getreviewdetails(character varying,character varying,integer,integer,character varying);
CREATE OR REPLACE FUNCTION cjams.getreviewdetails(v_eventcode character varying, 
v_securityuserid character varying, 
pagno integer,
 pagesize integer,
 v_servicerequestnumber character varying DEFAULT NULL::character varying)
 RETURNS TABLE(totalcount bigint, intakeserviceid uuid, servicerequestnumber character varying, intakenumber character varying, intakeservreqtypekey character varying, classkey character varying, reporteddate timestamp without time zone, clientname character varying, asssignedon timestamp without time zone, assingeduser character varying, remarks text, typename character varying, appevent character varying, sdm json, legalguardian json, assessmentactors json, isChildConditionalSafe boolean)
 LANGUAGE plpgsql
AS $function$
------------------------------------------------------------------------------------------------------------
-- Revision(s)
-- 01/26/2024 Charan Sai-CIDM 8318- For the service case removed the activeflag= 1 condition when taking intakenumber from the intakeservicerequest and now  from servicecaseid.
-- 01/22/2025 Sandeep Kiarn Anugolu -CIDM 10097- Safe C assessment Safety user story to check conditinal safe condition.
-------------------------------------------------------------------------------------------------------------


DECLARE
_offset        integer;
Begin

_offset    :=    (pagno    -    1)    *    pagesize;  

IF  (v_eventcode  =  'ASST')  THEN

RETURN    query    

	
	SELECT   Count(1) over(),  
         a.intakeserviceid, 
         a.servicerequestnumber, 
         a.intakenumber, 
         a.intakeservreqtypekey, 
         a.classkey, 
         a.reporteddate, 
         a.clientname, 
         a.asssignedon, 
         a.assingeduser, 
         a.remarks, 
         a.typename, 
         a.appevent, 
         a.sdm,
         a.legalguardian,
         a.assessmentactors,
         a.isChildConditionalSafe
FROM     ( 
                    SELECT     
                               isr.intakeserviceid, 
                               (select getcasepersonname as legalguardian from getcasepersonname ('servicerequest',isr.intakeserviceid::character varying)),
                               cast( isr.servicerequestnumber 
                                          || 
                               CASE coalesce( isr.actiontype, '' ) 
                                          WHEN '' THEN '' 
                                          ELSE '    (' 
                                                                || coalesce( isr.actiontype, '' )
                                                                || ')' 
                               end AS CHARACTER VARYING ) AS servicerequestnumber, 
                               isr.intakenumber, 
                               ( 
                                      SELECT itsrt.intakeservreqtypekey 
                                      FROM   intakeservicerequesttype AS itsrt 
                                      WHERE  itsrt.intakeservreqtypeid = isr.intakeservreqtypeid
                                      AND    itsrt.activeflag = 1 
                                      LIMIT  1 ), 
                               ( 
                                      SELECT srst.classkey 
                                      FROM   servicerequestsubtype AS srst 
                                      WHERE  srst.servicerequestsubtypeid = isr.intakeservicerequestclassid
                                      AND    srst.activeflag = 1 
                                      LIMIT  1 ), isr.reporteddate :: timestamp
                                      , ' '::character varying clientname , a.updatedon :: timestamp AS asssignedon, 
                                      cast( up.lastname || ',    '  || up.firstname AS CHARACTER VARYING )    assingeduser,
                               coalesce( r.remarks, '' ) :: text                 AS remarks, 
                               (amt.titleheadertext ) ::CHARACTER VARYING        AS typename, 
                               'ASST' :: CHARACTER VARYING                       AS appevent, 
                               ( 
                                      SELECT json_agg(e) AS sdm 
                                      FROM   ( 
                                                    SELECT isrs.ischildfatality, 
                                                           isrs.ismaltreatment 
                                                    FROM   intakeservicerequestsdm isrs 
                                                    WHERE  isrs.intakenumber = isr.intakenumber
                                                    AND    isrs.activeflag =1 ) AS e) ::json,
                               ( 
                                      SELECT json_agg(e) AS assessmentactors 
                                      FROM   ( 
                                                    SELECT aa.assessmentid, isra1.intakeservicerequestactorid , isra1.actorid , isra1.personid 
                                                    FROM   assessmentactor aa
                                                    JOIN intakeservicerequestactor isra1 ON isra1.intakeservicerequestactorid = aa.intakeservicerequestactorid
                                                    WHERE  aa.assessmentid = a.assessmentid  
                                                    AND aa.activeflag =1 ) AS e) ::json,
                              (case when a.assessmenttemplateid = '0f01e16c-73db-42d8-ad84-04eeb5e26418' and (a.submissiondata->>'dangerInfluencesIdentified'='safetydecision2' or a.submissiondata->>'dangerInfluencesIdentified'='safetydecision3') then true else false end) as isChildConditionalSafe 
                    FROM       intakeservicerequest AS isr 
--                     JOIN 
--                                ( 
-- SELECT isra.intakeserviceid, isra.PERSONID personid,
-- 							(trim( pn.lastname ) || ', ' || trim( pn.firstname ))::CHARACTER VARYING clientname
-- 							FROM     intakeservicerequestactor AS isra
-- 							JOIN actor AS ar ON ar.actorid = isra.actorid 
-- 							JOIN person AS pn  ON pn.personid = ar.personid 
-- 							JOIN  
-- 							(
-- 								SELECT max(intakeservicerequestactorid::CHARACTER VARYING)::uuid reqactorid 
-- 								FROM intakeservicerequestactor  ira1
-- 								WHERE ira1.intakeservicerequestpersontypekey IN ('AV', 'RA', 'RC' ,'CLI' ,'CHILD','BIOCHILD','OTHERCHILD')
-- 								GROUP BY ira1.intakeserviceid
-- 							) as israd on isra.intakeservicerequestactorid = israd.reqactorid
-- 							WHERE isra.intakeservicerequestpersontypekey IN ('AV', 'RA' , 'RC' ,'CLI' ,'CHILD','BIOCHILD','OTHERCHILD')
-- 							GROUP BY isra.intakeserviceid, isra.PERSONID, clientname 
-- 							   ) isra 
--                     ON         isra.intakeserviceid = isr.intakeserviceid 
                    INNER JOIN assessment a 
                    ON         a.objectid = isr.intakeserviceid 
                    AND        a.activeflag = 1 AND lower(a.assessmentstatustypekey) = 'review'
                    INNER JOIN assessmenttemplate amt 
                    ON         a.assessmenttemplateid = amt.assessmenttemplateid 
                    AND        amt.activeflag = 1 
                    JOIN 
                               ( 
                                               SELECT DISTINCT objectid , 
                                                               cast( r.insertedon AS date ) assignedon,
                                                               r.remarks, 
                                                               r.fromsecurityusersid 
                                               FROM            routing r 
                                               WHERE           routingstatustypeid = 15 
                                               AND case when (v_servicerequestnumber IS NOT null and v_servicerequestnumber <> '') then r.servicerequestnumber = v_servicerequestnumber else true end 
                                               AND             r.eventcode = 'ASST' 
                                               AND             r.tosecurityusersid=v_securityuserid
                                               AND             r.activeflag = 1 and length(r.objectid)=36) r 
                    ON         r.objectid::uuid = a.ASSESSMENTID
                    
                    INNER JOIN userprofile up 
                    ON         up.securityusersid = r.fromsecurityusersid 
                    AND        up.activeflag = 1 
                    INNER JOIN intakeserreqstatustype irst 
                    ON         irst.intakeserreqstatustypeid = isr.intakeserreqstatustypeid 
                    AND        irst.activeflag = 1 
                    AND        lower( irst.intakeserreqstatustypekey ) NOT IN ( 'closed' ) 
                    Where isr.teamtypekey = 'CW'
                    UNION ALL
			SELECT
					S.servicecaseid
				  , (select getcasepersonname as legalguardian from getcasepersonname ('servicecase',S.servicecaseid::character varying))
				  , S.servicecasenumber
					 
				  --, ''
				  ,(select intakeservicerequest.intakenumber from intakeservicerequest where intakeservicerequest.servicecaseid=S.servicecaseid  limit 1)
				  ,    'Service Case'  
				  ,''
				  , S.startdate :: timestamp
				  , cast (caseheadname as character varying) clientname
				  , R.Assignedon :: timestamp
				  , cast(up.lastname
						||',    '
						||up.firstname as character varying) assingeduser
				  , coalesce(r.remarks,'') ::text
				   ,(amt.titleheadertext ) ::CHARACTER VARYING        AS typename
				  , r.eventcode :: character varying
				  , null ::json
                          ,( 
                                      SELECT json_agg(e) AS assessmentactors 
                                      FROM   ( 
                                                    SELECT aa.assessmentid, isra1.intakeservicerequestactorid , isra1.actorid , isra1.personid 
                                                    FROM   assessmentactor aa
                                                    JOIN intakeservicerequestactor isra1 ON isra1.intakeservicerequestactorid = aa.intakeservicerequestactorid
                                                    WHERE  aa.assessmentid = a.assessmentid  
                                                    AND aa.activeflag =1 ) AS e) ::json 
                        ,(case when a.assessmenttemplateid = '0f01e16c-73db-42d8-ad84-04eeb5e26418' and (a.submissiondata->>'dangerInfluencesIdentified'='safetydecision2' or a.submissiondata->>'dangerInfluencesIdentified'='safetydecision3') then true else false end) as isChildConditionalSafe
				  
			FROM servicecase S
			INNER JOIN assessment a 
                    ON         a.objectid = S.servicecaseid 
                    AND        a.activeflag = 1 AND lower(a.assessmentstatustypekey) = 'review'
            INNER JOIN assessmenttemplate amt 
                    ON         a.assessmenttemplateid = amt.assessmenttemplateid 
                    AND        amt.activeflag = 1 
			INNER JOIN 
				(
						SELECT    DISTINCT r.servicerequestnumber
						  , r.insertedon  assignedon
						  , r.remarks
						  , r.fromsecurityusersid
						  , r.eventcode
						  ,r.objectid
						  , COALESCE(rf.value_text,'Code description Not available')  eventdesc
						FROM
							ROUTING R 
						LEFT JOIN referencevalues rf ON rf.ref_key = r.eventcode AND rf.activeflag =1 AND rf.referencetypeid =46 
						WHERE
							R.tosecurityusersid = v_securityuserid
							AND routingstatustypeid in(15)
                                          AND case when (v_servicerequestnumber IS NOT null and v_servicerequestnumber <> '') then r.servicerequestnumber = v_servicerequestnumber else true end 
							AND R.activeflag =1
							AND R.eventcode  IN ('ASST') and length(r.objectid)=36
				)R ON r.objectid::uuid = a.assessmentid
				LEFT JOIN userprofile up on up.securityusersid = r.fromsecurityusersid  and up.activeflag  =1
				WHERE S.servicecasenumber LIKE '' ||'%' 
			 ) a  
ORDER BY asssignedon DESC 
LIMIT    pagesize 
offset   _offset;

ELSIF  (v_eventcode  =  'INVR')  THEN

        RETURN    query    

	SELECT   a.count, a.intakeserviceid, a.servicerequestnumber,a.intakenumber, a.intakeservreqtypekey, a.classkey, a.reporteddate, a.clientname, a.asssignedon, a.assingeduser, 
        a.remarks, a.typename, a.appevent,  a.sdm, 
        (select getcasepersonname as legalguardian from getcasepersonname ('servicerequest',a.intakeserviceid::character varying)), null::json, false as isChildConditionalSafe
        FROM (  SELECT Count(1) over(), 
                               isr.intakeserviceid, 
                               cast( isr.servicerequestnumber || CASE coalesce( isr.actiontype, '' ) WHEN '' THEN '' ELSE ' (' || coalesce( isr.actiontype, '' ) || ')' 
                               end AS CHARACTER VARYING ) AS servicerequestnumber, 
                               isr.intakenumber, 
                               ( 
			         SELECT itsrt.intakeservreqtypekey 
			         FROM intakeservicerequesttype AS itsrt 
			         WHERE  itsrt.intakeservreqtypeid = isr.intakeservreqtypeid
			         AND itsrt.activeflag = 1 
			         LIMIT  1 
			       ), 
                               ( 
			         SELECT srst.classkey 
			         FROM  servicerequestsubtype AS srst 
			         WHERE srst.servicerequestsubtypeid = isr.intakeservicerequestclassid
			         AND  srst.activeflag = 1 
			         LIMIT 1 
			        ),
                                isr.reporteddate :: timestamp, isra.clientname, --a.updatedon :: timestamp AS asssignedon,
                                null :: timestamp AS asssignedon,
                                cast( up.lastname || ',    ' || up.firstname AS CHARACTER VARYING )    assingeduser, coalesce( r.remarks, '' ) :: text AS remarks, 
                               --(amt.titleheadertext ) ::CHARACTER VARYING AS typename,
                               (select amt.titleheadertext::CHARACTER VARYING from assessment a
                               INNER JOIN assessmenttemplate amt ON a.assessmenttemplateid = amt.assessmenttemplateid AND amt.activeflag = 1 where
                               a.objectid = isr.intakeserviceid AND a.activeflag = 1 limit 1) as typename,
                               'INVR' :: CHARACTER VARYING AS appevent, 
                               ( SELECT json_agg(e) AS sdm FROM   (SELECT isrs.ischildfatality, isrs.ismaltreatment FROM  
                               intakeservicerequestsdm isrs WHERE  isrs.intakenumber = isr.intakenumber AND    isrs.activeflag =1 ) AS e) ::json 
                               
                               FROM intakeservicerequest AS isr 
                                    JOIN ( SELECT   isra.intakeserviceid, ( max( isra.PERSONID::CHARACTER VARYING ))::uuid personid,
                               cast(( trim( pn.lastname ) || ',    ' || trim( pn.firstname )) AS CHARACTER VARYING ) clientname
			       FROM  intakeservicerequestactor  AS isra
			             JOIN actor AS ar ON ar.actorid = isra.actorid 
			             JOIN person AS pn  ON  pn.personid = ar.personid WHERE isra.intakeservicerequestpersontypekey IN ( 'RA','RC','CLI','Youth' )
			       GROUP BY isra.intakeserviceid, clientname ) isra ON  isra.intakeserviceid = isr.intakeserviceid and isr.teamtypekey = 'CW' 
			             --LEFT JOIN assessment a ON a.objectid = isr.intakeserviceid AND a.activeflag = 1 
			             --LEFT JOIN assessmenttemplate amt ON a.assessmenttemplateid = amt.assessmenttemplateid AND amt.activeflag = 1 
			             JOIN(SELECT DISTINCT objectid ,cast( r.insertedon AS date ) assignedon,r.remarks, r.fromsecurityusersid FROM  routing r 
			       WHERE  routingstatustypeid in(12,13) --AND  r.eventcode = v_eventcode 
			       AND r.tosecurityusersid=v_securityuserid AND r.activeflag = 1 ) r 
			      --ON         r.objectid = a.ASSESSMENTID::CHARACTER VARYING 
			       ON  r.objectid = isr.intakeserviceid::CHARACTER VARYING 
			             INNER JOIN userprofile up ON up.securityusersid = r.fromsecurityusersid AND up.activeflag = 1 
			             INNER JOIN intakeserreqstatustype irst ON irst.intakeserreqstatustypeid = isr.intakeserreqstatustypeid AND irst.activeflag = 1 
			       AND lower( irst.intakeserreqstatustypekey ) NOT IN ( 'closed' ) 
                    ) a  
ORDER BY asssignedon DESC 
LIMIT    pagesize 
offset   _offset;

ELSIF  (v_eventcode  =  'INVRCSR')  THEN

        RETURN    query    

	SELECT   a.count, a.intakeserviceid, a.servicerequestnumber,a.intakenumber, a.intakeservreqtypekey, a.classkey, a.reporteddate, a.clientname, a.asssignedon, a.assingeduser, 
        a.remarks, a.typename, a.appevent,  a.sdm ,
          (select getcasepersonname as legalguardian from getcasepersonname ('servicerequest',a.intakeserviceid::character varying)), null::json, false as isChildConditionalSafe
        FROM (  SELECT Count(1) over(), 
                               isr.intakeserviceid, 
                               cast( isr.servicerequestnumber || CASE coalesce( isr.actiontype, '' ) WHEN '' THEN '' ELSE ' (' || coalesce( isr.actiontype, '' ) || ')' 
                               end AS CHARACTER VARYING ) AS servicerequestnumber, 
                               isr.intakenumber, 
                               ( 
			         SELECT itsrt.intakeservreqtypekey 
			         FROM intakeservicerequesttype AS itsrt 
			         WHERE  itsrt.intakeservreqtypeid = isr.intakeservreqtypeid
			         AND itsrt.activeflag = 1 
			         LIMIT  1 
			       ), 
                               ( 
			         SELECT srst.classkey 
			         FROM  servicerequestsubtype AS srst 
			         WHERE srst.servicerequestsubtypeid = isr.intakeservicerequestclassid
			         AND  srst.activeflag = 1 
			         LIMIT 1 
			        ),
                                isr.reporteddate :: timestamp, isra.clientname, --a.updatedon :: timestamp AS asssignedon,
                                null :: timestamp AS asssignedon,
                                cast( up.lastname || ',    ' || up.firstname AS CHARACTER VARYING )    assingeduser, coalesce( r.remarks, '' ) :: text AS remarks, 
                               --(amt.titleheadertext ) ::CHARACTER VARYING AS typename,
                               (select amt.titleheadertext::CHARACTER VARYING from assessment a
                               INNER JOIN assessmenttemplate amt ON a.assessmenttemplateid = amt.assessmenttemplateid AND amt.activeflag = 1 where
                               a.objectid = isr.intakeserviceid AND a.activeflag = 1 limit 1) as typename,
                               'INVRCSR' :: CHARACTER VARYING AS appevent, 
                               ( SELECT json_agg(e) AS sdm FROM   (SELECT isrs.ischildfatality, isrs.ismaltreatment FROM  
                               intakeservicerequestsdm isrs WHERE  isrs.intakenumber = isr.intakenumber AND    isrs.activeflag =1 ) AS e) ::json 
                               
                               FROM intakeservicerequest AS isr 
                                    JOIN ( SELECT   isra.intakeserviceid, ( max( isra.PERSONID::CHARACTER VARYING ))::uuid personid,
                               cast(( trim( pn.lastname ) || ',    ' || trim( pn.firstname )) AS CHARACTER VARYING ) clientname
			       FROM  intakeservicerequestactor  AS isra
			             JOIN actor AS ar ON ar.actorid = isra.actorid 
			             JOIN person AS pn  ON  pn.personid = ar.personid WHERE isra.intakeservicerequestpersontypekey IN ( 'RA','RC','CLI','Youth' )
			       GROUP BY isra.intakeserviceid, clientname ) isra ON  isra.intakeserviceid = isr.intakeserviceid and isr.teamtypekey = 'CW'
			             --LEFT JOIN assessment a ON a.objectid = isr.intakeserviceid AND a.activeflag = 1 
			             --LEFT JOIN assessmenttemplate amt ON a.assessmenttemplateid = amt.assessmenttemplateid AND amt.activeflag = 1 
			             JOIN(SELECT DISTINCT objectid ,cast( r.insertedon AS date ) assignedon,r.remarks, r.fromsecurityusersid FROM  routing r 
			       WHERE  routingstatustypeid = 22 AND  r.eventcode = v_eventcode AND r.tosecurityusersid=v_securityuserid AND r.activeflag = 1 ) r 
			      --ON         r.objectid = a.ASSESSMENTID::CHARACTER VARYING 
			       ON  r.objectid = isr.intakeserviceid::CHARACTER VARYING 
			             INNER JOIN userprofile up ON up.securityusersid = r.fromsecurityusersid AND up.activeflag = 1 
			             INNER JOIN intakeserreqstatustype irst ON irst.intakeserreqstatustypeid = isr.intakeserreqstatustypeid AND irst.activeflag = 1 
			       AND lower( irst.intakeserreqstatustypekey ) NOT IN ( 'closed' ) 
                    ) a  
ORDER BY asssignedon DESC 
LIMIT    pagesize 
offset   _offset;

END IF;      

End;


$function$
;


