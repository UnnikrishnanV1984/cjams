Drop function if exists sp_ive_eligibility_worksheet_income_info(json);

CREATE OR REPLACE FUNCTION cjams.sp_ive_eligibility_worksheet_income_info(reqobj json)
 RETURNS TABLE(v_clientid bigint, v_childcarecost integer, v_assistanceunitno integer, v_notinassistanceunitno integer, v_standardunitno integer, v_notinstandardunitno integer, v_grossincome185pcunitno integer, v_assetsallowance integer, v_assetsmarketvalue integer, v_iveincomesumaryid uuid, v_removalid integer, v_afdceligibilitymonth date)
 LANGUAGE plpgsql
AS $function$ 

----------------------------------------------------------------------------------------------
-- Revision:
-- 04/09/2025 - Manasa Kasula - CIDM-10359: B-208328-IV-E Foster Care Eligibility Output Worksheet story changes to add a new field afdceligibilitymonth in the afdc section.
----------------------------------------------------------------------------------------------

DECLARE
	v_clientid  BIGINT;
	returnStatus text;
	v_num INT;	
--	v_benefitamount INT;
	v_childcarecost INT;
--	v_benefittype VARCHAR(30);
	v_assistanceunitno INT;
	v_notinassistanceunitno INT;
	v_standardunitno INT;
    v_notinstandardunitno INT; 
    v_grossincome185pcunitno INT;
   	v_assetsallowance NUMERIC;
   	v_assetsmarketvalue INT;
   	v_removalid INT;
   	v_iveincomesumaryid UUID;
	v_afdceligibilitymonth date;
   
BEGIN
	v_iveincomesumaryid := reqObj ->> 'iveincomesumaryid';
	v_clientid := reqObj ->> 'clientId';
	v_childcarecost := reqObj ->> 'childcarecost';
	v_assistanceunitno := reqObj ->> 'assistanceunitno';
	v_notinassistanceunitno := reqObj ->> 'notinassistanceunitno';
	v_standardunitno := reqObj ->> 'standardunitno';
	v_notinstandardunitno := reqObj ->> 'notinstandardunitno';
	v_grossincome185pcunitno := reqObj ->> 'grossincome185pcunitno';
	v_assetsallowance := reqObj ->> 'assetsallowance';
	v_assetsmarketvalue := reqObj ->> 'assetsmarketvalue';
	v_removalid := reqObj ->> 'removalid';
	v_afdceligibilitymonth := reqObj ->> 'afdceligibilitymonth';

	returnStatus := 'Success';
	
	SELECT count(*) into v_num FROM iveincomesumary WHERE clientid=v_clientid and removalid=v_removalid;

	

	IF (v_num) >= 1
	THEN
	 	UPDATE iveincomesumary		
	SET 					
		childcarecost = v_childcarecost,
		assistanceunitno = v_assistanceunitno,
		notinassistanceunitno = v_notinassistanceunitno,
		standardunitno = v_standardunitno,
		notinstandardunitno = v_notinstandardunitno,
		grossincome185pcunitno = v_grossincome185pcunitno,
		assetsallowance = v_assetsallowance,
		assetsmarketvalue = v_assetsmarketvalue,
		afdceligibilitymonth = v_afdceligibilitymonth
		
	WHERE clientid=v_clientid and removalid=v_removalid;
	
	else	 	
	 
		Insert into iveincomesumary(iveincomesumaryid, clientid, activeflag, childcarecost, 
            assistanceunitno, notinassistanceunitno, standardunitno, notinstandardunitno, grossincome185pcunitno, assetsallowance , assetsmarketvalue, removalid, afdceligibilitymonth) 
        VALUES(gen_random_uuid(), v_clientid, 1, v_childcarecost, v_assistanceunitno, 
            v_notinassistanceunitno, v_standardunitno, v_notinstandardunitno, v_grossincome185pcunitno, v_assetsallowance, v_assetsmarketvalue, v_removalid, v_afdceligibilitymonth);           
           
	end if;

RETURN QUERY
select

ipd.clientid  				as v_clientid,
ipd.childcarecost			as v_childcarecost,
ipd.assistanceunitno		as v_assistanceunitno,
ipd.notinassistanceunitno	as v_notinassistanceunitno,
ipd.standardunitno			as v_standardunitno,
ipd.notinstandardunitno		as v_notinstandardunitno,
ipd.grossincome185pcunitno	as v_grossincome185pcunitno,
ipd.assetsallowance         as v_assetsallowance,
ipd.assetsmarketvalue       as v_assetsmarketvalue,
ipd.iveincomesumaryid       as v_iveincomesumaryid,
ipd.removalid               as v_removalid,
ipd.afdceligibilitymonth    as v_afdceligibilitymonth
from iveincomesumary ipd
where ipd.clientid = v_clientid;
--RETURN format('%s', returnStatus);

end;
	
$function$
;
