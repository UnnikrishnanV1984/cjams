DROP FUNCTION IF EXISTS cjams.sp_cw_java_batch_email_notification(character varying);

CREATE OR REPLACE FUNCTION cjams.sp_cw_java_batch_email_notification(as_notification_type character varying)
RETURNS TABLE(is_success character varying, msg character varying)
LANGUAGE plpgsql
AS $function$
/* 
-- 04/09/2026 - Raghavendra Puli - CIDM-11333 - Email notification batch job.
*/
DECLARE
  v_norm_type character varying;
  v_dummy text;
BEGIN
  v_norm_type := lower(coalesce(as_notification_type, ''));

  IF v_norm_type IN ('java-batch-email-notification', 'all') THEN
    SELECT cjams.sp_cw_case_closure_notifications() INTO v_dummy; 
  END IF;
  
  RETURN QUERY
  SELECT 'Y'::character varying, ('SUCCESS: sp_cw_java_batch_email_notification - ' || as_notification_type)::character varying;
  
  EXCEPTION
    WHEN OTHERS THEN
      RAISE NOTICE 'Error in sp_cw_java_batch_email_notification: %', SQLERRM;
      RETURN QUERY
      SELECT 'N'::character varying, ('FAILED: ' || SQLERRM)::character varying;

  END;
$function$;