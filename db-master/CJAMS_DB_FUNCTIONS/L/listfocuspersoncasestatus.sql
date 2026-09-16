CREATE OR REPLACE FUNCTION cjams.listfocuspersoncasestatus (
   IN v_intakeserviceid   uuid,
   IN v_intakenumber      CHARACTER VARYING,
   IN v_personid          uuid,
   IN v_status            CHARACTER VARYING,
   IN pagenumber          BIGINT,
   IN pagesize            BIGINT,
   IN v_nolimit           BOOLEAN DEFAULT FALSE)
   RETURNS TABLE
           (
              totalcount                  BIGINT,
              focuspersoncasestatusid     uuid,
              servicerequestnumber        CHARACTER VARYING,
              personid                    uuid,
              intakeserviceid             uuid,
              intakenumber                CHARACTER VARYING,
              focuspersonstatustypekey    CHARACTER VARYING,
              description                 CHARACTER VARYING,
              status                      CHARACTER VARYING,
              startdate                   DATE,
              enddate                     DATE,
              manualclose                 BOOLEAN,
			  
              effectivedate               TIMESTAMP WITHOUT TIME ZONE,
              opennotes                   TEXT,
              closenotes                  TEXT,
              createdname                 TEXT
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
   v_pageoffset   INT;
   v_pagenumber   INT;
BEGIN
   v_pagenumber := pagenumber - 1;
   v_pageoffset = v_pagenumber * pagesize;

   IF COALESCE (pagesize, 0) < 1
   THEN
      pagesize := 10;
   END IF;

   IF COALESCE (pagenumber, 0) < 1
   THEN
      pagenumber := 1;
   END IF;

   RETURN QUERY
      SELECT count (1) OVER (),
             fp.focuspersoncasestatusid,
             ir.servicerequestnumber,
             fp.personid,
             fp.intakeserviceid,
             fp.intakenumber,
             fp.focuspersonstatustypekey,
             rv.description,
             fp.status,
             fp.startdate,
             fp.enddate,
             CASE
                WHEN     ((SELECT json (ASM.submissiondata) ->>
                                     'panel2907352871485337SupervisionEpisodeEndDate'
                               FROM assessment ASM
                                    JOIN assessmenttemplate ASMT
                                       ON     ASMT.assessmenttemplateid =
                                              ASM.assessmenttemplateid
                                          AND ASMT.name IN ('subsequentScr')
                                          AND ASMT.activeflag = 1
                                          AND ASM.objectid = fp.intakeserviceid
                                          AND ASM.objectname = 'servicerequest'
                           ORDER BY ASM.insertedon::DATE DESC
                              LIMIT 1)::DATE =
                          (SELECT terminationdatetime::DATE
                               FROM intakeservicerequestcourtaction ina
                                    JOIN intakeservicerequestcourthearing inh
                                       ON     inh.intakeservicerequestcourthearingid =
                                              ina.intakeservicerequestcourthearingid
                                          AND inh.hearingtypekey = 'Disp'
                              WHERE ina.intakenumber = fp.intakenumber
                           ORDER BY ina.insertedon::DATE
                              LIMIT 1))
                     AND fp.focuspersonstatustypekey = 'CTS'
                THEN
                   fsk.ismanual = FALSE
                ELSE
                   fsk.ismanual
             END AS manualclose,
             fp.effectivedate,
             fp.opennotes,
             fp.closenotes,
             CONCAT (up.firstname, ' ', up.lastname) AS createdname
        FROM focuspersoncasestatus fp
             LEFT JOIN referencevalues rv
                ON     rv.ref_key = fp.focuspersonstatustypekey
                   AND referencetypeid = 21
             LEFT JOIN intakeservicerequest ir
                ON fp.intakeserviceid = ir.intakeserviceid
             LEFT JOIN focusstatustypekeyconfig fsk
                ON fsk.statustypekey = fp.focuspersonstatustypekey
             JOIN userprofile up ON fp.insertedby = up.securityusersid
       WHERE     (v_personid IS NULL OR fp.personid = v_personid)
             AND (   v_intakeserviceid IS NULL
                  OR fp.intakeserviceid = v_intakeserviceid)
             AND (v_intakenumber IS NULL OR fp.intakenumber = v_intakenumber)
             AND CASE
                    WHEN v_status = 'Open' THEN fp.status = 'Open'
                    WHEN v_status = 'Closed' THEN fp.status = 'Closed'
                    ELSE fp.status IN ('Open', 'Closed')
                 END
       LIMIT CASE WHEN v_nolimit = FALSE THEN pagesize END
      OFFSET CASE WHEN v_nolimit = FALSE THEN v_pageoffset END;
END;
$$