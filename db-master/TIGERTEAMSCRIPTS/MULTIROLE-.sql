ALTER TABLE cjams.rolemapping ADD IF NOT EXISTS teamtypekey varchar(50) NULL;
update rolemapping set teamtypekey = subquery.teamtypekey
from (select up.teamtypekey,mu.id from userprofile up join muser mu on mu.securityusersid = up.securityusersid
 ) AS subquery where rolemapping.principalid = subquery.id and rolemapping.teamtypekey is null;