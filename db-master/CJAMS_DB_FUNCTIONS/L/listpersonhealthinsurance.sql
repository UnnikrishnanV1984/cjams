CREATE OR REPLACE FUNCTION cjams.listpersonhealthinsurance (
   IN personid     uuid,
   IN pagenumber   BIGINT,
   IN pagesize     BIGINT,
   IN sortcolumn   CHARACTER VARYING,
   IN sortorder    CHARACTER VARYING,
   IN v_nolimit    BOOLEAN DEFAULT FALSE)
   RETURNS TABLE
           (
              totalcount                     BIGINT,
              personhealthinsuranceid        uuid,
              ismedicaidmedicare             BOOLEAN,
              policyholdername               CHARACTER VARYING,
              address1                       CHARACTER VARYING,
              address2                       CHARACTER VARYING,
              city                           CHARACTER VARYING,
              state                          CHARACTER VARYING,
              countyid                       uuid,
              countyname                     CHARACTER VARYING,
              zip                            CHARACTER VARYING,
              providerphone                  CHARACTER VARYING,
              patientpolicyholderrelation    CHARACTER VARYING,
              policyname                     CHARACTER VARYING,
              groupnumber                    CHARACTER VARYING,
              providertypeother              CHARACTER VARYING,
              effectivepolicydate            TIMESTAMP WITHOUT TIME ZONE,
              expirationdate                 TIMESTAMP WITHOUT TIME ZONE,
              insurancetype                  CHARACTER VARYING,
              providertype                   CHARACTER VARYING,
              medicalinsuranceprovider       CHARACTER VARYING,
              createddate                    TIMESTAMP WITHOUT TIME ZONE
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
               PHI.personhealthinsuranceid,
               PHI.ismedicaidmedicare,
               PHI.policyholdername,
               PHI.address1,
               PHI.address2,
               PHI.city,
               PHI.state,
               PHI.countyid,
               (SELECT c.countyname
                  FROM county AS c
                 WHERE c.countyid = PHI.countyid AND c.activeflag = 1
                 LIMIT 1) AS countyname,
               PHI.zip,
               PHI.providerphone,
               PHI.patientpolicyholderrelation,
               PHI.policyname,
               PHI.groupnumber,
               PHI.providertypeother,
               PHI.effectivedate,
               PHI.expirationdate,
               PHI.insurancetype,
               PHI.providertype,
               PHI.medicalinsuranceprovider,
               PHI.insertedon
          FROM personhealthinsurance AS PHI
         WHERE PHI.personid = v_personid AND PHI.activeflag = 1
      ORDER BY (CASE sortorder
                   WHEN 'asc'
                   THEN
                      CASE sortcolumn
                         WHEN 'createddate'
                         THEN
                            CAST (PHI.insertedon AS CHARACTER VARYING)
                         WHEN 'policyholdername'
                         THEN
                            CAST (PHI.policyholdername AS CHARACTER VARYING)
                         ELSE
                            CAST (PHI.insertedon AS CHARACTER VARYING)
                      END
                END) ASC,
               (CASE sortorder
                   WHEN 'desc'
                   THEN
                      CASE sortcolumn
                         WHEN 'createddate'
                         THEN
                            CAST (PHI.insertedon AS CHARACTER VARYING)
                         WHEN 'policyholdername'
                         THEN
                            CAST (PHI.policyholdername AS CHARACTER VARYING)
                         ELSE
                            CAST (PHI.insertedon AS CHARACTER VARYING)
                      END
                END) DESC
         LIMIT CASE WHEN v_nolimit = FALSE THEN pagesize END
        OFFSET CASE WHEN v_nolimit = FALSE THEN v_pageoffset END;
END;
$$