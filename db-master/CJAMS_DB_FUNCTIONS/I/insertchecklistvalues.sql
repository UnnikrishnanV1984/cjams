drop function if exists insertchecklistvalues(character varying,character varying);
drop function if exists insertchecklistvalues(json);
CREATE OR REPLACE FUNCTION cjams.insertchecklistvalues(v_request json)
 RETURNS character varying
 LANGUAGE plpgsql
AS $function$

DECLARE
    v_task json;
   v_applicantid character varying;
   v_first json;
    v_category character varying;
    v_taskitems json;
   v_programname character varying;

   
BEGIN
   v_task := v_request -> 'task';
   v_applicantid := v_request ->> 'applicant_id';
    v_first := v_task ->0;
     v_category := v_first ->> 'category';
   
    select  prgram into v_programname from tb_provider_applicant where applicant_id=v_applicantid;
  raise notice 'v_task%',v_task;
  raise notice 'v_first%',v_first;
  raise notice 'v_category%',v_category;
 
 if (v_category = 'Monitoring') then 
 
  if (v_task is not null) then for v_taskitems in select
	*
from
	json_array_elements(v_task) loop
	
	
 	insert into tb_provider_applicant_checklist 
(provider_applicant_id,status, category, subcategory, agency, programname, description,checklist_task)
values( v_applicantid,'Incomplete', 'Monitoring', (v_taskitems ->>'subcategory'), 'OLM', 'CPA', (v_taskitems ->>'subcategory'),(v_taskitems ->>'subcategory')) ;

	end loop;
end if;


  else

	insert into tb_provider_applicant_checklist 
(provider_applicant_id,status, category, subcategory, agency, programname, description,checklist_task)
select v_applicantid,'Incomplete', category, subcategory, agency, programname, description,task from tb_activitytasklist where category=v_category 
and programname=v_programname;

end if;



return 'success';


--LIMIT v_liPageSize OFFSET v_pageoffset; 
END 

$function$
