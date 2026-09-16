CREATE OR REPLACE FUNCTION cjams.reopenapplication(v_applicantid character varying, v_fromsecurityuserid character varying, v_tosecurityuserid character varying)
 RETURNS character varying
 LANGUAGE plpgsql
AS $function$ 

declare

   v_routingstatus character varying;
   v_notifymsg character varying;



BEGIN

IF (v_applicantid is not null) then 

v_notifymsg := 'Application #'||v_applicantid||' has been reponed';

update tb_public_provider_applicant set application_received_date=null,application_status='For Assignment' where applicant_id=v_applicantid;

select publicproviderrouting into v_routingstatus  from publicproviderrouting(v_applicantid,v_fromsecurityuserid,v_tosecurityuserid,609,'PRASS',v_notifymsg);
raise notice 'v_routingstatus%',v_routingstatus;

return 'Success';
else 
return 'Failure';
end if;                                                      
END;

$function$;
