/*
    CIDM-3448, CIDM-3183
    Issue - Person profile with missing and invalid values for Gender, ethinicity, prefix
    Root Cause - In drop down selection the values are getting displayed though it has activeflag value as 0
    Fix - Done code fix to restrict those values
    Data fix - Done data fix for old values
*/

-- Gender
update person 
set gendertypekey = null, updatedby = 'CIDM-3448', updatedon = now() 
where gendertypekey in ('88', '99') and activeflag = 1;

-- Activating the rows
update referencevalues 
set activeflag = 1 
where referencetypeid = 301 and (teamtypekey is null or teamtypekey = 'CW') and ref_key in ('M', 'F');