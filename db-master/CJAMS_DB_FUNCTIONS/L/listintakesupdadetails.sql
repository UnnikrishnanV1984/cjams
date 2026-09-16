CREATE OR REPLACE FUNCTION cjams.listintakesupdadetails (
   IN securityusersid   CHARACTER VARYING,
   IN v_status          CHARACTER VARYING,
   IN pagenumber        BIGINT,
   IN pagesize          BIGINT,
   IN intakeno          CHARACTER VARYING,
   IN sortcolumn        CHARACTER VARYING,
   IN sortorder         CHARACTER VARYING)
   RETURNS TABLE
           (
              totalcount       BIGINT,
              intakenumber     CHARACTER VARYING,
              datereceived     TIMESTAMP WITHOUT TIME ZONE,
              timereceived     TIMESTAMP WITHOUT TIME ZONE,
              submitteddate    TIMESTAMP WITHOUT TIME ZONE,
              intakestatus     CHARACTER VARYING,
              youthname        CHARACTER VARYING,
              youthcjamspid    BIGINT
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
   v_UserSID      CHARACTER VARYING;
BEGIN
   v_UserSID := securityusersid;

   v_pagenumber := pagenumber - 1;

   v_pageoffset = v_pagenumber * pagesize;


   RETURN QUERY
        SELECT count (1) OVER (),
               IDAS.intakenumber,
               IDAS.DateRecieved,
               IDAS.TimeRecieved::TIMESTAMP WITHOUT TIME ZONE,
               (SELECT isr.insertedon
                 FROM intakeservicerequest isr
                WHERE     isr.activeflag = 1
                      AND isr.intakenumber = IDAS.intakenumber
                LIMIT 1),
               IDAS.status,
               (SELECT cast (
                          initcap (
                                trim (coalesce (PN.lastname, ''))
                             || ' '
                             || trim (coalesce (PN.suffix, ''))
                             || ', '
                             || trim (coalesce (PN.firstname, '')))
                             AS CHARACTER VARYING)
                 FROM Person AS PN
                WHERE PN.personid = IDAS.focuspersonid)
                  AS youthname,
               (SELECT PN.cjamspid
                  FROM Person AS PN
                 WHERE PN.personid = IDAS.focuspersonid)
                  AS cjamspid
          FROM IntakeDAStaging IDAS
               INNER JOIN IntakeDAStatus IDS
                  ON     IDAS.intakenumber = IDS.intakenumber
                     AND IDAS.activeflag = 1
                     AND IDS.activeflag = 1 AND IDS.teamtypekey = 'CW'
         WHERE     IDAS.intakenumber LIKE intakeno || '%'
               AND IDAS.teamtypekey = 'CW'
               AND IDAS.intakeuser = v_UserSID
               AND IDAS.insertedby = v_UserSID
               AND CASE
                      WHEN LOWER (v_status) = 'pending'
                      THEN
                         IDAS.status = v_status
                      WHEN lower (v_status) = 'approved'
                      THEN
                         IDAS.status IN ('Complete', 'Closed')
                   END
      ORDER BY (CASE sortorder
                   WHEN 'asc'
                   THEN
                      CASE sortcolumn
                         WHEN 'receiveddate'
                         THEN
                            CAST (IDAS.TimeRecieved AS CHARACTER VARYING)
                         WHEN 'updateddate'
                         THEN
                            CAST (IDAS.updatedon AS CHARACTER VARYING)
                         ELSE
                            IDAS.intakenumber
                      END
                END) ASC,
               (CASE sortorder
                   WHEN 'desc'
                   THEN
                      CASE sortcolumn
                         WHEN 'receiveddate'
                         THEN
                            CAST (IDAS.TimeRecieved AS CHARACTER VARYING)
                         WHEN 'updateddate'
                         THEN
                            CAST (IDAS.updatedon AS CHARACTER VARYING)
                         ELSE
                            IDAS.intakenumber
                      END
                END) DESC
         LIMIT pagesize
        OFFSET v_pageoffset;
END;
$$