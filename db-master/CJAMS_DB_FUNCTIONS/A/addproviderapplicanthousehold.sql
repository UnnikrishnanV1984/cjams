CREATE OR REPLACE FUNCTION cjams.addproviderapplicanthousehold(insertedtlsobj json)
 RETURNS text
 LANGUAGE plpgsql
AS $function$ 

declare
returnStatus text;
object_id text;
household_member_relation text;
household_member_email text;
household_member_dob date;
household_member_phone numeric;
household_member_background_status bool;
household_member_ssn numeric;
create_ts date;
update_ts date;
delete_sw char;
household_member_clearance_status text;
household_member_first_name text;
household_member_middle_name text;
household_member_last_name text;
bg_chk_state bool;
bg_chk_state_date date;
bg_chk_national bool;
bg_chk_national_date date;
bg_chk_child_abuse_maltreatment bool;
bg_chk_child_abuse_maltreatment_date date;
bg_chk_oos bool;
bg_chk_child_abuse_maltreatment_oos bool;
bg_chk_child_abuse_maltreatment_oos_date date;

--insertedtlsobj->>'object_id'

BEGIN

object_id=insertedtlsobj->>'object_id';
household_member_relation =insertedtlsobj->>'household_member_relation';
household_member_email=insertedtlsobj->>'household_member_email';
household_member_dob= insertedtlsobj->>'household_member_dob';
household_member_phone =insertedtlsobj->>'household_member_phone ';
household_member_background_status =insertedtlsobj->>'household_member_background_status';
household_member_ssn =insertedtlsobj->>'household_member_ssn';
delete_sw= insertedtlsobj->>'delete_sw';
create_ts = insertedtlsobj->>'create_ts';
update_ts = insertedtlsobj->>'update_ts';
household_member_clearance_status= insertedtlsobj->>'household_member_clearance_status';
household_member_first_name= insertedtlsobj->>'household_member_first_name';
household_member_middle_name= insertedtlsobj->>'household_member_middle_name';
household_member_last_name= insertedtlsobj->>'household_member_last_name';
bg_chk_state = insertedtlsobj->>'bg_chk_state';
bg_chk_state_date = insertedtlsobj->>'bg_chk_state_date';
bg_chk_national = insertedtlsobj->>'bg_chk_national';
bg_chk_national_date = insertedtlsobj->>'bg_chk_national_date';
bg_chk_child_abuse_maltreatment = insertedtlsobj->>'bg_chk_child_abuse_maltreatment';
bg_chk_child_abuse_maltreatment_date = insertedtlsobj->>'bg_chk_child_abuse_maltreatment_date';
bg_chk_oos = insertedtlsobj->>'bg_chk_oos';
bg_chk_child_abuse_maltreatment_oos = insertedtlsobj->>'bg_chk_child_abuse_maltreatment_oos';
bg_chk_child_abuse_maltreatment_oos_date = insertedtlsobj->>'bg_chk_child_abuse_maltreatment_oos_date';

/*IF providerServiceId>0
then 
update tb_applicant_services set service_status='Expired' where provider_service_id=providerServiceId;
END IF;*/

insert into tb_public_provider_applicant_household (object_id, household_member_relation,household_member_email,household_member_dob, 
household_member_phone, household_member_background_status,household_member_ssn,create_ts, create_user_id,update_ts, update_user_id, delete_sw,
household_member_clearance_status,household_member_first_name,household_member_middle_name,household_member_last_name,
bg_chk_state,
bg_chk_state_date,
bg_chk_national,
bg_chk_national_date,
bg_chk_child_abuse_maltreatment,
bg_chk_child_abuse_maltreatment_date,
bg_chk_oos,
bg_chk_child_abuse_maltreatment_oos,
bg_chk_child_abuse_maltreatment_oos_date
)

/*values
(object_id,household_member_relation,household_member_email,household_member_dob,household_member_phone,household_member_background_status,
household_member_ssn,delete_sw, insertedtlsobj->>'create_user_id',
now(), insertedtlsobj->>'update_user_id',delete_sw,household_member_clearance_status::boolean,
household_member_first_name,household_member_middle_name,
household_member_last_name);*/
values
(object_id,household_member_relation,household_member_email,household_member_dob,household_member_phone,household_member_background_status,household_member_ssn,create_ts::timestamp without time zone, insertedtlsobj->>'create_user_id',
update_ts::timestamp without time zone, insertedtlsobj->>'update_user_id','N',household_member_clearance_status::boolean,household_member_first_name,household_member_middle_name,
household_member_last_name,
bg_chk_state,
bg_chk_state_date,
bg_chk_national,
bg_chk_national_date,
bg_chk_child_abuse_maltreatment,
bg_chk_child_abuse_maltreatment_date,
bg_chk_oos,
bg_chk_child_abuse_maltreatment_oos,
bg_chk_child_abuse_maltreatment_oos_date
);

returnStatus:= 'Success';

RETURN returnStatus;
                                                      
END;

$function$;
