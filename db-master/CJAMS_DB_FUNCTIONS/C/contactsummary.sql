CREATE OR REPLACE FUNCTION cjams.contactsummary (
   IN i_personid     uuid,
   IN pagenumber     BIGINT,
   IN pagesize       BIGINT,
   IN i_searchtext   CHARACTER VARYING,
   IN v_nolimit      BOOLEAN DEFAULT FALSE)
   RETURNS TABLE
           (
              totalcount              BIGINT,
              intakeserviceid         uuid,
              servicerequestnumber    CHARACTER VARYING,
              intakenumber            CHARACTER VARYING,
              staffname               CHARACTER VARYING,
              contactdate             TIMESTAMP WITHOUT TIME ZONE,
              contacttype             TEXT,
              contactstatus           BOOLEAN,
              locationname            CHARACTER VARYING
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


   RETURN QUERY
      SELECT COUNT (1) OVER () AS totalcount,
             ISR.intakeserviceid,
             ISR.servicerequestnumber,
             ISR.intakenumber,
             up.displayname,
             PN.contactdate,
             PNT.description AS contacttype,
             PN.contactstatus,
             PN.locationname
        FROM IntakeServiceRequest AS ISR
             INNER JOIN ProgressNote AS PN
                ON CAST (ISR.IntakeServiceId AS VARCHAR (50)) =
                   PN.EntityTypeId
             LEFT OUTER JOIN DocumentProperties DP
                ON DP.DocumentPropertiesId = PN.DocumentPropertiesId
             INNER JOIN ProgressNoteDetail AS PND
                ON     PN.ProgressNoteId = PND.ProgressNoteId
                   AND PND.ActiveFlag = 1
             INNER JOIN ProgressNoteType AS PNT
                ON PNT.ProgressNoteTypeId = PN.ProgressNoteTypeId
             INNER JOIN UserProfile up ON pn.insertedby = up.SecurityUsersId
             LEFT JOIN AreaTeamMemberServiceRequest atmsr
                ON     isr.IntakeServiceId = atmsr.IntakeServiceId
                   AND atmsr.ActiveFlag = 1
             LEFT JOIN TeamMember tm ON atmsr.TeamMemberId = tm.TeamMemberId
             LEFT JOIN Team te ON tm.TeamId = te.TeamId
             LEFT JOIN Progressnoteroletype AS PNRT
                ON     PN.ProgressNoteId = PNRT.ProgressNoteId
                   AND PNRT.ActiveFlag = 1
             LEFT JOIN progressnotepurposetype AS PNPT
                ON     PNPT.progressnotepurposetypekey =
                       PN.progressnotepurposetypekey
                   AND PNRT.ActiveFlag = 1
       WHERE     PN.savemode = TRUE
             AND ISR.IntakeServiceId IN
                    (SELECT INTSR.intakeserviceid
                      FROM intakeservicerequest INTSR
                           INNER JOIN intakeservicerequestactor INSRA
                              ON     INSRA.intakeserviceid =
                                     INTSR.intakeserviceid
                                 AND INSRA.activeflag = 1
                           INNER JOIN actor ACC
                              ON     ACC.actorid = INSRA.actorid
                                 AND ACC.activeflag = 1
                                 AND ACC.actortype = 'Youth'
                           INNER JOIN person p
                              ON     Acc.personid = p.personid
                                 AND p.activeflag = 1
                           INNER JOIN focuspersoncasestatus fp
                              ON     fp.personid = p.personid
                                 AND fp.activeflag = 1
                     WHERE     ACC.personid = i_personid
                           AND CASE
                                  WHEN (    i_searchtext != ''
                                        AND i_searchtext IS NOT NULL)
                                  THEN
                                     fp.focuspersonstatustypekey =
                                     i_searchtext
                                  ELSE
                                     1 = 1
                               END)
       LIMIT CASE WHEN v_nolimit = FALSE THEN pagesize END
      OFFSET CASE WHEN v_nolimit = FALSE THEN v_pageoffset END;
END;
$$