CREATE OR REPLACE FUNCTION cjams.documenttemplaterolewiselist (
   IN v_roletypekey       CHARACTER VARYING,
   IN v_intakenumber      CHARACTER VARYING,
   IN v_intakeserviceid   uuid,
   IN v_restitutionno     CHARACTER VARYING)
   RETURNS TABLE
           (
              title                  CHARACTER VARYING,
              inputfields            TEXT,
              headertemplatehtml     CHARACTER VARYING,
              isheaderrequired       BOOLEAN,
              documenttemplatekey    CHARACTER VARYING,
              "generatedBy"          CHARACTER VARYING,
              "generatedDateTime"    TIMESTAMP WITHOUT TIME ZONE,
              documentpath           CHARACTER VARYING,
              beforesubmit           BOOLEAN
           )
   LANGUAGE 'plpgsql'
   VOLATILE
   NOT LEAKPROOF
   SECURITY INVOKER
   PARALLEL UNSAFE
   ROWS 10000
AS
$$
DECLARE
   v_beforesubmit   BOOLEAN;

   v_res_type       CHARACTER VARYING;
   v_res_status     CHARACTER VARYING;
   v_res_cls        CHARACTER VARYING;
BEGIN
   SELECT isr.restitutiontype, isr.status
     INTO v_res_type, v_res_status
     FROM intakeserreqrestitution isr
    WHERE isr.restitutionno = v_restitutionno AND isr.activeflag = 1;

   IF v_res_status = 'Closed'
   THEN
      v_res_cls := 'Closed';
   ELSE
      v_res_cls := NULL;
   END IF;

   SELECT (count (intakenumber) = 0)
     INTO v_beforesubmit
     FROM intakeservicerequest
    WHERE intakenumber = v_intakenumber;

   RETURN QUERY
      (SELECT DT.documentname,
              (SELECT string_agg (inputfield, ',')
                   FROM documenttemplateinputfieldsconfig DTIFC
                  WHERE     DTIFC.roletypekey = v_roletypekey
                        AND DTIFC.documenttemplatekey =
                            DTRTC.documenttemplatekey
               GROUP BY DTIFC.documenttemplatekey) AS inputfields,
              DT.headertemplatehtml,
              DT.isheaderrequired,
              DTRTC.documenttemplatekey,
              (SELECT UP.fullname
                   FROM evaluationdocument AS ED
                        JOIN userprofile UP
                           ON     UP.securityusersid = ED.insertedby
                              AND UP.activeflag = 1
                  WHERE     ED.documenttemplatekey = DT.documenttemplatekey
                        AND ED.activeflag = 1
                        AND (   ED.intakenumber = v_intakenumber
                             OR ED.intakeserviceid = v_intakeserviceid)
               ORDER BY versionno DESC
                  LIMIT 1) AS generatename,
              (SELECT EDOC.insertedon
                   FROM evaluationdocument AS EDOC
                  WHERE     EDOC.documenttemplatekey = DT.documenttemplatekey
                        AND EDOC.activeflag = 1
                        AND (   EDOC.intakenumber = v_intakenumber
                             OR EDOC.intakeserviceid = v_intakeserviceid)
               ORDER BY versionno DESC
                  LIMIT 1) AS generatedate,
              (SELECT EDOCP.documentpath
                   FROM evaluationdocument AS EDOCP
                  WHERE     EDOCP.documenttemplatekey = DT.documenttemplatekey
                        AND EDOCP.activeflag = 1
                        AND (   EDOCP.intakenumber = v_intakenumber
                             OR EDOCP.intakeserviceid = v_intakeserviceid)
               ORDER BY versionno DESC
                  LIMIT 1) AS documentpath,
              v_beforesubmit AS beforesubmit
         FROM documenttemplate AS DT
              JOIN documenttemplateroletypeconfig AS DTRTC
                 ON     DTRTC.documenttemplatekey = DT.documenttemplatekey
                    AND DTRTC.activeflag = 1
              JOIN intakedocclassification DTC
                 ON DTC.documenttemplatekey = DT.documenttemplatekey
        WHERE     DTC.roletype_key = v_roletypekey
              AND (   DTC.restitution_status = v_res_status
                   OR DTC.restitution_status IS NULL)
              AND (   DTC.restitution_type IN ('Both', v_res_type, v_res_cls)
                   OR DTC.restitution_type IS NULL)
              AND DTRTC.roletypekey = v_roletypekey
              AND DT.activeflag = 1
              AND DTC.activeflag = 1
              AND (   v_intakeserviceid IS NOT NULL
                   OR v_beforesubmit = FALSE
                   OR DTRTC.beforesubmit = TRUE));
END;
$$