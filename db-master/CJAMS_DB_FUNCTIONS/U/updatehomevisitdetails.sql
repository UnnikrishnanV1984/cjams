drop function if exists updatehomevisitdetails(uuid,character varying);
CREATE OR REPLACE FUNCTION cjams.updatehomevisitdetails(v_homevisitid uuid, v_objectid character varying)
 RETURNS text
 LANGUAGE plpgsql
AS $function$ 
declare

returnstatus text;

begin



if length(v_objectid)>0
then
update Publicproviderhomestudyvisit set active_flag=0 where home_study_visit_id=v_homevisitid;
update publicproviderhomestudyhouseholdmapping set active_flag=1 where home_study_visit_id=v_homevisitid;
update tb_provider_applicant_communication set delete_sw='Y' where provider_applicant_id=v_objectid;


returnstatus:='success';

else
returnstatus:='failure';

end if;
return returnstatus;
end;
$function$;
