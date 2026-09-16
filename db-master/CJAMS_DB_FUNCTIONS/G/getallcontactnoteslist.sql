CREATE OR REPLACE FUNCTION cjams.getallcontactnoteslist (IN searchjson json)
   RETURNS TABLE
           (
              totalcount                    BIGINT,
              progressnoteid                uuid,
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
              historycount                  INTEGER
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
   v_IntakeServiceID   uuid;
   v_notesid           CHARACTER VARYING (50);
   v_stafftype         CHARACTER VARYING (100);
   v_datefrom          TIMESTAMP;
   v_dateto            TIMESTAMP;
   v_workername        CHARACTER VARYING (100);
   v_keyword           TEXT;
   v_liPageNumber      INT;
   v_liPageSize        INT;
   v_pageoffset        INT;
   v_pagenumber        INT;
   v_nolimit           BOOLEAN;
BEGIN
   v_liPageNumber := searchjson ->> 'pagenumber';
   v_liPageSize := searchjson ->> 'pagesize';
   v_IntakeServiceID := searchjson ->> 'servicerequestid';
   v_notesid := searchjson ->> 'notesid';
   v_stafftype := searchjson ->> 'stafftype';
   v_datefrom := searchjson ->> 'datefrom';
   v_dateto := searchjson ->> 'dateto';
   v_workername := searchjson ->> 'workername';
   v_keyword := searchjson ->> 'keyword';
   v_nolimit := searchjson ->> 'nolimit';

   v_pagenumber := v_liPageNumber - 1;
   v_pageoffset = v_pagenumber * v_liPageSize;


   IF COALESCE (v_liPageNumber, 0) < 1
   THEN
      v_liPageNumber := 10;
   END IF;

   IF COALESCE (v_liPageSize, 0) < 1
   THEN
      v_liPageSize := 1;
   END IF;

   IF (v_notesid IS NULL OR v_notesid = '')
   THEN
      RETURN QUERY
         SELECT COUNT (1) OVER ()
                   AS totalcount,
                PN.ProgressNoteId,
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
                    WHERE pns.progressnotesubtypeid =
                          PN.progressnotesubtypeid),
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
                CAST (
                   COALESCE (PN.ContactDate, PN.insertedon) AS TIMESTAMP (3))
                   AS ContactDate,
                COALESCE (PN.ContactName, '')
                   AS ContactName,
                (SELECT json_agg (roletype)
                 FROM (SELECT prt.contactroletypekey,
                              prt.progressnoteroletypeid
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
                CAST (
                   COALESCE (PN.insertedon, PN.insertedon) AS TIMESTAMP (3))
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
                (SELECT COUNT (1)
                   FROM ProgressNote AS PN1
                  WHERE PN.notesid = PN1.notesid AND PN1.activeflag = 0)::INT
                   AS historycount
           FROM IntakeServiceRequest AS ISR
                INNER JOIN ProgressNote AS PN
                   ON     CAST (ISR.IntakeServiceId AS VARCHAR (50)) =
                          PN.EntityTypeId
                      AND PN.ActiveFlag = 1
                INNER JOIN ProgressNoteType AS PNT
                   ON     PNT.ProgressNoteTypeId = PN.ProgressNoteTypeId
                      AND PNT.ActiveFlag = 1
                INNER JOIN UserProfile up
                   ON     pn.insertedby = up.SecurityUsersId
                      AND up.ActiveFlag = 1
                LEFT JOIN AreaTeamMemberServiceRequest atmsr
                   ON     isr.IntakeServiceId = atmsr.IntakeServiceId
                      AND atmsr.ActiveFlag = 1
                LEFT JOIN TeamMember tm
                   ON     atmsr.TeamMemberId = tm.TeamMemberId
                      AND tm.ActiveFlag = 1
                LEFT JOIN Team te
                   ON tm.TeamId = te.TeamId AND te.activeflag = 1
                INNER JOIN progressnotepurposetype AS PNPT
                   ON     PNPT.progressnotepurposetypekey =
                          PN.progressnotepurposetypekey
                      AND PNPT.ActiveFlag = 1
                LEFT JOIN referencevalues AS RV
                   ON RV.ref_key = PN.stafftypekey AND RV.ActiveFlag = 1
                INNER JOIN referencetype AS RT
                   ON     RT.referencetypeid = RV.referencetypeid
                      AND RT.ActiveFlag = 1
                      AND lower (RT.tablename) = 'progressnotestafftype'
          WHERE     (ISR.IntakeServiceId = v_IntakeServiceID)
                AND lower (PNT.ProgressNoteClassificationTypeKey) = 'user'
                AND PNT.parentid IS NULL
                AND ISR.activeflag = 1
                AND (   v_stafftype IS NULL
                     OR RV.description ILIKE
                           v_stafftype || '%')
                AND (   v_datefrom IS NULL
                     OR (CAST (PN.insertedon AS DATE) BETWEEN CAST (
                                                                 v_datefrom
                                                                    AS DATE)
                                                          AND CAST (
                                                                 v_dateto
                                                                    AS DATE)))
                AND (   v_workername IS NULL
                     OR UP.DisplayName ILIKE
                           v_workername || '%')
                AND (   v_keyword IS NULL
                     OR PN.description ILIKE
                           v_keyword || '%')
          LIMIT CASE WHEN v_nolimit = FALSE THEN v_liPageSize END
         OFFSET CASE WHEN v_nolimit = FALSE THEN v_pageoffset END;
   ELSE
      RETURN QUERY
         SELECT COUNT (1) OVER ()
                   AS totalcount,
                PN.ProgressNoteId,
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
                    WHERE pns.progressnotesubtypeid =
                          PN.progressnotesubtypeid),
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
                CAST (
                   COALESCE (PN.ContactDate, PN.insertedon) AS TIMESTAMP (3))
                   AS ContactDate,
                COALESCE (PN.ContactName, '')
                   AS ContactName,
                (SELECT json_agg (roletype)
                 FROM (SELECT prt.contactroletypekey,
                              prt.progressnoteroletypeid
                         FROM progressnoteroletype prt
                        WHERE     prt.progressnoteid = PN.progressnoteid
                              AND prt.activeflag = 0) roletype)::jsonb
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
                CAST (
                   COALESCE (PN.insertedon, PN.insertedon) AS TIMESTAMP (3))
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
                0
                   AS history
           FROM IntakeServiceRequest AS ISR
                JOIN ProgressNote AS PN
                   ON     CAST (ISR.IntakeServiceId AS VARCHAR (50)) =
                          PN.EntityTypeId
                      AND PN.activeflag = 1
                JOIN ProgressNoteType AS PNT
                   ON     PNT.ProgressNoteTypeId = PN.ProgressNoteTypeId
                      AND PNT.activeflag = 1
                JOIN UserProfile up
                   ON     pn.insertedby = up.SecurityUsersId
                      AND UP.activeflag = 1
                LEFT JOIN AreaTeamMemberServiceRequest atmsr
                   ON     isr.IntakeServiceId = atmsr.IntakeServiceId
                      AND atmsr.ActiveFlag = 1
                LEFT JOIN TeamMember tm
                   ON atmsr.TeamMemberId = tm.TeamMemberId
                LEFT JOIN Team te ON tm.TeamId = te.TeamId
                JOIN progressnotepurposetype AS PNPT
                   ON     PNPT.progressnotepurposetypekey =
                          PN.progressnotepurposetypekey
                      AND PNPT.ActiveFlag = 1
                LEFT JOIN referencevalues AS RV
                   ON RV.ref_key = PN.stafftypekey AND RV.ActiveFlag = 1
                JOIN referencetype AS RT
                   ON     RT.referencetypeid = RV.referencetypeid
                      AND RT.ActiveFlag = 1
                      AND lower (RT.tablename) = 'progressnotestafftype'
          WHERE     (ISR.IntakeServiceId = v_IntakeServiceID)
                AND lower (PNT.ProgressNoteClassificationTypeKey) = 'user'
                AND PNT.parentid IS NULL
                AND PN.ActiveFlag = 0
                AND PN.notesid = v_notesid
                AND ISR.activeflag = 1
                AND (   v_stafftype IS NULL
                     OR RV.description ILIKE
                           v_stafftype || '%')
                AND (   v_datefrom IS NULL
                     OR (CAST (PN.insertedon AS DATE) BETWEEN CAST (
                                                                 v_datefrom
                                                                    AS DATE)
                                                          AND CAST (
                                                                 v_dateto
                                                                    AS DATE)))
                AND (   v_workername IS NULL
                     OR UP.DisplayName ILIKE
                           v_workername || '%')
                AND (   v_keyword IS NULL
                     OR PN.description ILIKE
                           v_keyword || '%')
          LIMIT CASE WHEN v_nolimit = FALSE THEN v_liPageSize END
         OFFSET CASE WHEN v_nolimit = FALSE THEN v_pageoffset END;
   END IF;
END;
$$