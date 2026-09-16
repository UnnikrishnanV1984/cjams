drop function if exists sp_csms_updatencpcasenumbers(json);

CREATE OR REPLACE FUNCTION sp_csms_updatencpcasenumbers(searchobj json)
 RETURNS text
 LANGUAGE plpgsql
AS $function$

DECLARE 

v_clientid INTEGER;
v_referralId varchar(20);
v_ncpclientid  INTEGER;
v_csmstatusdate timestamp;
v_inputjson json;
v_countupdate INTEGER;
v_ncpcasenumber varchar(50);

	
BEGIN 
v_inputjson := searchobj;
v_clientid := searchobj ->> 'iveCaseNumber';
v_referralId := searchobj ->> 'referralId'; 
v_ncpclientid := searchobj ->> 'iveNcpClientId';  
v_csmstatusdate := searchobj ->> 'changeRequestDt'; 
v_ncpcasenumber := searchobj ->> 'caseNumber'; 


raise notice 'test %',v_referralId;
raise notice 'test %',v_csmstatusdate;
raise notice 'test %',v_ncpcasenumber;


select count(*) into v_countupdate from ivecsmsncpcasedetails ivb where clientid =  v_clientid and csmsreferralid = v_referralId and ncpclientid = v_ncpclientid and activeflag = 1;

IF v_countupdate > 0 THEN 
   update ivecsmsncpcasedetails cb set activeflag = 0, updatedon = now()  where clientid =  v_clientid and csmsreferralid = v_referralId and ncpclientid = v_ncpclientid and activeflag = 1;
end if;
				    
insert into ivecsmsncpcasedetails (ivecsmsncpcasedetailsid,clientid,csmsreferralid, ncpclientid, ncpcasenumber , ncpcasecreationdate,recievedpayload,insertedby, insertedon, updatedby, updatedon, activeflag) values 
(gen_random_uuid(),v_clientid,v_referralId,v_ncpclientid, v_ncpcasenumber ,v_csmstatusdate,v_inputjson, 'CSMS API', now(), 'CSMS API', now(), 1);


return 'Success';

END;

$function$;