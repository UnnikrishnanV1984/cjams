CREATE OR REPLACE FUNCTION cjams.getpaidsatifiedmemo (
   IN p_intakenumber    CHARACTER VARYING,
   IN p_restitutionno   INTEGER)
   RETURNS TABLE
           (
              rtcdcoordinator       CHARACTER VARYING,
              youthname             CHARACTER VARYING,
              courtactiontypekey    CHARACTER VARYING,
              payment               NUMERIC,
              dispositioncode       CHARACTER VARYING,
              description           CHARACTER VARYING,
              balanceamount         NUMERIC,
              intakenumber          CHARACTER VARYING,
              intakeserviceid       uuid
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
      SELECT irp.insertedby
                "rtcdcoordinator",
             cast (yp.firstname || ' ' || yp.lastname AS CHARACTER VARYING)
                "youthname",
             isrct.courtactiontypekey,
             isr.payment,
             srd.dispositioncode,
             cast (d.description AS CHARACTER VARYING),
             (  (  coalesce (isr.payment, 0)
                 - coalesce (isr.waivedamount, 0)
                 + coalesce (isr.additionalamount, 0))
              - coalesce (isr.paidamount, 0))
                "balanceamount",
             isrq.intakenumber,
             isrq.intakeserviceid
        FROM intakeservicerequest isrq
             LEFT JOIN intakeserreqrestitution isr
                ON isr.intakenumber = isrq.intakenumber
             LEFT JOIN
             (SELECT p.personid,
                     p.dob,
                     p.firstname,
                     p.lastname,
                     p.cjamspid,
                     extract (YEAR FROM age (current_date, p.dob))"youthage",
                     activeflag
                FROM person p) yp
                ON yp.personid = isr.youthpersonid AND yp.activeflag = 1
             LEFT JOIN
             (  SELECT max (paymentnumber) "paymentnumber",
                       intakeserreqrestitutionid
                  FROM intakeserreqrestitutionpayment
              GROUP BY intakeserreqrestitutionid) isrpl
                ON isrpl.intakeserreqrestitutionid =
                   isr.intakeserreqrestitutionid
             LEFT JOIN intakeserreqrestitutionpayment irp
                ON irp.paymentnumber = isrpl.paymentnumber
             LEFT JOIN restitutionpaymentflatfilecontent rpff
                ON     irp.restitutionpaymentflatfilecontentid =
                       rpff.restitutionpaymentflatfilecontentid
                   AND rpff.activeflag = 1
             LEFT JOIN intakeservicerequestcourtaction isrc
                ON isrc.intakeservicerequestid = isrq.intakeserviceid
             LEFT JOIN intakeservicerequestcourtactiontype isrct
                ON isrct.intakeservicerequestcourtactionid =
                   isrc.intakeservicerequestcourtactionid
             LEFT JOIN intakeservicerequestdispositioncode isrd
                ON isrd.intakeserviceid = isr.intakeserviceid
             LEFT JOIN servicerequesttypeconfigdispositioncode srd
                ON srd.servicerequesttypeconfigiddispostionid =
                   isrd.servicerequesttypeconfigiddispostionid
             LEFT JOIN dispositioncode d
                ON d.dispositioncode = srd.dispositioncode
       WHERE     isrq.intakenumber = p_intakenumber
             AND isr.restitutionno = p_restitutionno
             AND srd.dispositioncode != 'Closed';
END;
$$