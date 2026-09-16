DROP FUNCTION IF EXISTS cjams.getcjamsrolemasterlist(
    VARCHAR,
    VARCHAR
);
CREATE OR REPLACE FUNCTION cjams.getcjamsrolemasterlist(
    agency VARCHAR DEFAULT NULL
)
RETURNS TABLE (
    openamrole VARCHAR,
    description VARCHAR,
    createdon TIMESTAMP,
    roletypekey VARCHAR,
    appname VARCHAR
)
LANGUAGE plpgsql
AS $function$
-------------------------------------------------------------------------------------------------------------
-- Revision(s)
-- 6/6/2025 - Anil Kumar Dharni - CIDM-10293 - Created stored procedure to getrolemasterlist. It takes two optional params roletypekey and teamtypekey
--                                             and returns all the roles available in the cjams database
-------------------------------------------------------------------------------------------------------------
BEGIN
    RETURN QUERY
    SELECT 
        r.openamrole, 
        r.description, 
        r.insertedon as createdon, 
        r.roletypekey, 
        t.teamtypekey as appname
    FROM role r
    INNER JOIN teammemberroletype t 
        ON r.roletypekey = t.roletypekey 
        AND t.activeflag = 1
    WHERE 
        r.activeflag = 1 
        AND r.openamrole IS NOT NULL
        AND (agency IS NULL OR t.teamtypekey = agency);
END;
$function$;
