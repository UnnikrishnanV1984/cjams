/*
 * CDM-35365 - CJAMS USER
 * Component/s: Child Welfare
 * deactive 'jwinkler@waystationinc.org' user in cjams db. user is no longer with agency.
 * 
*/

-- select securityusersid, userid, * from v_userprofile where email = 'jwinkler@waystationinc.org';

update userprofile 
set activeflag=0,updatedon=now(), updatedby = 'CDM-35365'
where securityusersid='b89da871-02a6-4042-8ccb-86db621ee972';

update muser 
set activeflag=0,updatedon=now(), updatedby = 'CDM-35365'
where securityusersid='b89da871-02a6-4042-8ccb-86db621ee972';

update rolemapping
set activeflag = 0, updatedby = 'CDM-35365', updatedon = now() 
where principalid = '3983' and activeflag = 1;

update userresource
set activeflag = 0, updatedby = 'CDM-35365', updatedon = now() 
where userid = 3983 and activeflag = 1;

update teammemberassignment 
set activeflag =0, updatedby = 'CDM-35365', updatedon = now() 
where securityusersid = 'b89da871-02a6-4042-8ccb-86db621ee972' and activeflag = 1;

update securityusers 
set activeflag =0, updatedby = 'CDM-35365', updatedon = now() 
where securityusersid='b89da871-02a6-4042-8ccb-86db621ee972' and activeflag = 1;
