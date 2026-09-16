CREATE OR REPLACE FUNCTION cjams.restitutionsummaryreport (
   IN i_paystartdate   TIMESTAMP WITHOUT TIME ZONE,
   IN i_payenddate     TIMESTAMP WITHOUT TIME ZONE,
   IN p_pagesize       INTEGER,
   IN p_pageoffset     INTEGER,
   IN p_nolimit        BOOLEAN)
   RETURNS TABLE
           (
              totalcases                BIGINT,
              totalrestitutionamount    NUMERIC,
              totalbalance              NUMERIC,
              cw_name                   CHARACTER VARYING,
              details                   json
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
        SELECT count (*) OVER () AS totalcases,
               sum (irp.paymentamount) AS totalrestitutionamount,
               sum (
                    (  coalesce (ir.payment, 0)
                     - coalesce (ir.waivedamount, 0)
                     + coalesce (ir.additionalamount, 0))
                  - coalesce (ir.paidamount, 0)) AS totalbalance,
               up.fullname AS cw_name,
               json_agg (
                  json_build_object (
                     'youthname',
                     p.firstname || ' ' || p.lastname,
                     'youthid',
                     p.cjamspid,
                     'payaccount',
                     irp.paymentnumber,
                     'payamount',
                     irp.paymentamount,
                     'balance',
                     balanceamount,
                     'startdate',
                     to_char (ir.paymentstartdate, 'MM/DD/YYYY'),
                     'paydate',
                     to_char (irp.paymentdate, 'MM/DD/YYYY'),
                     'ccuapprovedate',
                     to_char (ir.ccuapprovedate, 'MM/DD/YYYY'),
                     'judgementdate',
                     to_char (insca.courtorderdatetime, 'MM/DD/YYYY'))) AS details
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
               LEFT JOIN intakeservicerequestcourtaction insca
                  ON insca.intakeservicerequestid = INTSR.intakeserviceid
               JOIN routing r
                  ON cast (INTSR.intakeserviceid AS CHARACTER VARYING) =
                     r.objectid
               JOIN userprofile up
                  ON     r.tosecurityusersid = up.securityusersid
                     AND up.activeflag = 1
                     AND r.toroleid = 'JSCW'
               LEFT JOIN userprofileaddress upa
                  ON     r.tosecurityusersid = upa.securityusersid
                     AND upa.activeflag = 1
               LEFT JOIN userprofilephonenumber upp
                  ON     r.tosecurityusersid = upp.securityusersid
                     AND upp.activeflag = 1
                     AND upp.userprofiletypekey = 'office'
         WHERE     ir.paymentstartdate >= i_paystartdate
               AND ir.paymentstartdate <= i_payenddate
      GROUP BY up.fullname
         LIMIT (CASE WHEN p_nolimit IS FALSE THEN p_pagesize ELSE NULL END)
        OFFSET (CASE WHEN p_nolimit IS FALSE THEN p_pageoffset ELSE NULL END);
END;
$$