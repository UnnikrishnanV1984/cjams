CREATE OR REPLACE FUNCTION cjams.cdteleconsentagreebs (
   IN i_intakenumber   CHARACTER VARYING)
   RETURNS TABLE (persons TEXT, prepdate CHARACTER VARYING)
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
      (SELECT da.jsondata ->> 'persons' AS persons,
              cast (
                 to_char (rt.insertedon, 'MM/DD/YYYY') AS CHARACTER VARYING) AS prepdate
         FROM intakedastaging da
              LEFT JOIN routing rt
                 ON     da.intakenumber = rt.objectid
                    AND rt.activeflag = 1
                    AND rt.eventcode = 'DWAN'
        WHERE da.intakenumber = i_intakenumber AND da.activeflag = 1
        LIMIT 1);
END;
$$