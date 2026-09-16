DROP FUNCTION getusernotificationcount(character varying,character varying);
 
CREATE OR REPLACE FUNCTION cjams.getusernotificationcount(
      userid character varying, 
      fromsource character varying)
RETURNS TABLE (systemcount bigint, externalcount bigint) 
LANGUAGE plpgsql
AS $function$
---------------------------------------------------------------
-- Revision(s)
-- 09/23/2024 CIDM-9413 Yogeshvar Get User Notifications count external vs system
-- 02/07/2026 - CIDM-11090 -> Filter for last 1 month only for Performance improvement
--------------------------------------------------------------
BEGIN
      IF fromsource = 'list' THEN
            RETURN QUERY
            SELECT count(*) as systemcount from usernotification un
            inner join usernotificationmap unmap on un.usernotificationid = unmap.usernotificationid
            where un.insertedon::date >= current_date - interval '1 months'
            and un.securityusersid = userid and unmap.tosecurityusersid is not null and un.activeflag = 1 
            and un.teamtypekey = 'CW';
      END IF;

      IF fromsource = 'count' THEN
            RETURN QUERY
            SELECT 
            sum(case when un.isexternalentity = false then 1 else 0 end) as systemcount,
            sum(case when un.isexternalentity = true then 1 else 0 end) as externalcount
            from usernotification un
            where un.insertedon::date >= current_date - interval '1 months'
            and (un.isread is null or un.isread = false) and un.securityusersid = userid and un.activeflag = 1
            and un.teamtypekey = 'CW';
      END IF;
END;
$function$;