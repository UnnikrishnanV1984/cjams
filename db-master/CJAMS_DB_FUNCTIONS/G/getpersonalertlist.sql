CREATE OR REPLACE FUNCTION cjams.getpersonalertlist (
   IN v_personid         uuid,
   IN pagenumber         BIGINT,
   IN pagesize           BIGINT,
   IN v_activeflag       INTEGER,
   IN v_securityuserid   CHARACTER VARYING,
   IN v_nolimit          BOOLEAN DEFAULT FALSE)
   RETURNS TABLE
           (
              totalcount       BIGINT,
              updatedpid       BIGINT,
              createdpid       BIGINT,
              updatedname      TEXT,
              createdname      TEXT,
              alertid          uuid,
              alerttype        CHARACTER VARYING,
              status           CHARACTER VARYING,
              startdatetime    TIMESTAMP WITHOUT TIME ZONE,
              enddatetime      TIMESTAMP WITHOUT TIME ZONE,
              notes            TEXT,
              personalertid    uuid,
              createdid        CHARACTER VARYING,
              updatedid        CHARACTER VARYING,
              description      CHARACTER VARYING
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
   IF COALESCE (pagesize, 0) < 1
   THEN
      pagesize := 10;
   END IF;

   IF COALESCE (pagenumber, 0) < 1
   THEN
      pagenumber := 1;
   END IF;

   v_pagenumber := pagenumber - 1;
   v_pageoffset = v_pagenumber * pagesize;

   RETURN QUERY
        SELECT count (1) OVER () AS totalcount,
               up.cjamspid AS updatedpid,
               up1.cjamspid AS createdpid,
               CONCAT (up.firstname, ' ', up.lastname) AS updatedname,
               CONCAT (up1.firstname, ' ', up1.lastname) AS createdname,
               pa.alertid,
               pa.alerttype,
               pa.status,
               pa.startdatetime,
               pa.enddatetime,
               pa.notes,
               pa.personalertid,
               pa.insertedby AS createdid,
               pa.updatedby AS updatedid,
               pat.typedescription AS description
          FROM personalert pa
               LEFT JOIN personalerttype pat
                  ON pa.alerttype = pat.personalerttypekey
               LEFT JOIN person p ON p.personid = pa.personid
               LEFT JOIN userprofile up ON pa.updatedby = up.securityusersid
               LEFT JOIN userprofile up1 ON pa.insertedby = up1.securityusersid
         WHERE     pa.personid = v_personid
               AND CASE
                      WHEN pa.status = 'Active' THEN pa.activeflag = 1
                      WHEN pa.status = 'Inactive' THEN pa.activeflag = 0
                   END
      ORDER BY pa.insertedon
         LIMIT CASE WHEN v_nolimit = FALSE THEN pagesize END
        OFFSET CASE WHEN v_nolimit = FALSE THEN v_pageoffset END;
END;
$$