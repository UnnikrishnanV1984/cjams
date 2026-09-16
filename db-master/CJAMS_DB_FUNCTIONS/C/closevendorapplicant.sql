CREATE OR REPLACE FUNCTION cjams.closevendorapplicant(searchobj json)
 RETURNS character varying
 LANGUAGE plpgsql
AS $function$

DECLARE 

  v_timestamp timestamp;
  v_returnstatus character varying;
  v_vendorid character varying;
  v_securityuserid character varying;
 v_vendorapplicantid uuid;
 v_providerid int;
   

BEGIN 
v_vendorapplicantid := searchobj ->> 'vendorapplicantid';
v_vendorid := searchobj ->> 'vendorid';

v_securityuserid := searchobj ->> 'securityuserid';

v_providerid := null;
v_timestamp := now()::timestamp with time zone;


IF (v_vendorid is not null) then 
update tb_vendor_applicant set status='Closed' where vendorapplicantid=(v_vendorapplicantid)::uuid;
select providerid into v_providerid from tb_vendor_applicant where vendorid=v_vendorid;
if (v_providerid is not null) then
update tb_provider set provider_status_cd='1792',delete_sw='Y' where provider_id=(v_providerid)::int;
update tb_provider_services set delete_sw='Y' where provider_id=(v_providerid)::int;
update tb_provider_addresses set delete_sw='Y' where parent_key_id=(v_providerid)::character varying;
end if;
v_returnstatus:=v_providerid;

else


v_returnstatus:='Failure';
end if;
	

return v_returnstatus;

END;

$function$
