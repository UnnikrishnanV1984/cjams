CREATE OR REPLACE FUNCTION cjams.getcsmsivereferralsinfo()
 RETURNS json
 LANGUAGE plpgsql
AS $function$
	DECLARE
	jsondata json;

	begin
	select json_agg(d) INTO jsondata from (SELECT clientid, removalid,csmsreferralid, referralcounty, reviewperiod FROM ivecsesoutbounddata ivb where activeflag = 1 and referralcounty in ('24043')) d ;
   	
	RETURN jsondata;
	END;
$function$
;
