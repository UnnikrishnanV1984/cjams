CREATE OR REPLACE FUNCTION cjams.casepaymenthistory (
   IN i_youthnameorrestitutionno   CHARACTER VARYING,
   IN p_pagesize                   INTEGER,
   IN p_pageoffset                 INTEGER,
   IN p_nolimit                    BOOLEAN)
   RETURNS TABLE
           (
              youthname      CHARACTER VARYING,
              youthid        CHARACTER VARYING,
              case_number    CHARACTER VARYING,
              accountno      CHARACTER VARYING,
              amount         NUMERIC,
              victimname     CHARACTER VARYING,
              details        json
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
        SELECT CAST (p.firstname || ' ' || p.lastname AS CHARACTER VARYING)
                  AS youthname,
               CAST (p.cjamspid AS CHARACTER VARYING)
                  AS youthid,
               CAST (INTSR.intakenumber AS CHARACTER VARYING)
                  AS case_number,
               CAST (ir.restitutionno AS CHARACTER VARYING)
                  AS accountno,
               ir.payment
                  AS amount,
               CAST (
                  (SELECT DISTINCT p.firstname || ' ' || p.lastname
                     FROM person p
                    WHERE p.personid = ir.victimpersonid AND p.activeflag = 1)
                     AS CHARACTER VARYING)
                  AS victimname,
               json_agg (
                  json_build_object (
                     'paynumber',
                     irp.paymentnumber,
                     'paydate',
                     irp.paymentdate,
                     'payamount',
                     irp.paymentamount,
                     'status',
                     irp.restitutionstatus,
                     'balance',
                     (  (  coalesce (ir.payment, 0)
                         - coalesce (ir.waivedamount, 0)
                         + coalesce (ir.additionalamount, 0))
                      - coalesce (ir.paidamount, 0))))
                  AS details
          FROM intakeserreqrestitution ir
               JOIN person p
                  ON p.personid = ir.youthpersonid AND p.activeflag = 1
               JOIN intakeserreqrestitutionpayment irp
                  ON     irp.intakeserreqrestitutionid =
                         ir.intakeserreqrestitutionid
                     AND irp.activeflag = 1
               JOIN restitutionpaymentflatfilecontent rpff
                  ON     irp.restitutionpaymentflatfilecontentid =
                         rpff.restitutionpaymentflatfilecontentid
                     AND rpff.activeflag = 1
               JOIN intakeservicerequest INTSR
                  ON ir.intakenumber = INTSR.intakenumber
         WHERE (   p.firstname || ' ' || p.lastname =
                   i_youthnameorrestitutionno
                OR CAST (ir.restitutionno AS CHARACTER VARYING) =
                   i_youthnameorrestitutionno)
      GROUP BY youthname,
               youthid,
               case_number,
               accountno,
               amount,
               victimname
         LIMIT (CASE WHEN p_nolimit IS FALSE THEN p_pagesize ELSE NULL END)
        OFFSET (CASE WHEN p_nolimit IS FALSE THEN p_pageoffset ELSE NULL END);
END;
$$