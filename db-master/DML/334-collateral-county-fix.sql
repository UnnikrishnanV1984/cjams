UPDATE collateraladdress ca
SET countytypekey = (SELECT countyname FROM county c WHERE  c.countyid::CHARACTER VARYING = ca.countytypekey)
WHERE 
ca.countytypekey IS NOT NULL AND ca.countytypekey IN (SELECT countyid::CHARACTER VARYING FROM county);