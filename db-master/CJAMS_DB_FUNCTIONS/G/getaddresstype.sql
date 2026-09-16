CREATE OR REPLACE FUNCTION cjams.getaddresstype (
   IN securityusersidval   CHARACTER VARYING,
   IN cjamspidval          BIGINT)
   RETURNS TABLE
           (
              userprofileaddressid         uuid,
              userprofileaddresstypekey    CHARACTER VARYING,
              address                      CHARACTER VARYING,
              zipcode                      CHARACTER VARYING,
              city                         CHARACTER VARYING,
              state                        CHARACTER VARYING,
              country                      CHARACTER VARYING,
              county                       CHARACTER VARYING
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
      SELECT upa.userprofileaddressid,
             upat.userprofileaddresstypekey,
             upa.address,
             upa.zipcode,
             upa.city,
             upa.state,
             upa.country,
             upa.county
        FROM userprofileaddress upa
             INNER JOIN userprofileaddresstype upat
                ON     upat.userprofileaddresstypekey =
                       upa.userprofileaddresstypekey
                   AND upa.activeflag = 1
             INNER JOIN userprofile up
                ON     up.securityusersid = upa.securityusersid
                   AND up.activeflag = 1
       WHERE     (cjamspidval IS NULL OR up.cjamspid = cjamspidval)
             AND (   securityusersidval IS NULL
                  OR up.securityusersid = securityusersidval);
END;
$$