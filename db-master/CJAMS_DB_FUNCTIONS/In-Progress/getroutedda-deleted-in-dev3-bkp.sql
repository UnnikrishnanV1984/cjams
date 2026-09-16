-- ----------------------------------------------------------------
--  FUNCTION getroutedda
-- ----------------------------------------------------------------

CREATE OR REPLACE FUNCTION cjams.getroutedda (
   IN userid         CHARACTER VARYING,
   IN isassigned     BOOLEAN,
   IN pagenumber     BIGINT,
   IN pagesize       BIGINT,
   IN servicereqno   CHARACTER VARYING,
   IN sortcolumn     CHARACTER VARYING,
   IN sortorder      CHARACTER VARYING,
   IN assignedid     CHARACTER VARYING DEFAULT NULL::CHARACTER VARYING)
   RETURNS TABLE
           (
              totalcount                    BIGINT,
              offencecounty                 json,
              casecondtions                 json,
              assistid                      CHARACTER VARYING,
              cjamspid                      BIGINT,
              servicereqid                  uuid,
              servicerequestnumber          CHARACTER VARYING,
              cpsresponse                   CHARACTER VARYING,
              servreqtype                   CHARACTER VARYING,
              servreqsubtype                CHARACTER VARYING,
              reporteddate                  TIMESTAMP WITHOUT TIME ZONE,
              raname                        CHARACTER VARYING,
              servreqstatus                 CHARACTER VARYING,
              routedon                      TIMESTAMP WITHOUT TIME ZONE,
              assignedto                    CHARACTER VARYING,
              assigned                      BOOLEAN,
              assigneddate                  TIMESTAMP WITHOUT TIME ZONE,
              isgroup                       BOOLEAN,
              incidentlocation              CHARACTER VARYING,
              acceptdate                    TIMESTAMP WITHOUT TIME ZONE,
              intakenumber                  CHARACTER VARYING,
              dadetails                     json,
              sdm                           json,
              placementfostercareapprove    CHARACTER VARYING,
              servicelogapprovestatus       CHARACTER VARYING,
              legalguardian                 json
           )
   LANGUAGE 'plpgsql'
   VOLATILE
   NOT LEAKPROOF
   SECURITY INVOKER
   PARALLEL UNSAFE
   ROWS 1000
AS
$$


/* Two parameter added sortcolumn and sortorder */



DECLARE
   v_pageoffset   INT;

   v_pagenumber   INT;
