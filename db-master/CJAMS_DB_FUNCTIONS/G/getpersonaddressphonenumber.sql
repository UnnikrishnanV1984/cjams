DROP FUNCTION IF EXISTS cjams.getpersonaddressphonenumber(v_personid uuid);
CREATE OR REPLACE FUNCTION cjams.getpersonaddressphonenumber(v_personid uuid)
 RETURNS json
 LANGUAGE plpgsql
AS $function$

DECLARE  
phonenumbers  json;
addressjson json;
results json;
BEGIN

Select Json_agg(res) into results from (select p.personid,(SELECT  Json_agg(phone) phonenumbers  FROM  (select personphonetypekey,phonenumber from personphonenumber  
where personid=v_personid) phone),(SELECT  Json_agg(addresses)  addressjson  FROM  (select p.personid,p.personaddresstypekey,p.address,p.zipcode,p.city,p.state,p.country,pa.typedescription
from personaddress p join personaddresstype pa on p.personaddresstypekey= pa.personaddresstypekey
where p.personid= v_personid) addresses) from person p where p.personid=v_personid) res;

RETURN results;
END;

$function$
;
