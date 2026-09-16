 --DROP FUNCTION if exists cjams.f_prim_county_crb(character varying);

CREATE OR REPLACE FUNCTION f_prim_county_crb(
	ai_entity_id character varying,
	OUT county_id integer)
    RETURNS integer
    LANGUAGE 'plpgsql'

    COST 100
    VOLATILE 
AS $BODY$
/****
26/06/19  - V1.0  Hadi/Narendra   First commit
26/06/19  - V1.1  Hadi/Narendra   changing OUT parameter to county_id and relevant case statements.

***/
declare 
ai_entity1_id uuid; --
ai_entity2_id uuid; --
sec_id uuid;

BEGIN 

SELECT servicecaseid INTO ai_entity1_id from servicecase where servicecasenumber = ai_entity_id; --
SELECT servicecaseid INTO ai_entity2_id from adoptioncase where adoptioncasenumber = ai_entity_id ;--

SELECT routing.tosecurityusersid into sec_id
FROM  routing 
WHERE ((routing.objectid = ai_entity1_id::varchar) OR
(routing.objectid = ai_entity2_id::varchar)) and 
 routing.activeflag=1 and routing.eventcode= 'SRVC';

select CASE 
                            WHEN county like '%Allegany%' THEN '1427' -- Allegany               
                                WHEN county like '%Anne Arundel%' THEN '1428' -- Anne Arundel
                                WHEN county like '%Baltimore County%' THEN '1430' -- Baltimore County
                                WHEN county like '%Calvert%' THEN '1431' -- CALVERT COUNTY
                                WHEN county like '%Caroline%' THEN '1432' -- CAROLINE COUNTY
                                WHEN county like '%Carroll%' THEN '1433' -- CARROLL COUNTY
                                WHEN county like '%Cecil%' THEN '1434' -- CECIL COUNTY
                                WHEN county like '%Charles%' THEN '1435' -- CHARLES COUNTY
                                WHEN county like '%Dorchester%' THEN '1436' -- DORCHESTER COUNTY
                                WHEN county like '%Frederick%' THEN '1437' -- FREDERICK COUNTY
                                WHEN county like '%Garrett%' THEN '1438' -- GARRETT COUNTY
                                WHEN county like '%Harford%' THEN '1439' -- HARFORD COUNTY
                                WHEN county like '%Howard%' THEN '1440' -- HOWARD COUNTY
                                WHEN county like '%Kent%' THEN '1441' -- KENT COUNTY
                                WHEN county like '%Montgomery%' THEN '1442' -- MONTGOMERY COUNTY
                                WHEN county like '%Prince George%' THEN '1443' -- PRINCE GEORGES COUNTY
                                WHEN county like '%Queen Anne%' THEN '1444' -- QUEEN ANNES COUNTY
                                WHEN county like '%St. Mary%' THEN '1446' -- ST. MARYS COUNTY
                                WHEN county like '%Somerset%' THEN '1445' -- SOMERSET COUNTY
                                WHEN county like '%Talbot%' THEN '1447' -- TALBOT COUNTY
                                WHEN county like '%Washington%' THEN '1448' -- WASHINGTON COUNTY
                                WHEN county like '%Wicomico%' THEN '1449' -- WICOMICO COUNTY
                                WHEN county like '%Worcester%' THEN '1450' -- WORCESTER COUNTY
                                WHEN county like '%Baltimore City%' THEN '1429' -- BALTIMORE CITY
                                WHEN county like '%DHR%' THEN '3824' -- DHR/SSA
                              
                      END
 into county_id from userprofileaddress where securityusersid = sec_id::character varying; 
	 
END ;
$BODY$;

