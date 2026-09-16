CREATE OR REPLACE FUNCTION cjams.sp_fostercare_retry_csmsrecords(v_inputjson json, v_outputjson json, al_clientid bigint, al_removalid bigint,al_reviewperiod character varying , v_csmsreferralid character varying, csmsfailureflag boolean, v_eligibility_id bigint)
 RETURNS json
 LANGUAGE plpgsql
AS $function$ 

-------------------------------------------------
-- CIDM-8472 - Veera TO fix the IVE Auto Approvals
----------------------------------------------------

DECLARE
v_date timestamp without time zone;
v_countupdate INTEGER;

begin
v_date := now();

select count(*) into v_countupdate from ivecsesoutbounddata ivb where ivb.clientid = al_clientid and ivb.removalid = al_removalid and ivb.activeflag = 1;


IF v_countupdate > 0 THEN 
   update ivecsesoutbounddata cb set activeflag = 0, updatedon = v_date  where cb.clientid = al_clientid and cb.removalid = al_removalid and cb.activeflag = 1;
end if;

insert into  cjams.ivecsesoutbounddata (ivecsesoutboundid, inputjson, outputjson, reviewperiod, clientid, removalid , activeflag, insertedon, updatedon, csmsreferralid, csmsretryuser, csmsfailureflag) 
values (gen_random_uuid(),v_inputjson, v_outputjson , al_reviewperiod, al_clientid, al_removalid, 1, v_date, v_date , v_csmsreferralid, 'CIDM-8559', csmsfailureflag);  


if (csmsfailureflag = true) then 
    update ive_auto_approvals set csmsref_interface_date = v_date, csmsref_interface_comments = 'CSMS Referral request has been failed', updatedby = 'CSMS Auto Approval', updatedon = v_date
    where eligibility_period_id = v_eligibility_id;
else 
    update ive_auto_approvals set csmsref_process_sw = 'Y' , csmsref_interface_date = v_date, csmsref_interface_comments = 'CSMS Referral approval request was successfully updated.', updatedby = 'CSMS Auto Approval', updatedon = v_date
    where eligibility_period_id = v_eligibility_id;
end if ;    

return v_inputjson;

end
 $function$
;