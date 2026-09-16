CREATE OR REPLACE FUNCTION cjams.getfacetofacedetails11 (
   v_intakeserviceid   uuid)
   RETURNS json
   LANGUAGE 'plpgsql'
   VOLATILE
   NOT LEAKPROOF
   SECURITY INVOKER
   PARALLEL UNSAFE
AS
$$

DECLARE
   l_taskdetails   json;
DECLARE l_count         INTEGER;
DECLARE l_isvalid       INTEGER;
DECLARE l_canscount     INTEGER;
DECLARE l_miracount     INTEGER;
DECLARE l_safecount     INTEGER;
BEGIN
   SELECT count (1)
    INTO l_count
    FROM contactparticipant ct
         INNER JOIN progressnote pt
            ON     ct.progressnoteid = pt.progressnoteid
               AND ct.activeflag = 1
               AND pt.activeflag = 1
         INNER JOIN progressnotetype pty
            ON     pty.progressnotetypeid = pt.progressnotetypeid
               AND pty.activeflag = 1
         LEFT JOIN intakeservicerequestactor isra
            ON     isra.intakeservicerequestactorid =
                   ct.intakeservicerequestactorid
               AND isra.activeflag = 1
   --AND  isra.intakeservicerequestpersontypekey  ='LE'
   WHERE     pty.progressnotetypekey = 'Initialfacetoface'
         --AND ct.participanttypekey IN ('LO','Oth')  -- quick fix to disable facetoface popup
         AND pt.attemptindicator IS NOT NULL
         AND pt.entitytypeid::uuid = v_intakeserviceid;

   SELECT CASE
             WHEN Count (1) = 1 AND p.dateofdeath IS NOT NULL THEN 0
             ELSE 1
          END
       INTO l_isvalid
       FROM intakeservicerequestactor isra
            INNER JOIN actor A ON a.actorid = isra.actorid AND a.activeflag = 1
            INNER JOIN person p
               ON isra.personid = p.personid AND p.activeflag = 1
      WHERE     isra.intakeserviceid = v_intakeserviceid
            AND intakeservicerequestpersontypekey = 'RC'
            AND isra.activeflag = 1
   GROUP BY p.dateofdeath;

   SELECT count (1)
    INTO l_canscount
    FROM assessment ass
         INNER JOIN assessmenttemplate ast
            ON ast.assessmenttemplateid = ass.assessmenttemplateid
   WHERE     objectid = v_intakeserviceid
         AND ast.titleheadertext ILIKE
                '%CANS-F%'
         AND ass.assessmentstatustypekey = 'Accepted';

   SELECT count (1)
    INTO l_miracount
    FROM assessment ass
         INNER JOIN assessmenttemplate ast
            ON ast.assessmenttemplateid = ass.assessmenttemplateid
   WHERE     objectid = v_intakeserviceid
         AND ast.titleheadertext ILIKE
                '%MARYLAND FAMILY INITIAL  RISK ASSESSMENT%'
         AND ass.assessmentstatustypekey = 'Accepted';


   SELECT count (1)
    INTO l_safecount
    FROM assessment ass
         INNER JOIN assessmenttemplate ast
            ON ast.assessmenttemplateid = ass.assessmenttemplateid
   WHERE     objectid = v_intakeserviceid
         AND ast.titleheadertext ILIKE
                '%SAFE-C%'
         AND ass.assessmentstatustypekey = 'Accepted';

   RAISE NOTICE '%l_isvalid', l_isvalid;

   SELECT json_agg (ltask)
   INTO l_taskdetails
   FROM (SELECT 'initalfacetoface' AS taskname,
                CASE coalesce (l_count, 0)
                   WHEN 0 THEN UPPER ('no')
                   ELSE UPPER ('yes')
                END AS status,
                1  AS isvalid
         UNION ALL
         SELECT 'Personrole' AS taskname,
                UPPER ('yes') AS status,
                1  AS isvalid
         UNION ALL
         /*SELECT
       ata.name AS taskname,ata.amtaskid,
       min(UPPER(ast.typedescription)) AS status
       --l_isvalid AS isvalid
         FROM activitytask ata
     INNER JOIN activitystatustype ast ON ata.activitytaskstatustypekey=ast.activitystatustypekey AND ata.activeflag=1 AND ast.activeflag=1
     INNER JOIN activity act ON ata.activityid=act.activityid AND act.activeflag=1
     INNER JOIN investigation inv ON  act.objectid=inv.investigationid AND inv.activeflag=1
     WHERE ata.activitytasktypekey='InvAssessment' AND ata.assessmenttemplateid IS NOT NULL
         AND inv.intakeserviceid='296a8dce-c7a1-4e37-b730-0f8fd983c6c3' AND LOWER(ata.name) NOT IN ('reassessment')
         group by ata.name,ata.amtaskid*/


         SELECT 'Safe C Assessment' AS taskname,
                CASE coalesce (l_safecount, 0)
                   WHEN 0 THEN UPPER ('OPEN')
                   ELSE UPPER ('CLOSED')
                END AS status,
                l_isvalid AS isvalid
         UNION ALL
         SELECT 'MFIRA assessment' AS taskname,
                CASE coalesce (l_miracount, 0)
                   WHEN 0 THEN UPPER ('OPEN')
                   ELSE UPPER ('CLOSED')
                END AS status,
                l_isvalid AS isvalid
         UNION ALL
         SELECT 'CANS-F assessment' AS taskname,
                CASE coalesce (l_canscount, 0)
                   WHEN 0 THEN UPPER ('OPEN')
                   ELSE UPPER ('CLOSED')
                END AS status,
                l_isvalid AS isvalid) ltask;

   RETURN l_taskdetails;
END;
$$