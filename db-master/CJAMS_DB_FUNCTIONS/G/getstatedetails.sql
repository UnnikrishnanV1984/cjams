CREATE OR REPLACE FUNCTION cjams.getstatedetails (IN v_zipcode INTEGER)
   RETURNS TABLE
           (
              countycode    CHARACTER VARYING,
              countyname    CHARACTER VARYING,
              citycode      CHARACTER VARYING,
              cityname      CHARACTER VARYING,
              statename     CHARACTER VARYING,
              stateabbr     CHARACTER VARYING
           )
   LANGUAGE 'plpgsql'
   VOLATILE
   NOT LEAKPROOF
   SECURITY INVOKER
   PARALLEL UNSAFE
   ROWS 1000
AS
$$
BEGIN
   RETURN QUERY
      SELECT co.countycode,
             co.countyname,
             cy.citycode,
             cy.town,
             st.statename,
             st.stateabbr
        FROM county co
             INNER JOIN city cy
                ON co.countycode = cy.county AND co.activeflag = 1
             INNER JOIN zipcode zc
                ON zc.citycode = cy.citycode AND zc.activeflag = 1
             INNER JOIN state st
                ON st.stateabbr = co.state AND st.activeflag = 1
       WHERE     co.activeflag = 1
             AND (zc.zipcd::CHARACTER VARYING) ILIKE
                    v_zipcode || '%';
END;
$$