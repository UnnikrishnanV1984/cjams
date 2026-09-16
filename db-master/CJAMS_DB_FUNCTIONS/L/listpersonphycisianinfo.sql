CREATE OR REPLACE FUNCTION cjams.listpersonphycisianinfo (
   IN personid     uuid,
   IN pagenumber   BIGINT,
   IN pagesize     BIGINT,
   IN sortcolumn   CHARACTER VARYING,
   IN sortorder    CHARACTER VARYING,
   IN v_nolimit    BOOLEAN DEFAULT FALSE)
   RETURNS TABLE
           (
              totalcount                       BIGINT,
              personphycisianinfoid            uuid,
              isprimaryphycisian               BOOLEAN,
              "name"                           CHARACTER VARYING,
              facility                         CHARACTER VARYING,
              phone                            CHARACTER VARYING,
              email                            CHARACTER VARYING,
              address1                         CHARACTER VARYING,
              address2                         CHARACTER VARYING,
              city                             CHARACTER VARYING,
              state                            CHARACTER VARYING,
              countyid                         uuid,
              countyname                       CHARACTER VARYING,
              zip                              CHARACTER VARYING,
              startdate                        TIMESTAMP WITHOUT TIME ZONE,
              enddate                          TIMESTAMP WITHOUT TIME ZONE,
              physicianspecialtytypekey        CHARACTER VARYING,
              physicianspecialtydescription    CHARACTER VARYING,
              createddate                      TIMESTAMP WITHOUT TIME ZONE
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
   v_personid     uuid;
BEGIN
   v_pagenumber := pagenumber - 1;
   v_pageoffset = v_pagenumber * pagesize;
   v_personid := personid;


   IF COALESCE (pagesize, 0) < 1
   THEN
      pagesize := 10;
   END IF;

   IF COALESCE (pagenumber, 0) < 1
   THEN
      pagenumber := 1;
   END IF;


   RETURN QUERY
        SELECT COUNT (1) OVER (),
               PPI.personphycisianinfoid,
               PPI.isprimaryphycisian,
               PPI.name,
               PPI.facility,
               PPI.phone,
               PPI.email,
               PPI.address1,
               PPI.address2,
               PPI.city,
               PPI.state,
               PPI.countyid,
               (SELECT c.countyname
                  FROM county AS c
                 WHERE c.countyid = PPI.countyid AND c.activeflag = 1
                 LIMIT 1) AS countyname,
               PPI.zip,
               PPI.startdate,
               PPI.enddate,
               PPI.physicianspecialtytypekey,
               (SELECT PST.description
                 FROM physicianspecialtytype AS PST
                WHERE     PST.physicianspecialtytypekey =
                          PPI.physicianspecialtytypekey
                      AND PST.activeflag = 1
                LIMIT 1) AS physicianspecialtydescription,
               PPI.insertedon
          FROM personphycisianinfo AS PPI
         WHERE PPI.personid = v_personid AND PPI.activeflag = 1
      ORDER BY (CASE sortorder
                   WHEN 'asc'
                   THEN
                      CASE sortcolumn
                         WHEN 'createddate'
                         THEN
                            CAST (PPI.insertedon AS CHARACTER VARYING)
                         WHEN 'name'
                         THEN
                            CAST (PPI.name AS CHARACTER VARYING)
                         ELSE
                            CAST (PPI.insertedon AS CHARACTER VARYING)
                      END
                END) ASC,
               (CASE sortorder
                   WHEN 'desc'
                   THEN
                      CASE sortcolumn
                         WHEN 'createddate'
                         THEN
                            CAST (PPI.insertedon AS CHARACTER VARYING)
                         WHEN 'name'
                         THEN
                            CAST (PPI.name AS CHARACTER VARYING)
                         ELSE
                            CAST (PPI.insertedon AS CHARACTER VARYING)
                      END
                END) DESC
         LIMIT CASE WHEN v_nolimit = FALSE THEN pagesize END
        OFFSET CASE WHEN v_nolimit = FALSE THEN v_pageoffset END;
END;
$$