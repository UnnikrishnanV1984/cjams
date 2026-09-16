CREATE OR REPLACE FUNCTION cjams.getrolebasecontactnote (
   IN pagenumber               BIGINT,
   IN pagesize                 BIGINT,
   IN v_teamtypekey            CHARACTER VARYING,
   IN v_intakenumber           CHARACTER VARYING,
   IN v_servicerequestnumber   CHARACTER VARYING)
   RETURNS TABLE
           (
              totalcount                    BIGINT,
              progressnoteid                uuid,
              intakenumber                  CHARACTER VARYING,
              servicerequestnumber          CHARACTER VARYING,
              progressnotetypeid            uuid,
              progressnotesubtypeid         uuid,
              progressnotepurposetypekey    CHARACTER VARYING,
              description                   TEXT,
              notesid                       CHARACTER VARYING,
              author                        CHARACTER VARYING,
              authorid                      CHARACTER VARYING,
              recordingtype                 CHARACTER VARYING,
              locationname                  CHARACTER VARYING,
              recordingsubtype              TEXT,
              title                         CHARACTER VARYING,
              team                          CHARACTER VARYING,
              draft                         BOOLEAN,
              attemptind                    BOOLEAN,
              contactdate                   TIMESTAMP WITHOUT TIME ZONE,
              contactname                   CHARACTER VARYING,
              progressroletype              jsonb,
              iseditable                    BOOLEAN,
              contactphone                  CHARACTER VARYING,
              contactemail                  CHARACTER VARYING,
              archivedon                    TIMESTAMP WITHOUT TIME ZONE,
              archivedby                    CHARACTER VARYING,
              recordingdate                 TIMESTAMP WITHOUT TIME ZONE,
              insertedby                    CHARACTER VARYING,
              starttime                     TIMESTAMP WITHOUT TIME ZONE,
              endtime                       TIMESTAMP WITHOUT TIME ZONE,
              stafftype                     CHARACTER VARYING,
              stafftypedescription          CHARACTER VARYING,
              instantresults                INTEGER,
              contactstatus                 BOOLEAN,
              drugscreen                    BOOLEAN,
              progressnotepurposetype       CHARACTER VARYING,
              historycount                  INTEGER,
              youthname                     TEXT,
              youthcjamspid                 BIGINT
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
DECLARE v_pageoffset   INT;
   v_pagenumber   INT;
BEGIN
   v_pagenumber := pagenumber - 1;
   v_pageoffset = v_pagenumber * pagesize;


   RETURN QUERY
      SELECT count (1) OVER ()
                AS totalcount,
             PN.ProgressNoteId,
             ISR.intakenumber,
             ISR.servicerequestnumber,
             PN.progressnotetypeid,
             PN.progressnotesubtypeid,
             PN.progressnotepurposetypekey,
             PN.description,
             PN.notesid,
             CASE
                WHEN (PNT.ProgressNoteClassificationTypeKey = 'System')
                THEN
                   'System'
                ELSE
                   COALESCE (UP.DisplayName, '')
             END
                AS Author,
             PN.insertedby
                AS Authorid,
             COALESCE (PNT.progressnotetypekey, '')
                AS RecordingType,
             PN.locationname,
             COALESCE (
                (SELECT pns.description
                   FROM progressnotesubtype pns
                  WHERE pns.progressnotesubtypeid = PN.progressnotesubtypeid),
                '')
                AS RecordingSubType,
             CASE
                WHEN (PNT.ProgressNoteClassificationTypeKey = 'System')
                THEN
                   ''
                ELSE
                   COALESCE (TM.RoleTypeKey, '')
             END
                AS Title,
             CASE
                WHEN (PNT.ProgressNoteClassificationTypeKey = 'System')
                THEN
                   ''
                ELSE
                   COALESCE (TE.TeamName, '')
             END
                AS Team,
             CASE
                WHEN (PNT.ProgressNoteClassificationTypeKey = 'System')
                THEN
                   0::BOOLEAN
                ELSE
                   COALESCE (PN.SaveMode, 0::BOOLEAN)
             END
                AS Draft,
             CASE
                WHEN (PNT.ProgressNoteClassificationTypeKey = 'System')
                THEN
                   NULL
                ELSE
                   PN.AttemptIndicator
             END
                AS AttemptInd,
             CAST (COALESCE (PN.ContactDate, PN.insertedon) AS TIMESTAMP (3))
                AS ContactDate,
             COALESCE (PN.ContactName, '')
                AS ContactName,
             (SELECT json_agg (roletype)
              FROM (SELECT prt.contactroletypekey, prt.progressnoteroletypeid
                      FROM progressnoteroletype prt
                     WHERE     prt.progressnoteid = PN.progressnoteid
                           AND prt.activeflag = 1) roletype)::jsonb
                AS progressroletype,
             ((extract (
                  DAY FROM   now () AT TIME ZONE 'utc'
                           - PN.insertedon AT TIME ZONE 'utc'))) <=
             7
                AS iseditable,
             COALESCE (PN.ContactPhone, '')
                AS ContactPhone,
             COALESCE (PN.ContactEmail, '')
                AS ContactEmail,
             COALESCE (PN.ArchivedOn, NULL)
                AS ArchivedOn,
             COALESCE (PN.ArchivedBy, '')
                AS ArchivedBy,
             CAST (COALESCE (PN.insertedon, PN.insertedon) AS TIMESTAMP (3))
                AS RecordingDate,
             PN.insertedby
                AS Insertedby,
             PN.starttime
                AS StartTime,
             PN.endtime
                AS EndTime,
             PN.stafftypekey
                AS StaffType,
             RV.description
                AS StaffTypeDescription,
             PN.instantresults
                AS InstantResults,
             PN.contactstatus
                AS ContactStatus,
             PN.drugscreen
                AS DrugScreen,
             COALESCE (PNPT.description, '')
                AS ProgressNotePurposeType,
             (SELECT count (1)
                FROM ProgressNote AS PN1
               WHERE PN.notesid = PN1.notesid AND PN1.activeflag = 0)::INT
                AS historycount,
             (SELECT p.firstname || ' ' || p.lastname AS youthname
                FROM intakeservicerequestactor isra
                     INNER JOIN person p
                        ON     isra.personid = p.personid
                           AND intakeserviceid = ISR.IntakeServiceId
                           AND p.activeflag = 1
                           AND isra.activeflag = 1
                           AND isra.intakeservicerequestpersontypekey =
                               'Youth'
               LIMIT 1),
             (SELECT p.cjamspid
               FROM intakeservicerequestactor isra
                    INNER JOIN person p
                       ON     isra.personid = p.personid
                          AND intakeserviceid = ISR.IntakeServiceId
                          AND p.activeflag = 1
                          AND isra.activeflag = 1
                          AND isra.intakeservicerequestpersontypekey = 'Youth'
              LIMIT 1)
        FROM progressnote PN
             INNER JOIN IntakeServiceRequest ISR
                ON     (ISR.IntakeServiceId::CHARACTER VARYING) =
                       PN.EntityTypeId
                   AND ISR.activeflag = 1
             INNER JOIN ProgressNoteType PNT
                ON     PNT.ProgressNoteTypeId = PN.ProgressNoteTypeId
                   AND PNT.activeflag = 1
             INNER JOIN progressnotetypeconfig PNTC
                ON     PNTC.progressnotetypekey = PNT.progressnotetypekey
                   AND PNTC.activeflag = 1
             INNER JOIN UserProfile up
                ON pn.insertedby = up.SecurityUsersId AND up.activeflag = 1
             LEFT JOIN AreaTeamMemberServiceRequest atmsr
                ON     isr.IntakeServiceId = atmsr.IntakeServiceId
                   AND atmsr.ActiveFlag = 1
             LEFT JOIN TeamMember tm
                ON atmsr.TeamMemberId = tm.TeamMemberId AND tm.activeflag = 1
             LEFT JOIN Team te ON tm.TeamId = te.TeamId AND te.activeflag = 1
             INNER JOIN progressnotepurposetype AS PNPT
                ON     PNPT.progressnotepurposetypekey =
                       PN.progressnotepurposetypekey
                   AND PNPT.ActiveFlag = 1
             LEFT JOIN referencevalues AS RV
                ON RV.ref_key = PN.stafftypekey AND RV.ActiveFlag = 1
             INNER JOIN referencetype AS RT
                ON     RT.referencetypeid = RV.referencetypeid
                   AND RT.ActiveFlag = 1
                   AND LOWER (RT.tablename) = 'progressnotestafftype'
       WHERE     PNTC.teamtypekey = v_teamtypekey
             AND lower (PNT.ProgressNoteClassificationTypeKey) = 'user'
             AND PNT.parentid IS NULL
             AND PN.ActiveFlag = 1
             AND (   v_intakenumber IS NULL
                  OR ISR.intakenumber ILIKE
                        v_intakenumber || '%')
             AND (   v_servicerequestnumber IS NULL
                  OR ISR.servicerequestnumber ILIKE
                        v_servicerequestnumber || '%')
       LIMIT pagesize
      OFFSET v_pageoffset;
END;
$$