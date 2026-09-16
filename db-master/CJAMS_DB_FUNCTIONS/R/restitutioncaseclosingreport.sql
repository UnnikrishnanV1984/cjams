CREATE OR REPLACE FUNCTION cjams.restitutioncaseclosingreport (
   IN i_paystartdate   TIMESTAMP WITHOUT TIME ZONE,
   IN i_payenddate     TIMESTAMP WITHOUT TIME ZONE,
   IN i_accountarea    CHARACTER VARYING,
   IN p_pagesize       INTEGER,
   IN p_pageoffset     INTEGER,
   IN p_nolimit        BOOLEAN)
   RETURNS TABLE (account_area CHARACTER VARYING, details json)
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
        SELECT CAST (irp.accountarea AS CHARACTER VARYING) AS account_area,
               json_agg (
                  json_build_object (
                     'youthname',
                     p.firstname || ' ' || p.lastname,
                     'payaccount',
                     ir.restitutionno,
                     'cw_name',
                     cw.cwname,
                     'liableperson_name',
                     (SELECT DISTINCT firstname || ',' || lastname
                        FROM person
                       WHERE personid = ir.liablepersonid))) AS details
          FROM intakeserreqrestitution ir
               LEFT JOIN person p
                  ON p.personid = ir.youthpersonid AND p.activeflag = 1
               LEFT JOIN intakeserreqrestitutionpayment irp
                  ON     irp.intakeserreqrestitutionid =
                         ir.intakeserreqrestitutionid
                     AND irp.activeflag = 1
               LEFT JOIN intakeservicerequest INTSR
                  ON     INTSR.intakenumber = ir.intakenumber
                     AND INTSR.activeflag = 1
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
         WHERE (    ir.status = 'Closed'
                AND ir.updatedon BETWEEN i_paystartdate AND i_payenddate
                AND CASE
                       WHEN i_accountarea IS NOT NULL
                       THEN
                          irp.accountarea = i_accountarea
                       ELSE
                          TRUE
                    END)
      GROUP BY accountarea
         LIMIT (CASE WHEN p_nolimit IS FALSE THEN p_pagesize ELSE NULL END)
        OFFSET (CASE WHEN p_nolimit IS FALSE THEN p_pageoffset ELSE NULL END);
END;
$$
