drop function if exists sp_csms_inbound_data(json);

CREATE OR REPLACE FUNCTION sp_csms_inbound_data(searchobj json)
 RETURNS text
 LANGUAGE plpgsql
AS $function$

DECLARE 

v_cisclientid varchar(12);
v_Mdm_id varchar(50);
v_Member_id  varchar(50);
v_socounty varchar(50);
v_sostate varchar(12);
v_sonumber varchar(50);
v_sodate timestamp;
v_sostatusdate timestamp;
v_sostatustypekey varchar(50);
v_sopaymentamount numeric;
v_sopaymentfreqtypekey varchar(50);
v_sodatasource varchar(10);
v_inputjson json;
v_county_details varchar;

	
BEGIN 
v_inputjson := searchobj;
v_cisclientid := searchobj ->> 'cisclientid';
v_Mdm_id := searchobj ->> 'mdm_id'; 
v_Member_id := searchobj ->> 'member_id';  
v_socounty := searchobj ->> 'socounty';  
v_sostate := searchobj ->> 'sostate'; 
v_sostatusdate := searchobj ->> 'sostatusdate'; 
v_sostatustypekey := searchobj ->> 'sostatustypekey'; 
v_sopaymentamount := searchobj ->> 'sopaymentamount';
v_sopaymentfreqtypekey := searchobj ->> 'sopaymentfreqtypekey'; 
v_sodatasource := searchobj ->> 'sodatasource'; 
v_sonumber := searchobj ->> 'sonumber';


select value_text into v_county_details from ivecsescountycodes where fipscode = v_socounty and activeflag = 1;


 
				    
insert into ivecsmsinbounddata (cisclientid,mdm_id,Member_id,socounty, sostate, sonumber , sostatusdate,sostatustypekey,sopaymentamount, sopaymentfreqtypekey, sodatasource, inputjson) values 
(v_cisclientid,v_Mdm_id,v_Member_id,v_socounty,v_sostate, v_sonumber ,v_sostatusdate,v_sostatustypekey,v_sopaymentamount, v_sopaymentfreqtypekey, v_sodatasource, v_inputjson);

IF v_cisclientid IS NOT NULL THEN 

update csesclientsupportorder set activeflag = 0, updatedon = NOW() ,updatedby = 'CSMS API' where cisclientid = v_cisclientid and activeflag = 1;

END IF;

 INSERT INTO csesclientsupportorder
					(	csesclientsupportorderid,
						cisclientid,
						socounty,
						sostate,
						sonumber,
						sostatusdate,
						sostatustypekey,
						sopaymentamount,
						sopaymentfreqtypekey,
						sodatasource,
						insertedby,
						insertedon,
						updatedby,
						updatedon,
						activeflag,
						personid
					) values (gen_random_uuid(), v_cisclientid,v_county_details, v_sostate, v_sonumber, v_sostatusdate,v_sostatustypekey,v_sopaymentamount,
                    v_sopaymentfreqtypekey, v_sodatasource, 'CSMS-API', NOW(), 'CSMS-API', NOW(),1,null);


return 'Success';

END;

$function$;