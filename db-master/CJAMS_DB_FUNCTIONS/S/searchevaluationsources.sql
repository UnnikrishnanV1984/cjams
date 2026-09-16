CREATE OR REPLACE FUNCTION cjams.searchevaluationsources (
   IN searchkey                   CHARACTER VARYING,
   IN evalsrcagencykey            CHARACTER VARYING,
   IN evalsourceagencyconfigkey   CHARACTER VARYING)
   RETURNS TABLE
           (
              totalcount             BIGINT,
              evaluationsourceid     uuid,
              evaluationsourcekey    CHARACTER VARYING,
              title                  CHARACTER VARYING,
              badgeno                CHARACTER VARYING,
              lastname               CHARACTER VARYING,
              firstname              CHARACTER VARYING,
              streetno               CHARACTER VARYING,
              street1                CHARACTER VARYING,
              street2                CHARACTER VARYING
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
   v_searchkey                CHARACTER VARYING = NULL;
DECLARE v_evalsrcagencykey         CHARACTER VARYING;
DECLARE v_evalsrcagencyconfigkey   CHARACTER VARYING;
BEGIN
   v_searchkey := searchkey;
   v_evalsrcagencykey = evalsrcagencykey;
   v_evalsrcagencyconfigkey = evalsourceagencyconfigkey;
   -- Search for batchid / lastname / first name

   RETURN QUERY
        SELECT count (1) OVER () totalcount,
               es.evaluationsourceid,
               es.evaluationsourcekey,
               es.title,
               es.badgeno,
               es.lastname,
               es.firstname,
               es.streetno,
               es.street1,
               es.street2
          FROM Evaluationsource es
         WHERE     (   CASE
                          WHEN v_searchkey IS NOT NULL
                          THEN
                             (es.badgeno ILIKE
                                 '%' || v_searchkey || '%')
                          ELSE
                             TRUE
                       END
                    OR CASE
                          WHEN v_searchkey IS NOT NULL
                          THEN
                             (es.lastname ILIKE
                                 '%' || v_searchkey || '%')
                          ELSE
                             TRUE
                       END
                    OR CASE
                          WHEN v_searchkey IS NOT NULL
                          THEN
                             (es.firstname ILIKE
                                 '%' || v_searchkey || '%')
                          ELSE
                             TRUE
                       END)
               --And es.evaluationsourceagencykey = v_evalsrcagencykey And es.activeflag = 1
               AND es.sourceagencyconfigkey = v_evalsrcagencyconfigkey
               AND es.activeflag = 1
      ORDER BY es.title,
               es.badgeno,
               es.lastname,
               es.firstname,
               es.streetno,
               es.street1,
               es.street2;
END;
$$
