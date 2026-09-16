CREATE OR REPLACE FUNCTION cjams.reviewsummary (
   IN i_personid     uuid,
   IN pagenumber     BIGINT,
   IN pagesize       BIGINT,
   IN i_searchtext   CHARACTER VARYING,
   IN v_nolimit      BOOLEAN DEFAULT FALSE)
   RETURNS TABLE
           (
              totalcount              BIGINT,
              intakenumber            CHARACTER VARYING,
              intakeserviceid         uuid,
              servicerequestnumber    CHARACTER VARYING,
              workername              CHARACTER VARYING,
              workerid                BIGINT,
              createddate             TIMESTAMP WITHOUT TIME ZONE,
              reviewtype              TEXT,
              submissiondata          jsonb
           )
   LANGUAGE 'plpgsql'
   VOLATILE
   NOT LEAKPROOF
   SECURITY INVOKER
   PARALLEL UNSAFE
   ROWS 1000
AS
$$


DECLARE
   v_pageoffset   INT;
   v_pagenumber   INT;
BEGIN
   v_pagenumber := pagenumber - 1;
   v_pageoffset = v_pagenumber * pagesize;

   IF COALESCE (pagesize, 0) < 1
   THEN
      pagesize := 10;
   END IF;

   IF COALESCE (pagenumber, 0) < 1
   THEN
      pagenumber := 1;
   END IF;

   SELECT count (1) OVER () AS totalcount, x.*
     FROM ((SELECT INS.intakenumber,
                   ASM.objectid AS intakeserviceid,
                   INS.servicerequestnumber,
                   UP.displayname AS workername,
                   UP.cjamspid AS workerid,
                   ASM.insertedon AS createddate,
                   ASMT.titleheadertext AS reviewtype,
                   ASM.submissiondata
              FROM assessment ASM
                   INNER JOIN assessmenttemplate ASMT
                      ON     ASMT.assessmenttemplateid =
                             ASM.assessmenttemplateid
                         AND ASMT.name IN ('initialScr', 'subsequentScr')
                         AND ASMT.activeflag = 1
                   INNER JOIN intakeservicerequest INS
                      ON     INS.intakeserviceid = ASM.objectid
                         AND INS.activeflag = 1
                   INNER JOIN userprofile UP
                      ON     UP.securityusersid = ASM.securityusersid
                         AND UP.activeflag = 1
             WHERE     ASM.activeflag = 1
                   AND ASM.objectname = 'servicerequest'
                   AND ASM.objectid IN
                          (SELECT DISTINCT fp.intakeserviceid
                             FROM focuspersoncasestatus fp
                            WHERE     fp.personid = i_personid
                                  AND CASE
                                         WHEN (    i_searchtext != ''
                                               AND i_searchtext IS NOT NULL)
                                         THEN
                                            fp.focuspersonstatustypekey =
                                            i_searchtext
                                         ELSE
                                            1 = 1
                                      END--   select INTSR.intakeserviceid from intakeservicerequest INTSR
                                         --   join intakeservicerequestactor INSRA on INSRA.intakeserviceid=INTSR.intakeserviceid and INSRA.activeflag=1
                                         --   join actor ACC on ACC.actorid=INSRA.actorid and ACC.activeflag=1 and ACC.actortype=''Youth''
                                         --   join person p on Acc.personid=p.personid and p.activeflag=1
                                         --   join focuspersoncasestatus fp on fp.personid=p.personid and fp.activeflag=1
                                         --   where ACC.personid ='''||i_personid||''''||youthstatussearch||'
                                         ))
           UNION ALL
           (SELECT ASM.intakenumber,
                   ASM.objectid AS intakeserviceid,
                   '''' AS servicerequestnumber,
                   UP.displayname AS workername,
                   UP.cjamspid AS workerid,
                   ASM.insertedon AS createddate,
                   ASMT.titleheadertext AS reviewtype,
                   ASM.submissiondata
              FROM assessment ASM
                   INNER JOIN assessmenttemplate ASMT
                      ON     ASMT.assessmenttemplateid =
                             ASM.assessmenttemplateid
                         AND ASMT.name IN ('initialScr', 'subsequentScr')
                         AND ASMT.activeflag = 1
                   INNER JOIN intakedastatus INS
                      ON     INS.intakenumber = ASM.intakenumber
                         AND INS.activeflag = 1
                   INNER JOIN userprofile UP
                      ON     UP.securityusersid = ASM.securityusersid
                         AND UP.activeflag = 1
             WHERE     ASM.activeflag = 1
                   AND (   ASM.objectid =
                           '00000000-0000-0000-0000-000000000000'
                        OR ASM.objectid IS NULL)
                   AND ASM.intakenumber IN
                          (SELECT DISTINCT fp.intakenumber
                             FROM focuspersoncasestatus fp
                            WHERE     fp.personid = i_personid
                                  AND CASE
                                         WHEN (    i_searchtext != ''
                                               AND i_searchtext IS NOT NULL)
                                         THEN
                                            fp.focuspersonstatustypekey =
                                            i_searchtext
                                         ELSE
                                            1 = 1
                                      END--   select INTSR.intakeserviceid from intakeservicerequest INTSR
                                         --   join intakeservicerequestactor INSRA on INSRA.intakeserviceid=INTSR.intakeserviceid and INSRA.activeflag=1
                                         --   join actor ACC on ACC.actorid=INSRA.actorid and ACC.activeflag=1 and ACC.actortype=''Youth''
                                         --   join person p on Acc.personid=p.personid and p.activeflag=1
                                         --   join focuspersoncasestatus fp on fp.personid=p.personid and fp.activeflag=1
                                         --   where ACC.personid ='''||i_personid||''''||youthstatussearch||'
                                         ))) AS x
    LIMIT CASE WHEN v_nolimit = FALSE THEN pagesize END
   OFFSET CASE WHEN v_nolimit = FALSE THEN v_pageoffset END;
END;
$$
