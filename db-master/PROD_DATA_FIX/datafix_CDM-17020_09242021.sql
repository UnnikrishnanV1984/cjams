-- CDM-17020 - payment re-stamping
/*
-- Issue Description: 
   Adoption payments are not being re-stamped to federal. 
	Here is a list so far: Aiden Nelson 200778762, Tyshawn Jenkins 200642804 
	Logan Smith-Koritzer 200153887, Kylie Rose 200662189, Cristella Sayers 200314238 
	Princeton Baker 200570860
    
-- Category/ Module: Accounts Payable (Finance Management) 
-- Root cause: Finance is not able to read the Eligibility Status as Start Date is missing 
--			   in the IV-E table. 
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: 09/22 Build
*/

-- Payment Correction for
/*
Adop_id	Client ID	Client Name						Approval Date Payments
------------------------------------------------------------------------------------------
1050966	200153887	LOGAN Smith-Koritzer			2021-06-24 	  06/21, 07/21, 08/21
1051108	200314238	CRISTELLA Annabella Nichole 	2021-06-03    06/21, 07/21, 08/21
					Baumgardner	Sayers
1050989	200570860	Princeton Alexander	Baker		2021-03-31    03/21, 04/21, 05/21, 06/21, 07/21, 08/21
1051147	200642804	TY'SHAWN Jackson				2021-07-20    07/21, 08/21
1051169	200662189	Kylie Nicole Pucino Amin Rose	2021-06-14    06/21, 07/21, 08/21
1051188	200778762	AIDEN JAMES	Nelson				2021-08-03    08/21
*/

/*
-- Payments 
Detl ID	Pay ID	Pay Date	Start Date	End Date	Amout	Code	Adop ID
---------------------------------------------------------------------------
4241841	3080745	2021-09-01	2021-08-01	2021-08-31	903.96	7181 	1050966
4224795	3068190	2021-08-01	2021-07-01	2021-07-31	903.96	7181 	1050966
4207606	3055448	2021-07-01	2021-06-01	2021-06-30	874.80	7181 	1050966

4241940	3080817	2021-09-01	2021-08-01	2021-08-31	903.96	7181 	1051108
4224887	3068260	2021-08-01	2021-07-01	2021-07-31	903.96	7181 	1051108
4207696	3055514	2021-07-01	2021-06-01	2021-06-30	874.80	7181 	1051108

4241929	3080809	2021-09-01	2021-08-01	2021-08-31	1027.34	7181 	1050989
4224873	3068252	2021-08-01	2021-07-01	2021-07-31	1027.34	7181 	1050989
4207684	3055506	2021-07-01	2021-06-01	2021-06-30	994.20	7181 	1050989
4190798	3043202	2021-06-01	2021-05-01	2021-05-31	1027.34	7181 	1050989
4165789	3030650	2021-05-01	2021-04-01	2021-04-30	994.20	7181 	1050989
4149973	3019267	2021-04-01	2021-03-01	2021-03-31	1027.34	7181 	1050989

4241931	3080811	2021-09-01	2021-08-01	2021-08-31	903.96	7181 	1051147
4224875	3068254	2021-08-01	2021-07-01	2021-07-31	903.96	7181 	1051147

4241965	3080834	2021-09-01	2021-08-01	2021-08-31	903.96	7181 	1051169
4224911	3068276	2021-08-01	2021-07-01	2021-07-31	903.96	7181 	1051169
4207722	3055530	2021-07-01	2021-06-01	2021-06-30	874.80	7181 	1051169

4241882	3080777	2021-09-01	2021-08-01	2021-08-31	1027.34	7181 	1051188
*/

-- 2181 & 7181 - Adoption Subsidy
select payment_detail_id, final_service_start_dt, final_service_end_dt,
	final_fiscal_category_cd, subsidy_agreement_id, client_id, 
	update_ts, update_user_id 
from tb_payment_detail 
where payment_detail_id 
	in (4241841, 4224795, 4207606, 4241940, 4224887, 4207696, 4241929, 4224873, 4207684, 4190798, 
		4165789, 4149973, 4241931, 4224875, 4241965, 4224911, 4207722, 4241882)
	and delete_sw = 'N' 
order by final_service_start_dt;

update tb_payment_detail
set final_fiscal_category_cd = '2181',
	update_ts = now(),
	update_user_id = 'CDM-17020'
where payment_detail_id 
	in (4241841, 4224795, 4207606, 4241940, 4224887, 4207696, 4241929, 4224873, 4207684, 4190798, 
		4165789, 4149973, 4241931, 4224875, 4241965, 4224911, 4207722, 4241882)
	and delete_sw = 'N' 

