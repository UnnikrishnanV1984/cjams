CREATE OR REPLACE FUNCTION cjams.getsatisfactionnotice (
   IN p_intakenumber   CHARACTER VARYING)
   RETURNS TABLE
           (
              youthname      CHARACTER VARYING,
              victim         CHARACTER VARYING,
              county         CHARACTER VARYING,
              casenumber     CHARACTER VARYING,
              amount         NUMERIC,
              paymentdate    CHARACTER VARYING,
              lasthearing    CHARACTER VARYING
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
      SELECT cast (yp.firstname || ' ' || yp.lastname AS CHARACTER VARYING)
                AS youthname,
             cast (vp.firstname || ' ' || vp.lastname AS CHARACTER VARYING)
                AS victimname,
             (SELECT countyname
                FROM county
               WHERE county.countyid = isr.countyid)
                AS county,
             isrq.servicerequestnumber,
             isr.payment,
             cast (
                to_char (irp.paymentdate, 'MM/DD/YYYY') AS CHARACTER VARYING)
                AS paymentdate,
             cast (
                to_char (ch.lasthearing, 'MM/DD/YYYY') AS CHARACTER VARYING)
                AS lasthearing
        FROM intakeservicerequest isrq
             LEFT JOIN intakeserreqrestitution isr
                ON isr.intakenumber = isrq.intakenumber
             LEFT JOIN (SELECT p.personid,
                               p.firstname,
                               p.lastname,
                               activeflag
                          FROM person p) yp
                ON yp.personid = isr.youthpersonid AND yp.activeflag = 1
             LEFT JOIN (SELECT p.personid,
                               p.firstname,
                               p.lastname,
                               activeflag
                          FROM person p) vp
                ON vp.personid = isr.victimpersonid AND vp.activeflag = 1
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
             LEFT JOIN
             (  SELECT max (hearingdatetime) "lasthearing", intakeserviceid
                  FROM intakeservicerequestcourthearing
              GROUP BY intakeserviceid) ch
                ON ch.intakeserviceid = isrq.intakeserviceid
       WHERE isrq.intakenumber = p_intakenumber AND isr.status = 'Closed';
END;
$$