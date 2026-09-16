CREATE OR REPLACE FUNCTION cjams.addupdatevendorapplicant(searchobj json)
 RETURNS character varying
 LANGUAGE plpgsql
AS $function$

DECLARE 

  v_timestamp timestamp;
  v_returnstatus character varying;
  v_services json;
  v_servicesinfo json;
  v_vendorapplicantid uuid;
  v_count int;
 v_servicesid int;
   

BEGIN 
v_vendorapplicantid := searchobj ->> 'vendorapplicantid';
v_timestamp := now()::timestamp with time zone;
v_services := searchobj ->> 'services';


IF (v_vendorapplicantid is null) then 
v_vendorapplicantid := gen_random_uuid();

INSERT INTO cjams.tb_vendor_applicant
(vendorapplicantid, org_nm, primary_prefix_cd, primary_first_nm, primary_middle_nm, primary_last_nm, primary_suffix_cd, isprimaryadmin, admin_prefix_cd,
 admin_first_nm, admin_middle_nm, admin_last_nm, admin_suffix_cd, taxidtype, taxid, is1099indicator, ismedicalaidprov, status, create_ts, create_user_id, update_ts, update_user_id, delete_sw,regularfrom,regularto,vendorid,
 jurisdiction)
VALUES(v_vendorapplicantid,(searchobj ->> 'org_nm'), (searchobj ->> 'primary_prefix_cd'), (searchobj ->> 'primary_first_nm'), (searchobj ->> 'primary_middle_nm'),
 (searchobj ->> 'primary_last_nm'), (searchobj ->> 'primary_suffix_cd'), (searchobj ->> 'isprimaryadmin')::boolean, (searchobj ->> 'admin_prefix_cd'), 
 (searchobj ->> 'admin_first_nm'), (searchobj ->> 'admin_middle_nm'), (searchobj ->> 'admin_last_nm'),  (searchobj ->> 'admin_suffix_cd'), (searchobj ->> 'taxidtype'),
 (searchobj ->> 'taxid')::numeric,  (searchobj ->> 'is1099indicator')::boolean,  (searchobj ->> 'ismedicalaidprov')::boolean, (searchobj ->> 'status'),
  v_timestamp,  (searchobj ->> 'create_user_id'), v_timestamp,  (searchobj ->> 'update_user_id'), 'N',(searchobj ->> 'regularfrom'),(searchobj ->> 'regularto'),
 (searchobj ->> 'vendorid'), (searchobj ->> 'jurisdiction'));
  
  IF (v_services is not null) then for v_servicesinfo in select * from json_array_elements(v_services) loop
  v_servicesid := (v_servicesinfo ->> 'service_id')::int;
 raise notice 'inside%',v_servicesid;
 if(v_servicesid is not null) then
  INSERT INTO cjams.tb_vendor_applicant_services
( service_id, vendorapplicantid, startdate, enddate, create_ts, create_user_id, update_ts, update_user_id, delete_sw)
VALUES( v_servicesid, v_vendorapplicantid, (v_servicesinfo ->> 'startdate')::timestamp, (v_servicesinfo ->> 'enddate')::timestamp,   v_timestamp,  (searchobj ->> 'create_user_id'), v_timestamp,  (searchobj ->> 'update_user_id'), 'N');
end if; 
end loop;
  end if;

v_returnstatus:='success';
else
update tb_vendor_applicant_services set delete_sw='Y' where vendorapplicantid = (v_vendorapplicantid)::uuid;

UPDATE tb_vendor_applicant
SET org_nm=COALESCE((searchobj ->> 'org_nm'),org_nm),
    primary_prefix_cd=COALESCE((searchobj ->> 'primary_prefix_cd'),primary_prefix_cd), 
    primary_first_nm=COALESCE((searchobj ->> 'primary_first_nm'),primary_first_nm), 
    primary_middle_nm=COALESCE((searchobj ->> 'primary_middle_nm'),primary_middle_nm), 
    primary_last_nm=COALESCE((searchobj ->> 'primary_last_nm'),primary_last_nm), 
    primary_suffix_cd=COALESCE((searchobj ->> 'primary_suffix_cd'),primary_suffix_cd), 
    isprimaryadmin=COALESCE((searchobj ->> 'isprimaryadmin')::boolean,isprimaryadmin), 
    admin_prefix_cd=COALESCE((searchobj ->> 'admin_prefix_cd'),admin_prefix_cd), 
    admin_first_nm=COALESCE((searchobj ->> 'admin_first_nm'),admin_first_nm), 
    admin_middle_nm=COALESCE((searchobj ->> 'admin_middle_nm'),admin_middle_nm), 
    admin_last_nm=COALESCE((searchobj ->> 'admin_last_nm'),admin_last_nm), 
    admin_suffix_cd=COALESCE((searchobj ->> 'admin_suffix_cd'),admin_suffix_cd),
    status=COALESCE((searchobj ->> 'status'),status), 
    update_ts=v_timestamp, update_user_id=(searchobj ->> 'update_user_id'),
    regularfrom=coalesce((searchobj ->> 'regularfrom'),regularfrom),
       regularto=coalesce((searchobj ->> 'regularfrom'),regularto),
        jurisdiction=coalesce((searchobj ->> 'jurisdiction'),jurisdiction)
WHERE vendorapplicantid = (v_vendorapplicantid)::uuid;

  IF (v_services is not null) then for v_servicesinfo in select * from json_array_elements(v_services) loop
  v_count := 0;
  select count(*) into v_count from tb_vendor_applicant_services where service_id = (v_servicesinfo ->> 'service_id')::int and vendorapplicantid = (v_vendorapplicantid)::uuid;
 if (v_count > 0) then 
 update tb_vendor_applicant_services set 
startdate=COALESCE((v_servicesinfo ->> 'startdate')::timestamp,startdate),
enddate=COALESCE((v_servicesinfo ->> 'enddate')::timestamp,enddate),
 delete_sw='N',update_user_id=(searchobj ->> 'update_user_id'),update_ts=v_timestamp where service_id = (v_servicesinfo ->> 'service_id')::int and vendorapplicantid = (v_vendorapplicantid)::uuid;
 else
  v_servicesid := (v_servicesinfo ->> 'service_id')::int;
 if (v_servicesid is not null) then 
  INSERT INTO tb_vendor_applicant_services
( service_id, vendorapplicantid, startdate, enddate,create_ts,create_user_id,
update_ts, update_user_id, delete_sw)
VALUES( (v_servicesinfo ->> 'service_id')::int, v_vendorapplicantid, (v_servicesinfo ->> 'startdate')::timestamp, (v_servicesinfo ->> 'enddate')::timestamp, v_timestamp,  (searchobj ->> 'create_user_id'),
v_timestamp,  (searchobj ->> 'update_user_id'), 'N');
end if;
end if; 
end loop;
  end if;

v_returnstatus:='success';
end if;
	

return v_returnstatus;

END;

$function$;
