CREATE OR REPLACE FUNCTION cjams.witholdefthistory(v_inputjson json)
 RETURNS  character varying
 LANGUAGE plpgsql
AS $function$

-- Revision(s)
-- 12/05/2022 Umasankar Raavi -Added New column value 

DECLARE	
/* v_pageSize INT;
 v_pageNumber INT;
 v_pageNum INT; 
 v_pageOffset INT;*/

v_eft character varying;
v_withhold character varying;
v_insertedby character varying;
v_providerid int;
v_withholdreason text;
v_withhold_question character varying;

BEGIN  

v_eft := v_inputjson ->> 'eft_sw';
v_withhold := v_inputjson ->> 'withhold_payment_sw';
v_insertedby := v_inputjson ->> 'enteredby';
v_providerid := v_inputjson ->> 'provider_id';
v_withholdreason := v_inputjson ->> 'withhold_reason';
v_withhold_question= v_inputjson ->> 'withhold_question';

if (v_providerid>0) then 
update tb_provider set eft_sw=coalesce(v_eft,eft_sw),withhold_payment_sw=coalesce(v_withhold,withhold_payment_sw) where provider_id=v_providerid;

INSERT INTO withhold_eft_config
( withhold_payment_sw, eft_sw, activeflag, insertedby, insertedon, updatedby, updatedon,provider_id,withhold_reason, withhold_question)
VALUES( v_withhold, v_eft, 1, v_insertedby, now(), v_insertedby, now(),v_providerid,v_withholdreason, v_withhold_question);


return 'Success';

else 

return  'Failure';
end if;

 END;

$function$