CREATE OR REPLACE FUNCTION cjams.getuserprofile ()
   RETURNS TABLE
           (
              securityusersid    CHARACTER VARYING,
              firstname          CHARACTER VARYING,
              lastname           CHARACTER VARYING,
              displayname        CHARACTER VARYING
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
        SELECT up.securityusersid,
               up.firstname,
               up.lastname,
               up.displayname
          FROM userprofile up
               INNER JOIN muser mu
                  ON     up.securityusersid = mu.securityusersid
                     AND up.activeflag = 1
                     AND mu.activeflag = 1
               INNER JOIN rolemapping rm
                  ON     mu.id::CHARACTER VARYING = rm.principalid
                     AND rm.activeflag = 1
               INNER JOIN role r ON r.id = rm.roleid AND r.activeflag = 1
         WHERE r.roletypekey IN ('JSCW', 'JSDU', 'JSADU')
      ORDER BY displayname;
END;
$$