BEGIN
   v_pagenumber := pagenumber - 1;

   v_pageoffset = v_pagenumber * pagesize;



   IF (isassigned = FALSE)
   THEN
      RETURN QUERY
           SELECT count (1) OVER (),
                  *,
                  (SELECT getcasepersonname
                   FROM getcasepersonname ('servicerequest',
                                           intakeserviceid::CHARACTER VARYING))
             FROM (SELECT (SELECT json_agg (x)
                           FROM (SELECT C.countyname, C.countyid
                                   FROM intakeservicerequestevaluation INE
                                        JOIN county C
                                           ON C.countyid = INE.countyid
                                  WHERE     INE.activeflag = 1
                                        AND INE.intakenumber = ISR.intakenumber
                                  LIMIT 1) AS x)
                             AS offencecounty,
                          (SELECT json_agg (x)
                           FROM (SELECT SCP.description
                                           AS casesourcendisposition,
                                        (CASE
                                            WHEN dispositioncode = 'FPTSAO'
                                            THEN
                                               'Court'
                                            ELSE
                                               'intake'
                                         END)
                                           AS casesource,
                                        (CASE
                                            WHEN dispositioncode = 'FPTSAO'
                                            THEN
                                               (SELECT (SELECT json_agg (x)
                                                        FROM (SELECT DISTINCT
                                                                     x.courtordertypekey,
                                                                     x.description
                                                                FROM (SELECT cott.courtordertypekey,
                                                                             cott.description,
                                                                             cott.courtordertypeid
                                                                        FROM intakeservicerequestcourtordertypeconfig
                                                                             cotc
                                                                             JOIN
                                                                             courtordertype
                                                                             cott
                                                                                ON cott.courtordertypekey =
                                                                                   cotc.courtordertypekey
                                                                             JOIN
                                                                             intakeservicerequestcourtaction
                                                                             CA
                                                                                ON     cotc.intakeservicerequestcourtactionid =
                                                                                       CA.intakeservicerequestcourtactionid
                                                                                   AND CA.activeflag =
                                                                                       1
                                                                       WHERE CA.intakenumber =
                                                                             ISR.intakenumber
                                                                      UNION
                                                                      SELECT cott.courtordertypekey,
                                                                             cott.description,
                                                                             cott.courtordertypeid
                                                                        FROM intakeservicerequestcourtordertypeconfig
                                                                             cotc
                                                                             JOIN
                                                                             courtordertype
                                                                             cott
                                                                                ON cott.courtordertypekey =
                                                                                   cotc.courtordertypekey
                                                                             JOIN
                                                                             intakeservicerequestcourtaction
                                                                             CA
                                                                                ON     cotc.intakeservicerequestcourtactionid =
                                                                                       CA.intakeservicerequestcourtactionid
                                                                                   AND CA.activeflag =
                                                                                       1
                                                                             JOIN
                                                                             courtactionallegationconfig
                                                                             CAC
                                                                                ON     CAC.intakeservicerequestcourtactionid =
                                                                                       CA.intakeservicerequestcourtactionid
                                                                                   AND CAC.activeflag =
                                                                                       1
                                                                       WHERE CA.intakenumber =
                                                                             ISR.intakenumber)
                                                                     AS x) AS x))
                                         END)
                                           AS casecondtioncourtorders
                                   FROM servicerequesttypeconfigdispositioncode
                                        SCP
                                        JOIN
                                        intakeservicerequestdispositioncode
                                        ISRD
                                           ON     ISRD.servicerequesttypeconfigiddispostionid =
                                                  SCP.servicerequesttypeconfigiddispostionid
                                              AND ISRD.activeflag = 1
                                  WHERE ISRD.intakeserviceid =
                                        ISR.intakeserviceid) AS x)
                             AS caseconditions,
                          PN.old_id
                             AS assistid,
                          PN.cjamspid,
                          ISR.intakeserviceid,
                          cast (
                                ISR.servicerequestnumber
                             || CASE coalesce (isr.actiontype, '')
                                   WHEN ''
                                   THEN
                                      ''
                                   ELSE
                                         '  ('
                                      || coalesce (isr.actiontype, '')
                                      || ')'
                                END AS CHARACTER VARYING)
                             AS servicerequestnumber,
                          cast (
                             CASE ISR.iscps
                                WHEN TRUE THEN 'CPS'
                                WHEN FALSE THEN 'Non  CPS'
                                ELSE ''
                             END AS CHARACTER VARYING),
                          (SELECT itsrt.intakeservreqtypekey
                            FROM intakeservicerequesttype AS itsrt
                           WHERE     itsrt.intakeservreqtypeid =
                                     ISR.intakeservreqtypeid
                                 AND itsrt.activeflag = 1
                           LIMIT 1),
                          (SELECT srst.classkey
                            FROM servicerequestsubtype AS srst
                           WHERE     srst.servicerequestsubtypeid =
                                     ISR.intakeservicerequestclassid
                                 AND srst.activeflag = 1
                           LIMIT 1),
                          ISR.reporteddate
                             AS reporteddate,
                          (SELECT getreportername
                           FROM getreportername (
                                   'servicerequest',
                                   ISR.intakeserviceid::CHARACTER VARYING,
                                   'reporter'))
                             AS clientname,
                          intakeserreqstatustypekey,
                          ISR.routedon
                             AS routeddate,
                          cast (
                             up.lastname || ',  ' || up.firstname
                                AS CHARACTER VARYING)
                             assingeduser,
                          ISR.isrouted,
                          R.Assignedon
                             AS assigneddate,
                          FALSE,
                          cast (
                             coalesce (isr.offenselocation, '')
                                AS CHARACTER VARYING),
                          NULL::TIMESTAMP WITHOUT TIME ZONE,
                          ISR.intakenumber
                             AS intakenumber,
                          NULL::json,
                          (SELECT json_agg (e) AS fatality
                             FROM (SELECT isrs.ischildfatality,
                                          isrs.ismaltreatment
                                     FROM intakeservicerequestsdm isrs
                                    WHERE     isrs.intakenumber =
                                              ISR.IntakeNumber
                                          AND activeflag = 1) AS e)::json,
                          NULL::CHARACTER VARYING
                             AS placementfostercareapprove,
                          NULL::CHARACTER VARYING
                             AS serviceapprovestatus
                     FROM intakeservicerequest AS ISR
                          INNER JOIN
                          (  SELECT ISRA.intakeserviceid,
                                    (max (AR.personid::CHARACTER VARYING))::uuid personid
                               FROM intakeservicerequestactor AS ISRA
                                    INNER JOIN actor AS AR
                                       ON AR.actorid = ISRA.actorid
                              WHERE ISRA.intakeservicerequestpersontypekey IN
                                       ('RA',
                                        'CHILD',
                                        'BIOCHILD',
                                        'NVC',
                                        'OTHERCHILD',
                                        'PAC',
                                        'RC',
                                        'CLI',
                                        'Youth',
                                        '2085',
                                        'PA')
                           GROUP BY ISRA.intakeserviceid) ISRA
                             ON ISRA.intakeserviceid = ISR.intakeserviceid
                          INNER JOIN person AS PN
                             ON PN.personid = ISRA.personid
                          INNER JOIN
                          (SELECT DISTINCT
                                  objectid,
                                  cast (r.insertedon AS TIMESTAMP) assignedon
                             FROM ROUTING R
                            WHERE     R.tosecurityusersid = userid
                                  AND routingstatustypeid IN (2, 76)
                                  AND R.activeflag = 1) R
                             ON r.objectid = ISR.intakenumber
                          LEFT JOIN userprofile up
                             ON     up.securityusersid = ISR.routedusersid
                                AND up.activeflag = 1
                          INNER JOIN intakeserreqstatustype irst
                             ON     irst.intakeserreqstatustypeid =
                                    ISR.intakeserreqstatustypeid
                                AND irst.activeflag = 1
                                AND lower (irst.Intakeserreqstatustypekey) NOT IN
                                       ('closed', 'rejected')
                          INNER JOIN intakedastatus AS IDAS
                             ON     IDAS.intakenumber = ISR.intakenumber
                                AND IDAS.activeflag = 1 --and    (IDAS.clwstatus  is  null  or  IDAS.clwstatus  in(4,6))
                    WHERE     ISR.servicerequestnumber LIKE servicereqno || '%'
                          AND coalesce (ISR.isrouted, FALSE) = isassigned
                          AND ISR.activeflag = 1
                          AND ISR.intakeserviceid NOT IN
                                 (SELECT IG.intakeserviceid
                                    FROM IntakeServiceRequestGroupDetails IG
                                   WHERE IG.activeflag = 1)
                          AND (   coalesce (IDAS.isclw, FALSE) = FALSE
                               OR (    IDAS.isclw = TRUE
                                   AND ISR.intakeserviceid NOT IN
                                          (SELECT IG.intakeserviceid
                                            FROM IntakeServiceRequestGroupDetails
                                                 IG
                                           WHERE IG.activeflag = 1)
                                   AND ISR.intakenumber NOT IN
                                          (SELECT DISTINCT ISRE.intakenumber
                                             FROM intakeservicerequestevaluation
                                                  AS ISRE
                                                  JOIN
                                                  complaintstatustype AS CST
                                                     ON     CST.complaintstatustypekey =
                                                            ISRE.complaintstatustypekey
                                                        AND CST.activeflag = 1
                                            WHERE     CST.complaintstatustypekey NOT IN
                                                         ('CHC', 'CAS', 'RCAS')
                                                  AND ISRE.activeflag = 1)))
                   UNION ALL
                   SELECT (SELECT json_agg (x)
                           FROM (SELECT C.countyname, C.countyid
                                   FROM intakeservicerequestevaluation INE
                                        JOIN county C
                                           ON C.countyid = INE.countyid
                                  WHERE     INE.activeflag = 1
                                        AND INE.intakenumber = ISR.intakenumber
                                  LIMIT 1) AS x)
                             AS offencecounty,
                          (SELECT json_agg (x)
                           FROM (SELECT SCP.description
                                           AS casesourcendisposition,
                                        (CASE
                                            WHEN dispositioncode = 'FPTSAO'
                                            THEN
                                               'Court'
                                            ELSE
                                               'intake'
                                         END)
                                           AS casesource,
                                        (CASE
                                            WHEN dispositioncode = 'FPTSAO'
                                            THEN
                                               (SELECT (SELECT json_agg (x)
                                                        FROM (SELECT DISTINCT
                                                                     x.courtordertypekey,
                                                                     x.description
                                                                FROM (SELECT cott.courtordertypekey,
                                                                             cott.description,
                                                                             cott.courtordertypeid
                                                                        FROM intakeservicerequestcourtordertypeconfig
                                                                             cotc
                                                                             JOIN
                                                                             courtordertype
                                                                             cott
                                                                                ON cott.courtordertypekey =
                                                                                   cotc.courtordertypekey
                                                                             JOIN
                                                                             intakeservicerequestcourtaction
                                                                             CA
                                                                                ON     cotc.intakeservicerequestcourtactionid =
                                                                                       CA.intakeservicerequestcourtactionid
                                                                                   AND CA.activeflag =
                                                                                       1
                                                                       WHERE CA.intakenumber =
                                                                             ISR.intakenumber
                                                                      UNION
                                                                      SELECT cott.courtordertypekey,
                                                                             cott.description,
                                                                             cott.courtordertypeid
                                                                        FROM intakeservicerequestcourtordertypeconfig
                                                                             cotc
                                                                             JOIN
                                                                             courtordertype
                                                                             cott
                                                                                ON cott.courtordertypekey =
                                                                                   cotc.courtordertypekey
                                                                             JOIN
                                                                             intakeservicerequestcourtaction
                                                                             CA
                                                                                ON     cotc.intakeservicerequestcourtactionid =
                                                                                       CA.intakeservicerequestcourtactionid
                                                                                   AND CA.activeflag =
                                                                                       1
                                                                             JOIN
                                                                             courtactionallegationconfig
                                                                             CAC
                                                                                ON     CAC.intakeservicerequestcourtactionid =
                                                                                       CA.intakeservicerequestcourtactionid
                                                                                   AND CAC.activeflag =
                                                                                       1
                                                                       WHERE CA.intakenumber =
                                                                             ISR.intakenumber)
                                                                     AS x) AS x))
                                         END)
                                           AS casecondtioncourtorders
                                   FROM servicerequesttypeconfigdispositioncode
                                        SCP
                                        JOIN
                                        intakeservicerequestdispositioncode
                                        ISRD
                                           ON     ISRD.servicerequesttypeconfigiddispostionid =
                                                  SCP.servicerequesttypeconfigiddispostionid
                                              AND ISRD.activeflag = 1
                                  WHERE ISRD.intakeserviceid =
                                        ISR.intakeserviceid) AS x)
                             AS caseconditions,
                          PN.old_id
                             AS assistid,
                          PN.cjamspid,
                          ISR.intakeserviceid,
                          cast (
                                ISR.servicerequestnumber
                             || CASE coalesce (isr.actiontype, '')
                                   WHEN ''
                                   THEN
                                      ''
                                   ELSE
                                         '  ('
                                      || coalesce (isr.actiontype, '')
                                      || ')'
                                END AS CHARACTER VARYING)
                             AS servicerequestnumber,
                          cast (
                             CASE ISR.iscps
                                WHEN TRUE THEN 'CPS'
                                WHEN FALSE THEN 'Non  CPS'
                                ELSE ''
                             END AS CHARACTER VARYING),
                          (SELECT itsrt.intakeservreqtypekey
                            FROM intakeservicerequesttype AS itsrt
                           WHERE     itsrt.intakeservreqtypeid =
                                     ISR.intakeservreqtypeid
                                 AND itsrt.activeflag = 1
                           LIMIT 1),
                          (SELECT srst.classkey
                            FROM servicerequestsubtype AS srst
                           WHERE     srst.servicerequestsubtypeid =
                                     ISR.intakeservicerequestclassid
                                 AND srst.activeflag = 1
                           LIMIT 1),
                          ISR.reporteddate
                             AS reporteddate,
                          (SELECT getreportername
                           FROM getreportername (
                                   'servicerequest',
                                   ISR.intakeserviceid::CHARACTER VARYING,
                                   'reporter'))
                             AS clientname,
                          intakeserreqstatustypekey,
                          ISR.routedon
                             AS routeddate,
                          cast (
                             up.lastname || ',  ' || up.firstname
                                AS CHARACTER VARYING),
                          ISR.isrouted,
                          R.assignedon
                             AS assigneddate,
                          FALSE,
                          cast (
                             coalesce (isr.offenselocation, '')
                                AS CHARACTER VARYING),
                          NULL::TIMESTAMP WITHOUT TIME ZONE,
                          ISR.intakenumber
                             AS intakenumber,
                          NULL::json,
                          (SELECT json_agg (e) AS fatality
                             FROM (SELECT isrs.ischildfatality,
                                          isrs.ismaltreatment
                                     FROM intakeservicerequestsdm isrs
                                    WHERE     isrs.intakenumber =
                                              ISR.IntakeNumber
                                          AND activeflag = 1) AS e)::json,
                          NULL::CHARACTER VARYING
                             AS placementfostercareapprove,
                          NULL::CHARACTER VARYING
                             AS serviceapprovestatus
                     FROM intakeservicerequest AS ISR
                          INNER JOIN
                          (  SELECT ISRA.intakeserviceid,
                                    (max (AR.personid::CHARACTER VARYING))::uuid personid
                               FROM intakeservicerequestactor AS ISRA
                                    INNER JOIN actor AS AR
                                       ON AR.actorid = ISRA.actorid
                              WHERE ISRA.intakeservicerequestpersontypekey IN
                                       ('RA',
                                        'CHILD',
                                        'BIOCHILD',
                                        'NVC',
                                        'OTHERCHILD',
                                        'PAC',
                                        'RC',
                                        'CLI',
                                        'Youth',
                                        '2085',
                                        'PA')
                           GROUP BY ISRA.intakeserviceid) ISRA
                             ON ISRA.intakeserviceid = ISR.intakeserviceid
                          INNER JOIN person AS PN
                             ON PN.personid = ISRA.personid
                          INNER JOIN
                          (SELECT DISTINCT
                                  objectid,
                                  tosecurityusersid,
                                  cast (r.insertedon AS TIMESTAMP) assignedon
                             FROM ROUTING R
                            WHERE     R.tosecurityusersid = userid
                                  AND routingstatustypeid = 9
                                  AND R.activeflag = 1) R
                             ON r.objectid =
                                cast (ISR.intakeserviceid AS CHARACTER VARYING)
                          LEFT JOIN userprofile up
                             ON     up.securityusersid = R.tosecurityusersid
                                AND up.activeflag = 1
                          INNER JOIN intakeserreqstatustype irst
                             ON     irst.intakeserreqstatustypeid =
                                    ISR.intakeserreqstatustypeid
                                AND irst.activeflag = 1
                                AND lower (irst.Intakeserreqstatustypekey) NOT IN
                                       ('closed', 'rejected')
                          INNER JOIN intakedastatus AS IDAS
                             ON     IDAS.intakenumber = ISR.intakenumber
                                AND IDAS.activeflag = 1 --and    (IDAS.clwstatus  is  null  or  IDAS.clwstatus  in(4,6))
                    WHERE     ISR.servicerequestnumber LIKE servicereqno || '%'
                          AND coalesce (ISR.isrouted, FALSE) = isassigned
                          AND ISR.activeflag = 1
                          AND ISR.intakeserviceid NOT IN
                                 (SELECT IG.intakeserviceid
                                    FROM IntakeServiceRequestGroupDetails IG
                                   WHERE IG.activeflag = 1)
                          AND (   coalesce (IDAS.isclw, FALSE) = FALSE
                               OR (    IDAS.isclw = TRUE
                                   AND ISR.intakeserviceid NOT IN
                                          (SELECT IG.intakeserviceid
                                            FROM IntakeServiceRequestGroupDetails
                                                 IG
                                           WHERE IG.activeflag = 1)
                                   AND ISR.intakenumber NOT IN
                                          (SELECT DISTINCT ISRE.intakenumber
                                             FROM intakeservicerequestevaluation
                                                  AS ISRE
                                                  JOIN
                                                  complaintstatustype AS CST
                                                     ON     CST.complaintstatustypekey =
                                                            ISRE.complaintstatustypekey
                                                        AND CST.activeflag = 1
                                            WHERE     CST.complaintstatustypekey NOT IN
                                                         ('CHC', 'CAS', 'RCAS')
                                                  AND ISRE.activeflag = 1)))
                   UNION ALL
                     SELECT NULL,
                            NULL,
                            NULL,
                            NULL,
                            ISG.groupid,
                            ISG.GROUPNUMBER,
                            '',
                            '',
                            '',
                            NULL,
                            '',
                            'Approved',
                            NULL,
                            NULL,
                            FALSE,
                            NULL,
                            TRUE,
                            '',
                            NULL::TIMESTAMP WITHOUT TIME ZONE,
                            ISR.intakenumber
                               AS intakenumber,
                            (SELECT *
                               FROM getgroupcase (userid, FALSE, ISG.groupid))
                               AS casea,
                            (SELECT json_agg (e) AS fatality
                               FROM (SELECT isrs.ischildfatality,
                                            isrs.ismaltreatment
                                       FROM intakeservicerequestsdm isrs
                                      WHERE     isrs.intakenumber =
                                                ISR.IntakeNumber
                                            AND activeflag = 1) AS e)::json,
                            NULL::CHARACTER VARYING
                               AS placementfostercareapprove,
                            NULL::CHARACTER VARYING
                               AS serviceapprovestatus
                       FROM IntakeServiceRequestGroup ISG
                            INNER JOIN IntakeServiceRequestGroupDetails ISGD
                               ON     ISGD.groupid = ISG.groupid
                                  AND ISGD.activeflag = 1
                            INNER JOIN intakeservicerequest AS ISR
                               ON ISR.intakeserviceid = ISGD.intakeserviceid
                            LEFT JOIN
                            (SELECT DISTINCT
                                    objectid,
                                    cast (r.insertedon AS TIMESTAMP) assignedon
                               FROM ROUTING R
                              WHERE     R.tosecurityusersid = userid
                                    AND routingstatustypeid IN (2, 76)
                                    AND R.activeflag = 1) R
                               ON r.objectid = ISR.intakenumber
                            INNER JOIN intakeserreqstatustype irst
                               ON     irst.intakeserreqstatustypeid =
                                      ISR.intakeserreqstatustypeid
                                  AND irst.activeflag = 1
                                  AND lower (irst.Intakeserreqstatustypekey) NOT IN
                                         ('closed', 'rejected')
                            INNER JOIN intakedastatus AS IDAS
                               ON     IDAS.intakenumber = ISR.intakenumber
                                  AND IDAS.activeflag = 1 --and    (IDAS.clwstatus  is  null  or  IDAS.clwstatus  in(4,6))
                      WHERE     ISG.GROUPNUMBER LIKE servicereqno || '%'
                            AND coalesce (ISR.isrouted, FALSE) = FALSE
                   GROUP BY ISG.groupid, ISG.GROUPNUMBER, ISR.intakenumber
                   UNION ALL
                     SELECT NULL,
                            NULL,
                            NULL,
                            NULL,
                            ISG.groupid,
                            ISG.GROUPNUMBER,
                            '',
                            '',
                            '',
                            NULL,
                            '',
                            'Approved',
                            NULL,
                            NULL,
                            FALSE,
                            NULL,
                            TRUE,
                            '',
                            NULL,
                            ISR.intakenumber
                               AS intakenumber,
                            (SELECT *
                               FROM getgroupcase (userid, FALSE, ISG.groupid))
                               AS casea,
                            (SELECT json_agg (e) AS fatality
                               FROM (SELECT isrs.ischildfatality,
                                            isrs.ismaltreatment
                                       FROM intakeservicerequestsdm isrs
                                      WHERE     isrs.intakenumber =
                                                ISR.IntakeNumber
                                            AND activeflag = 1) AS e)::json,
                            NULL::CHARACTER VARYING
                               AS placementfostercareapprove,
                            NULL::CHARACTER VARYING
                               AS serviceapprovestatus
                       FROM IntakeServiceRequestGroup ISG
                            INNER JOIN IntakeServiceRequestGroupDetails ISGD
                               ON     ISGD.groupid = ISG.groupid
                                  AND ISGD.activeflag = 1
                            INNER JOIN intakeservicerequest AS ISR
                               ON     ISR.intakeserviceid = ISGD.intakeserviceid
                                  AND ISR.activeflag = 1
                            INNER JOIN
                            (SELECT DISTINCT
                                    objectid,
                                    tosecurityusersid,
                                    cast (r.insertedon AS TIMESTAMP) assignedon
                               FROM ROUTING R
                              WHERE     R.tosecurityusersid = userid
                                    AND routingstatustypeid = 9
                                    AND R.activeflag = 1) R
                               ON r.objectid =
                                  cast (ISR.intakeserviceid AS CHARACTER VARYING)
                            INNER JOIN intakeserreqstatustype irst
                               ON     irst.intakeserreqstatustypeid =
                                      ISR.intakeserreqstatustypeid
                                  AND irst.activeflag = 1
                                  AND lower (irst.Intakeserreqstatustypekey) NOT IN
                                         ('closed', 'rejected')
                            INNER JOIN intakedastatus AS IDAS
                               ON     IDAS.intakenumber = ISR.intakenumber
                                  AND IDAS.activeflag = 1
                                  AND (   IDAS.clwstatus IS NULL
                                       OR IDAS.clwstatus IN (4, 6))
                      WHERE     ISG.GROUPNUMBER LIKE servicereqno || '%'
                            AND coalesce (ISR.isrouted, FALSE) = FALSE
                   GROUP BY ISG.groupid, ISG.GROUPNUMBER, IsR.intakenumber)
                  AS Assignlist
         /* Sorting implemented by Gavaskar 10-01-2019 */
         ORDER BY (CASE sortorder
                      WHEN 'asc'
                      THEN
                         CASE sortcolumn
                            WHEN 'servicerequestnumber'
                            THEN
                               cast (
                                  Assignlist.servicerequestnumber
                                     AS CHARACTER VARYING)
                            WHEN 'assigneddate'
                            THEN
                               cast (
                                  Assignlist.assigneddate
                                     AS CHARACTER VARYING)
                            WHEN 'reporteddate'
                            THEN
                               cast (
                                  Assignlist.reporteddate
                                     AS CHARACTER VARYING)
                            WHEN 'routeddate'
                            THEN
                               cast (
                                  Assignlist.routeddate AS CHARACTER VARYING)
                            WHEN 'cjamspid'
                            THEN
                               cast (
                                  Assignlist.cjamspid AS CHARACTER VARYING)
                            WHEN 'intakenumber'
                            THEN
                               cast (
                                  Assignlist.intakenumber
                                     AS CHARACTER VARYING)
                            ELSE
                               cast (
                                  Assignlist.assigneddate
                                     AS CHARACTER VARYING)
                         END
                   END) ASC,
                  (CASE sortorder
                      WHEN 'desc'
                      THEN
                         CASE sortcolumn
                            WHEN 'servicerequestnumber'
                            THEN
                               cast (
                                  Assignlist.servicerequestnumber
                                     AS CHARACTER VARYING)
                            WHEN 'assigneddate'
                            THEN
                               cast (
                                  Assignlist.assigneddate
                                     AS CHARACTER VARYING)
                            WHEN 'reporteddate'
                            THEN
                               cast (
                                  Assignlist.reporteddate
                                     AS CHARACTER VARYING)
                            WHEN 'routeddate'
                            THEN
                               cast (
                                  Assignlist.routeddate AS CHARACTER VARYING)
                            WHEN 'cjamspid'
                            THEN
                               cast (
                                  Assignlist.cjamspid AS CHARACTER VARYING)
                            WHEN 'intakenumber'
                            THEN
                               cast (
                                  Assignlist.intakenumber
                                     AS CHARACTER VARYING)
                            ELSE
                               cast (
                                  Assignlist.assigneddate
                                     AS CHARACTER VARYING)
                         END
                   END) DESC
            --coalesce(routeddate,assignedon)  desc

            LIMIT pagesize
           OFFSET v_pageoffset;
   ELSE
      RETURN QUERY
           SELECT count (1) OVER (),
                  *,
                  (SELECT *
                   FROM getcasepersonname ('servicerequest',
                                           intakeserviceid::CHARACTER VARYING))
             FROM (SELECT (SELECT json_agg (x)
                           FROM (SELECT C.countyname, C.countyid
                                   FROM intakeservicerequestevaluation INE
                                        JOIN county C
                                           ON C.countyid = INE.countyid
                                  WHERE     INE.activeflag = 1
                                        AND INE.intakenumber = ISR.intakenumber
                                  LIMIT 1) AS x)
                             AS offencecounty,
                          (SELECT json_agg (x)
                           FROM (SELECT SCP.description
                                           AS casesourcendisposition,
                                        (CASE
                                            WHEN dispositioncode = 'FPTSAO'
                                            THEN
                                               'Court'
                                            ELSE
                                               'intake'
                                         END)
                                           AS casesource,
                                        (CASE
                                            WHEN dispositioncode = 'FPTSAO'
                                            THEN
                                               (SELECT (SELECT json_agg (x)
                                                        FROM (SELECT DISTINCT
                                                                     x.courtordertypekey,
                                                                     x.description
                                                                FROM (SELECT cott.courtordertypekey,
                                                                             cott.description,
                                                                             cott.courtordertypeid
                                                                        FROM intakeservicerequestcourtordertypeconfig
                                                                             cotc
                                                                             JOIN
                                                                             courtordertype
                                                                             cott
                                                                                ON cott.courtordertypekey =
                                                                                   cotc.courtordertypekey
                                                                             JOIN
                                                                             intakeservicerequestcourtaction
                                                                             CA
                                                                                ON     cotc.intakeservicerequestcourtactionid =
                                                                                       CA.intakeservicerequestcourtactionid
                                                                                   AND CA.activeflag =
                                                                                       1
                                                                       WHERE CA.intakenumber =
                                                                             ISR.intakenumber
                                                                      UNION
                                                                      SELECT cott.courtordertypekey,
                                                                             cott.description,
                                                                             cott.courtordertypeid
                                                                        FROM intakeservicerequestcourtordertypeconfig
                                                                             cotc
                                                                             JOIN
                                                                             courtordertype
                                                                             cott
                                                                                ON cott.courtordertypekey =
                                                                                   cotc.courtordertypekey
                                                                             JOIN
                                                                             intakeservicerequestcourtaction
                                                                             CA
                                                                                ON     cotc.intakeservicerequestcourtactionid =
                                                                                       CA.intakeservicerequestcourtactionid
                                                                                   AND CA.activeflag =
                                                                                       1
                                                                             JOIN
                                                                             courtactionallegationconfig
                                                                             CAC
                                                                                ON     CAC.intakeservicerequestcourtactionid =
                                                                                       CA.intakeservicerequestcourtactionid
                                                                                   AND CAC.activeflag =
                                                                                       1
                                                                       WHERE CA.intakenumber =
                                                                             ISR.intakenumber)
                                                                     AS x) AS x))
                                         END)
                                           AS casecondtioncourtorders
                                   FROM servicerequesttypeconfigdispositioncode
                                        SCP
                                        JOIN
                                        intakeservicerequestdispositioncode
                                        ISRD
                                           ON     ISRD.servicerequesttypeconfigiddispostionid =
                                                  SCP.servicerequesttypeconfigiddispostionid
                                              AND ISRD.activeflag = 1
                                  WHERE ISRD.intakeserviceid =
                                        ISR.intakeserviceid) AS x)
                             AS caseconditions,
                          PN.old_id
                             AS assistid,
                          PN.cjamspid,
                          ISR.intakeserviceid,
                          cast (
                                ISR.servicerequestnumber
                             || CASE coalesce (isr.actiontype, '')
                                   WHEN ''
                                   THEN
                                      ''
                                   ELSE
                                         '  ('
                                      || coalesce (isr.actiontype, '')
                                      || ')'
                                END AS CHARACTER VARYING)
                             AS servicerequestnumber,
                          cast (
                             CASE ISR.iscps
                                WHEN TRUE THEN 'CPS'
                                WHEN FALSE THEN 'Non  CPS'
                                ELSE ''
                             END AS CHARACTER VARYING),
                          (SELECT itsrt.intakeservreqtypekey
                            FROM intakeservicerequesttype AS itsrt
                           WHERE     itsrt.intakeservreqtypeid =
                                     ISR.intakeservreqtypeid
                                 AND itsrt.activeflag = 1
                           LIMIT 1),
                          (SELECT srst.classkey
                            FROM servicerequestsubtype AS srst
                           WHERE     srst.servicerequestsubtypeid =
                                     ISR.intakeservicerequestclassid
                                 AND srst.activeflag = 1
                           LIMIT 1),
                          ISR.reporteddate
                             AS reporteddate,
                          (SELECT getreportername
                           FROM getreportername (
                                   'servicerequest',
                                   ISR.intakeserviceid::CHARACTER VARYING,
                                   'reporter'))
                             AS clientname,
                          CASE isr.isaccepted
                             WHEN TRUE THEN 'Accepted'
                             WHEN FALSE THEN 'Rejected'
                             ELSE 'Pending'
                          END::CHARACTER VARYING,
                          ISR.insertedon
                             AS routeddate,
                          cast (
                             up.lastname || ',  ' || up.firstname
                                AS CHARACTER VARYING)
                             assigneduser,
                          ISR.isrouted,
                          R.Assignedon
                             AS assigneddate,
                          FALSE,
                          cast ('' AS CHARACTER VARYING),
                          ISR.accepteddate::TIMESTAMP WITHOUT TIME ZONE,
                          ISR.intakenumber
                             AS intakenumber,
                          NULL::json,
                          (SELECT json_agg (e) AS fatality
                             FROM (SELECT isrs.ischildfatality,
                                          isrs.ismaltreatment
                                     FROM intakeservicerequestsdm isrs
                                    WHERE     isrs.intakenumber =
                                              ISR.IntakeNumber
                                          AND activeflag = 1) AS e)::json,
                          (SELECT (CASE
                                      WHEN TBPM.approval_status_cd = '3047'
                                      THEN
                                         'Approved'::CHARACTER VARYING
                                      WHEN TBPM.approval_status_cd = '3281'
                                      THEN
                                         'Rejected'::CHARACTER VARYING
                                      ELSE
                                         'Pending'::CHARACTER VARYING
                                   END)
                            FROM tb_placement AS TBPM
                                 JOIN Person AS P
                                    ON     P.cjamspid = TBPM.client_id
                                       AND P.activeflag = 1
                           WHERE     TBPM.case_id::CHARACTER VARYING =
                                     ISR.servicerequestnumber
                                 AND TBPM.delete_sw = 'N'
                                 AND (TBPM.exit_dt IS NULL)
                                 AND (TBPM.exit_tm IS NULL)
                                 AND (   TBPM.approval_status_cd IS NULL
                                      OR TBPM.approval_status_cd = ''
                                      OR TBPM.approval_status_cd != '3047')
                           LIMIT 1)
                             AS placementfostercareapprove,
                          (SELECT CASE
                                     WHEN TBSPA.sprvsr_approval_status_cd =
                                          '3047'
                                     THEN
                                        'Approved'::CHARACTER VARYING
                                     WHEN TBSPA.sprvsr_approval_status_cd =
                                          '3281'
                                     THEN
                                        'Rejected'::CHARACTER VARYING
                                     ELSE
                                        'Pending'::CHARACTER VARYING
                                  END AS serviceapprovestatus
                             FROM tb_service_log TBSL
                                  JOIN TB_SERVICE_PURCHASE_AUTHORIZATION TBSPA
                                     ON TBSPA.service_log_id =
                                        TBSL.service_log_id
                            WHERE TBSL.case_id::CHARACTER VARYING =
                                  ISR.servicerequestnumber
                            LIMIT 1)
                             AS serviceapprovestatus
                     FROM intakeservicerequest AS ISR
                          INNER JOIN
                          (  SELECT ISRA.intakeserviceid,
                                    (max (AR.personid::CHARACTER VARYING))::uuid personid
                               FROM intakeservicerequestactor AS ISRA
                                    INNER JOIN actor AS AR
                                       ON AR.actorid = ISRA.actorid
                              WHERE ISRA.intakeservicerequestpersontypekey IN
                                       ('RA',
                                        'CHILD',
                                        'BIOCHILD',
                                        'NVC',
                                        'OTHERCHILD',
                                        'PAC',
                                        'RC',
                                        'CLI',
                                        'Youth',
                                        '2085',
                                        'PA')
                           GROUP BY ISRA.intakeserviceid) ISRA
                             ON ISRA.intakeserviceid = ISR.intakeserviceid
                          INNER JOIN person AS PN
                             ON PN.personid = ISRA.personid
                          INNER JOIN
                          (SELECT DISTINCT
                                  objectid,
                                  cast (r.insertedon AS TIMESTAMP) assignedon,
                                  tosecurityusersid,
                                  activeflag
                             FROM ROUTING R
                            WHERE     R.fromsecurityusersid = userid
                                  AND routingstatustypeid = 4
                                  AND R.activeflag = 1) R
                             ON     r.objectid =
                                    cast (
                                       ISR.intakeserviceid AS CHARACTER VARYING)
                                AND r.activeflag = 1
                          LEFT JOIN userprofile up
                             ON     up.securityusersid = r.tosecurityusersid
                                AND up.activeflag = 1
                          LEFT JOIN intakeserreqstatustype irst
                             ON     irst.intakeserreqstatustypeid =
                                    ISR.intakeserreqstatustypeid
                                AND irst.activeflag = 1
                                AND lower (irst.Intakeserreqstatustypekey) NOT IN
                                       ('closed', 'rejected')
                          LEFT JOIN intakedastatus AS IDAS
                             ON     IDAS.intakenumber = ISR.intakenumber
                                AND IDAS.activeflag = 1 --and    (IDAS.clwstatus  is  null  or  IDAS.clwstatus  in(4,6))
                    WHERE     ISR.servicerequestnumber LIKE servicereqno || '%'
                          AND CASE
                                 WHEN assignedid IS NOT NULL
                                 THEN
                                    (r.tosecurityusersid = assignedid)
                                 ELSE
                                    TRUE
                              END
                          AND coalesce (ISR.isrouted, FALSE) = TRUE
                          AND ISR.activeflag = 1
                          AND (   coalesce (IDAS.isclw, FALSE) = FALSE
                               OR (    IDAS.isclw = TRUE
                                   AND ISR.intakeserviceid NOT IN
                                          (SELECT IG.intakeserviceid
                                            FROM IntakeServiceRequestGroupDetails
                                                 IG
                                           WHERE IG.activeflag = 1)
                                   AND ISR.intakenumber NOT IN
                                          (SELECT DISTINCT ISRE.intakenumber
                                             FROM intakeservicerequestevaluation
                                                  AS ISRE
                                                  JOIN
                                                  complaintstatustype AS CST
                                                     ON     CST.complaintstatustypekey =
                                                            ISRE.complaintstatustypekey
                                                        AND CST.activeflag = 1
                                            WHERE     CST.complaintstatustypekey NOT IN
                                                         ('CHC', 'CAS', 'RCAS')
                                                  AND ISRE.activeflag = 1)))
                   UNION ALL
                   SELECT (SELECT json_agg (x)
                           FROM (SELECT C.countyname, C.countyid
                                   FROM intakeservicerequestevaluation INE
                                        JOIN county C
                                           ON C.countyid = INE.countyid
                                  WHERE     INE.activeflag = 1
                                        AND INE.intakenumber = ISR.intakenumber
                                  LIMIT 1) AS x)
                             AS offencecounty,
                          (SELECT json_agg (x)
                           FROM (SELECT SCP.description
                                           AS casesourcendisposition,
                                        (CASE
                                            WHEN dispositioncode = 'FPTSAO'
                                            THEN
                                               'Court'
                                            ELSE
                                               'intake'
                                         END)
                                           AS casesource,
                                        (CASE
                                            WHEN dispositioncode = 'FPTSAO'
                                            THEN
                                               (SELECT (SELECT json_agg (x)
                                                        FROM (SELECT DISTINCT
                                                                     x.courtordertypekey,
                                                                     x.description
                                                                FROM (SELECT cott.courtordertypekey,
                                                                             cott.description,
                                                                             cott.courtordertypeid
                                                                        FROM intakeservicerequestcourtordertypeconfig
                                                                             cotc
                                                                             JOIN
                                                                             courtordertype
                                                                             cott
                                                                                ON cott.courtordertypekey =
                                                                                   cotc.courtordertypekey
                                                                             JOIN
                                                                             intakeservicerequestcourtaction
                                                                             CA
                                                                                ON     cotc.intakeservicerequestcourtactionid =
                                                                                       CA.intakeservicerequestcourtactionid
                                                                                   AND CA.activeflag =
                                                                                       1
                                                                       WHERE CA.intakenumber =
                                                                             ISR.intakenumber
                                                                      UNION
                                                                      SELECT cott.courtordertypekey,
                                                                             cott.description,
                                                                             cott.courtordertypeid
                                                                        FROM intakeservicerequestcourtordertypeconfig
                                                                             cotc
                                                                             JOIN
                                                                             courtordertype
                                                                             cott
                                                                                ON cott.courtordertypekey =
                                                                                   cotc.courtordertypekey
                                                                             JOIN
                                                                             intakeservicerequestcourtaction
                                                                             CA
                                                                                ON     cotc.intakeservicerequestcourtactionid =
                                                                                       CA.intakeservicerequestcourtactionid
                                                                                   AND CA.activeflag =
                                                                                       1
                                                                             JOIN
                                                                             courtactionallegationconfig
                                                                             CAC
                                                                                ON     CAC.intakeservicerequestcourtactionid =
                                                                                       CA.intakeservicerequestcourtactionid
                                                                                   AND CAC.activeflag =
                                                                                       1
                                                                       WHERE CA.intakenumber =
                                                                             ISR.intakenumber)
                                                                     AS x) AS x))
                                         END)
                                           AS casecondtioncourtorders
                                   FROM servicerequesttypeconfigdispositioncode
                                        SCP
                                        JOIN
                                        intakeservicerequestdispositioncode
                                        ISRD
                                           ON     ISRD.servicerequesttypeconfigiddispostionid =
                                                  SCP.servicerequesttypeconfigiddispostionid
                                              AND ISRD.activeflag = 1
                                  WHERE ISRD.intakeserviceid =
                                        ISR.intakeserviceid) AS x)
                             AS caseconditions,
                          PN.old_id
                             AS assistid,
                          PN.cjamspid,
                          ISR.intakeserviceid,
                          cast (
                                ISR.servicerequestnumber
                             || CASE coalesce (isr.actiontype, '')
                                   WHEN ''
                                   THEN
                                      ''
                                   ELSE
                                         '  ('
                                      || coalesce (isr.actiontype, '')
                                      || ')'
                                END AS CHARACTER VARYING)
                             AS servicerequestnumber,
                          cast (
                             CASE ISR.iscps
                                WHEN TRUE THEN 'CPS'
                                WHEN FALSE THEN 'Non  CPS'
                                ELSE ''
                             END AS CHARACTER VARYING),
                          (SELECT itsrt.intakeservreqtypekey
                            FROM intakeservicerequesttype AS itsrt
                           WHERE     itsrt.intakeservreqtypeid =
                                     ISR.intakeservreqtypeid
                                 AND itsrt.activeflag = 1
                           LIMIT 1),
                          (SELECT srst.classkey
                            FROM servicerequestsubtype AS srst
                           WHERE     srst.servicerequestsubtypeid =
                                     ISR.intakeservicerequestclassid
                                 AND srst.activeflag = 1
                           LIMIT 1),
                          ISR.reporteddate
                             AS reporteddate,
                          (SELECT getreportername
                           FROM getreportername (
                                   'servicerequest',
                                   ISR.intakeserviceid::CHARACTER VARYING,
                                   'reporter'))
                             AS clientname,
                          CASE isr.isaccepted
                             WHEN TRUE THEN 'Accepted'
                             WHEN FALSE THEN 'Rejected'
                             ELSE 'Pending'
                          END,
                          ISR.insertedon,
                          cast (
                             up.lastname || ',  ' || up.firstname
                                AS CHARACTER VARYING),
                          ISR.isrouted,
                          R.Assignedon
                             AS assigneddate,
                          FALSE,
                          cast ('' AS CHARACTER VARYING),
                          ISR.accepteddate::TIMESTAMP WITHOUT TIME ZONE,
                          ISR.intakenumber
                             AS intakenumber,
                          NULL,
                          (SELECT json_agg (e) AS fatality
                             FROM (SELECT isrs.ischildfatality,
                                          isrs.ismaltreatment
                                     FROM intakeservicerequestsdm isrs
                                    WHERE     isrs.intakenumber =
                                              ISR.IntakeNumber
                                          AND activeflag = 1) AS e)::json,
                          (SELECT (CASE
                                      WHEN TBPM.approval_status_cd = '3047'
                                      THEN
                                         'Approved'::CHARACTER VARYING
                                      WHEN TBPM.approval_status_cd = '3281'
                                      THEN
                                         'Rejected'::CHARACTER VARYING
                                      ELSE
                                         'Pending'::CHARACTER VARYING
                                   END)
                            FROM tb_placement AS TBPM
                                 JOIN Person AS P
                                    ON     P.cjamspid = TBPM.client_id
                                       AND P.activeflag = 1
                           WHERE     TBPM.case_id::CHARACTER VARYING =
                                     ISR.servicerequestnumber
                                 AND TBPM.delete_sw = 'N'
                                 AND (TBPM.exit_dt IS NULL)
                                 AND (TBPM.exit_tm IS NULL)
                                 AND (   TBPM.approval_status_cd IS NULL
                                      OR TBPM.approval_status_cd = ''
                                      OR TBPM.approval_status_cd != '3047')
                           LIMIT 1)
                             AS placementfostercareapprove,
                          (SELECT CASE
                                     WHEN TBSPA.sprvsr_approval_status_cd =
                                          '3047'
                                     THEN
                                        'Approved'::CHARACTER VARYING
                                     WHEN TBSPA.sprvsr_approval_status_cd =
                                          '3281'
                                     THEN
                                        'Rejected'::CHARACTER VARYING
                                     ELSE
                                        'Pending'::CHARACTER VARYING
                                  END AS serviceapprovestatus
                             FROM tb_service_log TBSL
                                  JOIN TB_SERVICE_PURCHASE_AUTHORIZATION TBSPA
                                     ON TBSPA.service_log_id =
                                        TBSL.service_log_id
                            WHERE TBSL.case_id::CHARACTER VARYING =
                                  ISR.servicerequestnumber
                            LIMIT 1)
                             AS serviceapprovestatus
                     FROM intakeservicerequest AS ISR
                          INNER JOIN
                          (  SELECT ISRA.intakeserviceid,
                                    (max (AR.personid::CHARACTER VARYING))::uuid personid
                               FROM intakeservicerequestactor AS ISRA
                                    INNER JOIN actor AS AR
                                       ON AR.actorid = ISRA.actorid
                              WHERE ISRA.intakeservicerequestpersontypekey IN
                                       ('RA',
                                        'CHILD',
                                        'BIOCHILD',
                                        'NVC',
                                        'OTHERCHILD',
                                        'PAC',
                                        'RC',
                                        'CLI',
                                        'Youth',
                                        '2085',
                                        'PA')
                           GROUP BY ISRA.intakeserviceid) ISRA
                             ON ISRA.intakeserviceid = ISR.intakeserviceid
                          INNER JOIN person AS PN
                             ON PN.personid = ISRA.personid
                          INNER JOIN
                          (SELECT DISTINCT
                                  objectid,
                                  tosecurityusersid,
                                  cast (r.insertedon AS TIMESTAMP) assignedon
                             FROM ROUTING R
                            WHERE     R.fromsecurityusersid = userid
                                  AND routingstatustypeid = 9) R
                             ON r.objectid =
                                cast (ISR.intakeserviceid AS CHARACTER VARYING)
                          LEFT JOIN userprofile up
                             ON     up.securityusersid = r.tosecurityusersid
                                AND up.activeflag = 1
                          LEFT JOIN intakeserreqstatustype irst
                             ON     irst.intakeserreqstatustypeid =
                                    ISR.intakeserreqstatustypeid
                                AND irst.activeflag = 1
                                AND lower (irst.Intakeserreqstatustypekey) NOT IN
                                       ('closed', 'rejected')
                          LEFT JOIN intakedastatus AS IDAS
                             ON     IDAS.intakenumber = ISR.intakenumber
                                AND IDAS.activeflag = 1 --and    (IDAS.clwstatus  is  null  or  IDAS.clwstatus  in(4,6))
                    WHERE     ISR.servicerequestnumber LIKE servicereqno || '%'
                          AND CASE
                                 WHEN assignedid IS NOT NULL
                                 THEN
                                    (ISR.routedusersid = assignedid)
                                 ELSE
                                    TRUE
                              END
                          AND ISR.activeflag = 1
                          AND (   coalesce (IDAS.isclw, FALSE) = FALSE
                               OR (    IDAS.isclw = TRUE
                                   AND ISR.intakeserviceid NOT IN
                                          (SELECT IG.intakeserviceid
                                            FROM IntakeServiceRequestGroupDetails
                                                 IG
                                           WHERE IG.activeflag = 1)
                                   AND ISR.intakenumber NOT IN
                                          (SELECT DISTINCT ISRE.intakenumber
                                             FROM intakeservicerequestevaluation
                                                  AS ISRE
                                                  JOIN
                                                  complaintstatustype AS CST
                                                     ON     CST.complaintstatustypekey =
                                                            ISRE.complaintstatustypekey
                                                        AND CST.activeflag = 1
                                            WHERE     CST.complaintstatustypekey NOT IN
                                                         ('CHC', 'CAS', 'RCAS')
                                                  AND ISRE.activeflag = 1))))
                  AS assignlist
         /* Sorting implemented by Gavaskar 10-01-2019 */
         ORDER BY (CASE sortorder
                      WHEN 'asc'
                      THEN
                         CASE lower (sortcolumn)
                            WHEN 'servicerequestnumber'
                            THEN
                               cast (
                                  assignlist.servicerequestnumber
                                     AS CHARACTER VARYING)
                            WHEN 'assigneddate'
                            THEN
                               cast (
                                  assignlist.assigneddate
                                     AS CHARACTER VARYING)
                            WHEN 'reporteddate'
                            THEN
                               cast (
                                  assignlist.reporteddate
                                     AS CHARACTER VARYING)
                            WHEN 'routeddate'
                            THEN
                               cast (
                                  assignlist.routeddate AS CHARACTER VARYING)
                            WHEN 'cjamspid'
                            THEN
                               cast (
                                  assignlist.cjamspid AS CHARACTER VARYING)
                            WHEN 'intakenumber'
                            THEN
                               cast (
                                  assignlist.intakenumber
                                     AS CHARACTER VARYING)
                            ELSE
                               cast (
                                  assignlist.assigneddate
                                     AS CHARACTER VARYING)
                         END
                   END) ASC,
                  (CASE sortorder
                      WHEN 'desc'
                      THEN
                         CASE lower (sortcolumn)
                            WHEN 'servicerequestnumber'
                            THEN
                               cast (
                                  assignlist.servicerequestnumber
                                     AS CHARACTER VARYING)
                            WHEN 'assigneddate'
                            THEN
                               cast (
                                  assignlist.assigneddate
                                     AS CHARACTER VARYING)
                            WHEN 'reporteddate'
                            THEN
                               cast (
                                  assignlist.reporteddate
                                     AS CHARACTER VARYING)
                            WHEN 'routeddate'
                            THEN
                               cast (
                                  assignlist.routeddate AS CHARACTER VARYING)
                            WHEN 'cjamspid'
                            THEN
                               cast (
                                  assignlist.cjamspid AS CHARACTER VARYING)
                            WHEN 'intakenumber'
                            THEN
                               cast (
                                  assignlist.intakenumber
                                     AS CHARACTER VARYING)
                            ELSE
                               cast (
                                  assignlist.assigneddate
                                     AS CHARACTER VARYING)
                         END
                   END) DESC
            --coalesce(routeddate,assignedon)  desc

            LIMIT pagesize
           OFFSET v_pageoffset;
   END IF;
---order  by  coalesce(ISR.routedon,ISR.insertedon)  desc  --  LIMIT  pagesize  OFFSET  v_pageoffset    ;

END;
$$;