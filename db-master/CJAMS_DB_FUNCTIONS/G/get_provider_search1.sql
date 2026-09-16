CREATE OR REPLACE FUNCTION cjams.get_provider_search(providerid integer, providername character varying, tax_id numeric, zip numeric, service_ids integer)
 RETURNS TABLE("ID" integer, provider_service_id bigint, "NAME" character varying, taxid numeric, zipcode numeric, service character varying, "Paid/NonPaid" character, service_id integer)
 LANGUAGE plpgsql
AS $function$
------------------------------------------------------------------------
-- Revision(s):
-- 05/10/2021 Vineet Tirodkar - Modifications for Provider schema changes (B-102023)
------------------------------------------------------------------------
/*DECLARE
V_ProviderID bigint := '5000275';
V_ProviderName character varying (100) := 'Klein''s Pharmacy';
V_taxId  numeric(9) := '5000275';
V_Zip    numeric(5) := '21040';  -- dont delete these variable.
*/

BEGIN
RETURN QUERY

SELECT  DISTINCT
 PR.Provider_ID AS ProviderID,PS.provider_service_id
,PR.Provider_nm AS ProviderName
,PR.tax_id_no AS TaxID
,PA.adr_zip5_no AS ZipCode
,CASE WHEN SE.structure_service_cd = 'S' AND paid_non_paid_cd::INTEGER IN ('3334','3335') THEN SE.Service_nm END AS Service
,CASE WHEN SE.structure_service_cd = 'S' AND paid_non_paid_cd::INTEGER IN ('3334','3335') THEN SE.paid_non_paid_cd  END AS "Paid/NonPaid"
,CASE WHEN SE.structure_service_cd = 'S' AND paid_non_paid_cd::INTEGER IN ('3334','3335') THEN SE.Service_id END AS Service_id
FROM TB_SERVICES SE
INNER JOIN TB_PROVIDER_SERVICES PS ON PS.Service_id = SE.Service_id  AND PS.paid_cd = SE.paid_non_paid_cd and PS.delete_sw='N'
INNER JOIN tb_provider PR ON PR.Provider_id = PS.Provider_id
INNER JOIN TB_PROVIDER_ADDRESSES PA ON PA.Parent_key_id::integer = PR.PROVIDER_ID and PA.delete_sw ='N'
WHERE 
SE.paid_non_paid_cd ='3334' and
 (providerid is null or PR.Provider_id = providerid)
and  (providername is null or PR.Provider_nm = providername)
and  (tax_id is null or PR.tax_id_no = tax_id)
and  (zip is null or PA.adr_zip5_no = zip)
and  (Service_ids is null or SE.Service_id = Service_ids);
 
--
--	PR.Provider_id = providerid 
--OR	PR.Provider_nm = providername
--OR	PR.tax_id_no = tax_id
--OR	PA.adr_zip5_no = zip
--OR	SE.Service_id = Service_ids;

END

$function$
;
