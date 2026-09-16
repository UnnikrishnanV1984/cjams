-- CIDM-9284: Data fix for  remove the duplicate race listed in the worksheet.
/*
Summary:	Data fix for remove the duplicate race listed in the worksheet. Approx 15500 record has been affected
Assignee:	Parshal Chitrakar
CJAMS Id/Referral Id:	NA
Environment: Production
Focus Area:	Person info
Steps to Reproduce:	Bulk data fix
worksheet:https://docs.google.com/spreadsheets/d/1il4K8b0tXMqd-NJgtFViU_st1G5-YaM6UX0fBc-TNyE/edit?gid=2088810155#gid=2088810155
*/
 
-- removing Unknown
 WITH to_update_UN_active_refrencevalue AS (
    SELECT prm.personid
    FROM personracetypemap prm
    JOIN person pr ON prm.personid = pr.personid
    JOIN referencevalues rv ON rv.ref_key = prm.racetypekey
    AND rv.activeflag = 1  -- Ensure the racetypekey is active in referencevalues
    WHERE pr.activeflag = 1  -- Only active people
      AND pr.clientflag = 1  -- Only clients
      AND prm.activeflag = 1  -- Only active race type mappings
    GROUP BY prm.personid
    HAVING COUNT(DISTINCT prm.racetypekey) > 1  -- Person has multiple race types
      AND SUM(CASE WHEN prm.racetypekey = 'UN' THEN 1 ELSE 0 END) > 0  -- At least one 'UN'
      AND COUNT(DISTINCT CASE WHEN prm.racetypekey != 'UN' THEN prm.racetypekey END) > 0  -- Person has other race types besides 'UN'
)

UPDATE personracetypemap
SET activeflag = 0,
    updatedby = 'CIDM-9284',  
    updatedon = NOW()
WHERE personid IN (SELECT personid FROM to_update_UN_active_refrencevalue)
  AND activeflag = 1  
  AND racetypekey = 'UN';
  
 -- removing missing
 WITH to_update_Missing_active_refrencevalue AS (
    SELECT prm.personid
    FROM personracetypemap prm
    JOIN person pr ON prm.personid = pr.personid
    JOIN referencevalues rv ON rv.ref_key = prm.racetypekey
    --AND rv.activeflag = 1  -- Ensure the racetypekey is active in referencevalues
    WHERE pr.activeflag = 1  -- Only active people
      AND pr.clientflag = 1  -- Only clients
      AND prm.activeflag = 1  -- Only active race type mappings
    GROUP BY prm.personid
    HAVING COUNT(DISTINCT prm.racetypekey) > 1  -- Person has multiple race types
      AND SUM(CASE WHEN prm.racetypekey = '99' THEN 1 ELSE 0 END) > 0  -- At least one '99'
      AND COUNT(DISTINCT CASE WHEN prm.racetypekey != '99' THEN prm.racetypekey END) > 0  -- Person has other race types besides '99'
)

UPDATE personracetypemap
SET activeflag = 0,
    updatedby = 'CIDM-9284',  
    updatedon = NOW()
WHERE personid IN (SELECT personid FROM to_update_Missing_active_refrencevalue)
  AND activeflag = 1  
  AND racetypekey = '99';
  
 -- removing invalid
 WITH to_update_Invalid_active_refrencevalue AS (
    SELECT prm.personid
    FROM personracetypemap prm
    JOIN person pr ON prm.personid = pr.personid
    JOIN referencevalues rv ON rv.ref_key = prm.racetypekey
    --AND rv.activeflag = 1  -- Ensure the racetypekey is active in referencevalues
    WHERE pr.activeflag = 1  -- Only active people
      AND pr.clientflag = 1  -- Only clients
      AND prm.activeflag = 1  -- Only active race type mappings
    GROUP BY prm.personid
    HAVING COUNT(DISTINCT prm.racetypekey) > 1  -- Person has multiple race types
      AND SUM(CASE WHEN prm.racetypekey = '88' THEN 1 ELSE 0 END) > 0  -- At least one '88'
      AND COUNT(DISTINCT CASE WHEN prm.racetypekey != '88' THEN prm.racetypekey END) > 0  -- Person has other race types besides '88'
)

UPDATE personracetypemap
SET activeflag = 0,
    updatedby = 'CIDM-9284',  
    updatedon = NOW()
WHERE personid IN (SELECT personid FROM to_update_Invalid_active_refrencevalue)
  AND activeflag = 1  
  AND racetypekey = '88';