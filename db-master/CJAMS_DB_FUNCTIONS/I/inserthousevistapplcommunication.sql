CREATE OR REPLACE FUNCTION cjams.inserthousevistapplcommunication(insertobj json)
 RETURNS text
 LANGUAGE plpgsql
AS $function$ 
declare
v_securityuserid character varying;
v_applicant_id character varying;
returnstatus text;

begin

v_securityuserid:=insertobj->>'securityuserid';
v_applicant_id:=insertobj->>'object_id';

if length(v_applicant_id)>0
then

INSERT INTO tb_provider_applicant_communication
(communication_id, provider_applicant_id, type_of_contact, purpose_of_contact, person_contacted_name, title_of_person_contacted, communication_date, narrative, communication_location, phone_of_contact, email_of_contact, create_ts, create_user_id, update_ts, update_user_id, delete_sw)
VALUES(gen_random_uuid(), v_applicant_id, 'Home Stydy Visit', 'Home Visit', insertobj->>'person_contacted_name', insertobj->>'title_of_person_contacted', (insertobj->>'interview_date')::timestamp, insertobj->>'narrative',
insertobj->>'interview_location', insertobj->>'phone_of_contact', insertobj->>'email_of_contact', now(), v_securityuserid, now(), v_securityuserid, 'N'::bpchar);

returnstatus:='succes';

else
returnstatus:='failue';

end if;
return returnstatus;
end;
$function$
