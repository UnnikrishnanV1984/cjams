CREATE OR REPLACE FUNCTION cjams.opencasesummaryreport (
   IN i_startdate    TIMESTAMP WITHOUT TIME ZONE,
   IN i_enddate      TIMESTAMP WITHOUT TIME ZONE,
   IN i_areacode     CHARACTER VARYING,
   IN p_pagesize     INTEGER,
   IN p_pageoffset   INTEGER,
   IN p_nolimit      BOOLEAN)
   RETURNS TABLE
           (
              reccnt          BIGINT,
              todaydate       CHARACTER VARYING,
              account_area    CHARACTER VARYING,
              opencases       BIGINT,
              balamount       NUMERIC,
              formalcnt       BIGINT,
              informalcnt     BIGINT
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
        SELECT count (*) OVER ()
                  AS reccnt,
               CAST (to_char (now (), 'MM/DD/YYYY') AS CHARACTER VARYING)
                  AS todaydate,
               CAST (irp.accountarea AS CHARACTER VARYING)
                  AS account_area,
               count (ir.restitutionno)
                  AS opencases,
               sum (
                    (  coalesce (ir.payment, 0)
                     - coalesce (ir.waivedamount, 0)
                     + coalesce (ir.additionalamount, 0))
                  - coalesce (ir.paidamount, 0))
                  balamount,
               sum (CASE WHEN ir.restitutiontype = 'court' THEN 1 ELSE 0 END)
                  AS formalcnt,
               sum (CASE WHEN ir.restitutiontype = 'intake' THEN 1 ELSE 0 END)
                  AS informalcnt
          FROM intakeserreqrestitution ir
               LEFT JOIN person p
                  ON p.personid = ir.youthpersonid AND p.activeflag = 1
               JOIN intakeserreqrestitutionpayment irp
                  ON     irp.intakeserreqrestitutionid =
                         ir.intakeserreqrestitutionid
                     AND irp.activeflag = 1
               JOIN restitutionpaymentflatfilecontent rpff
                  ON     irp.restitutionpaymentflatfilecontentid =
                         rpff.restitutionpaymentflatfilecontentid
                     AND rpff.activeflag = 1
         WHERE     ir.status = 'Active'
               AND ir.insertedon BETWEEN i_startdate AND i_enddate
               AND CASE
                      WHEN i_areacode IS NOT NULL
                      THEN
                         irp.accountarea = i_areacode
                      ELSE
                         TRUE
                   END
      GROUP BY todaydate, accountarea
         LIMIT (CASE WHEN p_nolimit IS FALSE THEN p_pagesize ELSE NULL END)
        OFFSET (CASE WHEN p_nolimit IS FALSE THEN p_pageoffset ELSE NULL END);
END;
$$