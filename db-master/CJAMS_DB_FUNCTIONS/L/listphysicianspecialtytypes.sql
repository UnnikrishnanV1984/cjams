DROP FUNCTION IF EXISTS cjams.listphysicianspecialtytypes(v_teamtypekey character varying);
CREATE OR REPLACE FUNCTION cjams.listphysicianspecialtytypes(v_teamtypekey character varying)
 RETURNS TABLE(physicianspecialtytypeid uuid, physicianspecialtytypekey character varying, description character varying)
 LANGUAGE plpgsql
AS $function$
-- Revision
-- CIDM-10415: Manasa Kasula Proc to fetch the physician speciality types
-- ----------------------------------------------
BEGIN

RETURN query  
    SELECT pst.physicianspecialtytypeid, pst.physicianspecialtytypekey, pst.description
    FROM   Physicianspecialtytype AS pst
    WHERE  pst.activeflag = 1 and coalesce(pst.teamtypekey,'CW') = v_teamtypekey
    ORDER  BY pst.description ASC; 

END;
$function$
;
