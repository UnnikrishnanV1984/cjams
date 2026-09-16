CREATE OR REPLACE FUNCTION cjams.paymentmatchesreport (
   IN i_paystartdate   TIMESTAMP WITHOUT TIME ZONE,
   IN i_payenddate     TIMESTAMP WITHOUT TIME ZONE,
   IN i_accountarea    CHARACTER VARYING,
   IN p_pagesize       INTEGER,
   IN p_pageoffset     INTEGER,
   IN p_nolimit        BOOLEAN)
   RETURNS TABLE
           (
              overallcnt      BIGINT,
              jsoncount       BIGINT,
              account_area    CHARACTER VARYING,
              details         json
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
        SELECT count (*) OVER () AS overallcnt,
               count (*) AS jsoncount,
               CAST (irp.accountarea AS CHARACTER VARYING) AS account_area,
               json_agg (
                  json_build_object ('payno',
                                     irp.paymentnumber,
                                     'accountno',
                                     ir.restitutionno,
                                     'paydate',
                                     to_char (irp.paymentdate, 'MM/DD/YYYY'),
                                     'allocatedamount',
                                     irp.allocatedamount,
                                     'payamount',
                                     irp.paymentamount,
                                     'vendor_id',
                                     (SELECT cjamspid
                                        FROM person
                                       WHERE personid = ir.victimpersonid),
                                     'balance',
                                     rpff.balanceamount,
                                     'youthname',
                                     p.firstname || ' ' || p.lastname,
                                     'cw_name',
                                     cw.cwname)) AS details
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
               LEFT JOIN
               (SELECT objectid, up.fullname AS cwname
                  FROM routing
                       JOIN userprofile up
                          ON     routing.tosecurityusersid = up.securityusersid
                             AND up.activeflag = 1
                             AND routing.toroleid = 'JSCW'
                       LEFT JOIN userprofileaddress upa
                          ON     routing.tosecurityusersid =
                                 upa.securityusersid
                             AND upa.activeflag = 1
                       LEFT JOIN userprofilephonenumber upp
                          ON     routing.tosecurityusersid =
                                 upp.securityusersid
                             AND upp.activeflag = 1
                             AND upp.userprofiletypekey = 'office') cw
                  ON cast (INTSR.intakeserviceid AS CHARACTER VARYING) =
                     cw.objectid
         WHERE     (    irp.paymentdate >= i_paystartdate
                    AND irp.paymentdate <= i_payenddate)
               AND CASE
                      WHEN i_accountarea IS NOT NULL
                      THEN
                         irp.accountarea = i_accountarea
                      ELSE
                         TRUE
                   END
      GROUP BY account_area
         LIMIT (CASE WHEN p_nolimit IS FALSE THEN p_pagesize ELSE NULL END)
        OFFSET (CASE WHEN p_nolimit IS FALSE THEN p_pageoffset ELSE NULL END);
END;
$$