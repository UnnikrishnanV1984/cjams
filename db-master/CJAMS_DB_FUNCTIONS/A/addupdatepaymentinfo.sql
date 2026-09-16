CREATE OR REPLACE FUNCTION cjams.addupdatepaymentinfo(searchobj json)
 RETURNS character varying
 LANGUAGE plpgsql
AS $function$

DECLARE 

  v_timestamp timestamp;
  v_returnstatus character varying;
  v_vendorapplicantid uuid;
  v_issame boolean;
  v_lateralentry int;

   

BEGIN 
v_vendorapplicantid := searchobj ->> 'vendorapplicantid';
v_timestamp := now()::timestamp with time zone;
v_issame := searchobj ->> 'issame';


IF (v_vendorapplicantid is not null) then 
update tb_vendor_applicant set taxidtype=COALESCE((searchobj ->> 'taxidtype'),taxidtype),
							   taxid=COALESCE((searchobj ->> 'taxid')::numeric,taxid),
							    is1099indicator=COALESCE((searchobj ->> 'is1099indicator')::boolean,is1099indicator),
							    ismedicalaidprov=COALESCE((searchobj ->> 'ismedicalaidprov')::boolean,ismedicalaidprov),
							    medlicense=COALESCE((searchobj ->> 'medlicense'),medlicense),
								speciality=COALESCE((searchobj ->> 'speciality'),speciality),
								issamepaymentaddress=COALESCE((searchobj ->> 'issame')::boolean,issamepaymentaddress),
								narrative=COALESCE((searchobj ->> 'narrative'),narrative)
								where vendorapplicantid=(v_vendorapplicantid)::uuid;
				if(v_issame) then 
				update Tb_vendor_addresses set ispaymentaddress=false,delete_sw='Y' where vendorapplicantid=(v_vendorapplicantid)::uuid and isaddress=false;
				update Tb_vendor_addresses set ispaymentaddress=true where vendorapplicantid=(v_vendorapplicantid)::uuid and isaddress=true and adr_end_dt is null;
				
				else
				v_lateralentry := null;
				select count(1) over() into v_lateralentry from tb_vendor_addresses where vendorapplicantid=(v_vendorapplicantid)::uuid and ispaymentaddress=true and isaddress=false;
			   if(v_lateralentry is null) then 
				update Tb_vendor_addresses set ispaymentaddress=false where vendorapplicantid=(v_vendorapplicantid)::uuid and isaddress=true;
			if(((searchobj ->> 'adr_1') != '') and ((searchobj ->> 'adr_city_nm') != '') and ((searchobj ->> 'adr_county_cd') != '') 
			and ((searchobj ->> 'adr_state_cd') != '')  and ((searchobj ->> 'adr_zip_no') != '') and ((searchobj ->> 'adr_start_dt') != '')) then
                INSERT INTO cjams.tb_vendor_addresses
( vendorapplicantid, adr_1, adr_2, adr_city_nm, adr_county_cd, adr_state_cd, adr_type_key, adr_zip_no, adr_start_dt, adr_end_dt, 
ispaymentaddress, create_ts, create_user_id, update_ts, update_user_id, delete_sw, isaddress)
VALUES( (v_vendorapplicantid)::uuid, (searchobj ->> 'adr_1'), (searchobj ->> 'adr_2'), (searchobj ->> 'adr_city_nm'), (searchobj ->> 'adr_county_cd'),
   (searchobj ->> 'adr_state_cd'), (searchobj ->> 'adr_type_key'), (searchobj ->> 'adr_zip_no')::numeric, (searchobj ->> 'adr_start_dt')::date, (searchobj ->> 'adr_end_dt')::date,
   true, v_timestamp,(searchobj ->> 'create_user_id'), v_timestamp, (searchobj ->> 'update_user_id'), 'N', false);
				end if;	
			 end if;
				end if;
v_returnstatus:='Success';
 else


v_returnstatus:='Failure';
end if;
	

return v_returnstatus;

END;

$function$
