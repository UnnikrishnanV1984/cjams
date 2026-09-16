-- CDM-40364 - Inaccurate Overpayment
/*
-- Issue Description: 
   The provider #5095362 only received an adoption payment from 2/28/2024 - 2/29/2024 for 3 children. 
   The work to enter the adopion subisdy occurred 2/28/2024, but should not cause the payment to start on 2/28/2024. 
   
-- Category/ Module: Adoption Subsidy (Finance Management) 
-- Root cause: On the bio case side adoption start date and the rate start was entered as 02/28/2024.
		and on then on the adoption case side the start date was updated to 02/16/2024.
-- Fix Provided: Datafix has been promoted to fix the adoptioncase start date as 02/16/2024 for all 3 cases.
-- Pull request# N/A 
-- Reason why no related code fix: Please replicate this issue in Stage 3 and create CDIM for the code fix.
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- To update Adoption Case Start dates & delete wrong ARs (CDM-40364) 

update adoptioncase ad
set startdate = aa.startdate,
	updatedon = now(),
	updatedby = 'CDM-40364'
from adoptioncaseagreement aa  
where aa.adoptioncaseid  = ad.adoptioncaseid
	and	ad.activeflag = 1
	and ad.startdate::date <> aa.startdate::date 
	and ad.updatedon::date >= '2024-07-16'::date
	-- and ad.alternateid = 23662
	;
	
-- Delete ARs
-- Prince George's	3181221	2855202	 23662	8/1/2024	3/7/2028	8/29/2009	3/7/2028	7/17/24 4:25 PM	5011505 - $145170.45	Prince George's
-- receivable_id 231382
update tb_receivable_collection_status
set delete_sw = 'Y',
	update_ts = now(),
	update_user_id = 'CDM-40364'
where delete_sw = 'N'
	and receivable_detail_id 
		in ( 
			1747115, 1747116, 1747117, 1747118, 1747119, 1747120, 1747121, 1747122, 1747123, 1747124,
			1747125, 1747126,1747127, 1747128, 1747129, 1747130, 1747131, 1747132, 1747133, 1747134, 1747135,
			1747136, 1747137,1747138, 1747139, 1747140, 1747141, 1747142, 1747143, 1747144, 1747145, 1747146,
			1747147, 1747148,1747149, 1747150, 1747151, 1747152, 1747153, 1747154, 1747155, 1747156, 1747157,
			1747158, 1747159,1747160, 1747161, 1747162, 1747163, 1747164, 1747165, 1747166, 1747167, 1747168,
			1747169, 1747170,1747171, 1747172, 1747173, 1747174, 1747175, 1747176, 1747177, 1747178, 1747179,
			1747180, 1747181,1747182, 1747183, 1747184, 1747185, 1747186, 1747187, 1747188, 1747189, 1747190,
			1747191, 1747192,1747193, 1747194, 1747195, 1747196, 1747197, 1747198, 1747199, 1747200, 1747201,
			1747202, 1747203,1747204, 1747205, 1747206, 1747207, 1747208, 1747209, 1747210, 1747211, 1747212,
			1747213, 1747214,1747215, 1747216, 1747217, 1747218, 1747219, 1747220, 1747221, 1747222, 1747223,
			1747224, 1747225,1747226, 1747227, 1747228, 1747229, 1747230, 1747231, 1747232, 1747233, 1747234,
			1747235, 1747236,1747237, 1747238, 1747239, 1747240, 1747241, 1747242, 1747243, 1747244, 1747245,
			1747246, 1747247,1747248, 1747249, 1747250, 1747251, 1747252, 1747253, 1747254, 1747255, 1747256,
			1747257, 1747258,1747259, 1747260, 1747261, 1747262, 1747263, 1747264, 1747265, 1747266, 1747267,
			1747268, 1747269,1747270, 1747271, 1747272, 1747273, 1747274, 1747275, 1747276, 1747277, 1747278,
			1747279, 1747280,1747281, 1747282, 1747283, 1747284, 1747285, 1747286, 1747287, 1747288 
			);
	
update tb_receivable_detail
set delete_sw = 'Y',
	update_ts = now(),
	update_user_id = 'CDM-40364'
where delete_sw = 'N'
	and receivable_detail_id 
		in ( 
			1747115, 1747116, 1747117, 1747118, 1747119, 1747120, 1747121, 1747122, 1747123, 1747124,
			1747125, 1747126,1747127, 1747128, 1747129, 1747130, 1747131, 1747132, 1747133, 1747134, 1747135,
			1747136, 1747137,1747138, 1747139, 1747140, 1747141, 1747142, 1747143, 1747144, 1747145, 1747146,
			1747147, 1747148,1747149, 1747150, 1747151, 1747152, 1747153, 1747154, 1747155, 1747156, 1747157,
			1747158, 1747159,1747160, 1747161, 1747162, 1747163, 1747164, 1747165, 1747166, 1747167, 1747168,
			1747169, 1747170,1747171, 1747172, 1747173, 1747174, 1747175, 1747176, 1747177, 1747178, 1747179,
			1747180, 1747181,1747182, 1747183, 1747184, 1747185, 1747186, 1747187, 1747188, 1747189, 1747190,
			1747191, 1747192,1747193, 1747194, 1747195, 1747196, 1747197, 1747198, 1747199, 1747200, 1747201,
			1747202, 1747203,1747204, 1747205, 1747206, 1747207, 1747208, 1747209, 1747210, 1747211, 1747212,
			1747213, 1747214,1747215, 1747216, 1747217, 1747218, 1747219, 1747220, 1747221, 1747222, 1747223,
			1747224, 1747225,1747226, 1747227, 1747228, 1747229, 1747230, 1747231, 1747232, 1747233, 1747234,
			1747235, 1747236,1747237, 1747238, 1747239, 1747240, 1747241, 1747242, 1747243, 1747244, 1747245,
			1747246, 1747247,1747248, 1747249, 1747250, 1747251, 1747252, 1747253, 1747254, 1747255, 1747256,
			1747257, 1747258,1747259, 1747260, 1747261, 1747262, 1747263, 1747264, 1747265, 1747266, 1747267,
			1747268, 1747269,1747270, 1747271, 1747272, 1747273, 1747274, 1747275, 1747276, 1747277, 1747278,
			1747279, 1747280,1747281, 1747282, 1747283, 1747284, 1747285, 1747286, 1747287, 1747288 
			);

-- 	Update Provider AR Balances & Payment Plan		   
update tb_receivable_header rh
set balance_no 
		= coalesce(( select sum(rd.receivable_balance_no)
						from tb_receivable_detail rd
					 where rd.receivable_id = rh.receivable_id
						and rd.delete_sw = 'N'
						and ((rd.manual_sw = 'N') or (rd.manual_sw = 'Y' and rd.approval_status_cd = '3047'))
					),0),
	receivable_original_amount_no 
		= coalesce(( select sum(rd.amount_no)
						from tb_receivable_detail rd
					 where rd.receivable_id = rh.receivable_id
						and rd.delete_sw = 'N'
						and ((rd.manual_sw = 'N') or (rd.manual_sw = 'Y' and rd.approval_status_cd = '3047'))
					),0),					  
	written_off_amount_no
		= coalesce(( select sum(rd.written_off_amount_no)
						from tb_receivable_detail rd
					 where rd.receivable_id = rh.receivable_id
						and rd.delete_sw = 'N'
						and ((rd.manual_sw = 'N') or (rd.manual_sw = 'Y' and rd.approval_status_cd = '3047'))
					),0),
	update_ts = now(),
	update_user_id = 'CDM-40364'
where rh.delete_sw = 'N'  
	and rh.receivable_id = 231382 ;
		 
-- 	Update Payment Plan
update tb_payment_plan pp
set current_receivable_amount 
		= coalesce(( select sum(rd.receivable_balance_no)       
				      from tb_receivable_detail rd,
				           tb_receivable_collection_status rcs
				    where rcs.receivable_detail_id = rd.receivable_detail_id
				      and rd.receivable_id = pp.receivable_id
				      and rd.receivable_status_cd in ('19','22') 
				      and ((rd.manual_sw = 'N') or (rd.manual_sw = 'Y' and rd.approval_status_cd = '3047'))
				      and rd.delete_sw = 'N' 
				      and rcs.delete_sw = 'N'	
				      and rcs.active_sw = 'Y'   
				      and rcs.collection_status_cd <> '775'   
			    ),0),
    amount_no 
		= coalesce(((( select sum(rd.receivable_balance_no)       
				      from tb_receivable_detail rd,
				           tb_receivable_collection_status rcs
				    where rcs.receivable_detail_id = rd.receivable_detail_id
				      and rd.receivable_id = pp.receivable_id
				      and rd.receivable_status_cd in ('19','22') 
				      and ((rd.manual_sw = 'N') or (rd.manual_sw = 'Y' and rd.approval_status_cd = '3047'))
				      and rd.delete_sw = 'N' 
				      and rcs.delete_sw = 'N'	
				      and rcs.active_sw = 'Y'   
				      and rcs.collection_status_cd <> '775'   
			    ) * pp.percentage_no ) / 100 ),0),
    update_ts = now(),
	update_user_id = 'CDM-40364'
where pp.delete_sw = 'N'
	and pp.end_dt is null 
	and pp.receivable_id = 231382 ;


 -- Harford	3283395	4177058	48157	2024-07-01	2034-08-31	2017-12-15	2034-08-31	2024-07-22 11:59:54.556	1254259 -  5083354 - $796.05	Harford
-- receivable_id  = 1254259

update tb_receivable_collection_status
set delete_sw = 'Y',
	update_ts = now(),
	update_user_id = 'CDM-40364'
where delete_sw = 'N'
	and receivable_detail_id = 1747587 ;
	
update tb_receivable_detail
set delete_sw = 'Y',
	update_ts = now(),
	update_user_id = 'CDM-40364'
where delete_sw = 'N'
	and receivable_detail_id = 1747587 ;

-- 	Update Provider AR Balances & Payment Plan		   
update tb_receivable_header rh
set balance_no 
		= coalesce(( select sum(rd.receivable_balance_no)
						from tb_receivable_detail rd
					 where rd.receivable_id = rh.receivable_id
						and rd.delete_sw = 'N'
						and ((rd.manual_sw = 'N') or (rd.manual_sw = 'Y' and rd.approval_status_cd = '3047'))
					),0),
	receivable_original_amount_no 
		= coalesce(( select sum(rd.amount_no)
						from tb_receivable_detail rd
					 where rd.receivable_id = rh.receivable_id
						and rd.delete_sw = 'N'
						and ((rd.manual_sw = 'N') or (rd.manual_sw = 'Y' and rd.approval_status_cd = '3047'))
					),0),					  
	written_off_amount_no
		= coalesce(( select sum(rd.written_off_amount_no)
						from tb_receivable_detail rd
					 where rd.receivable_id = rh.receivable_id
						and rd.delete_sw = 'N'
						and ((rd.manual_sw = 'N') or (rd.manual_sw = 'Y' and rd.approval_status_cd = '3047'))
					),0),
	update_ts = now(),
	update_user_id = 'CDM-40364'
where rh.delete_sw = 'N'  
	and rh.receivable_id = 1254259 ;
		 
-- 	Update Payment Plan
update tb_payment_plan pp
set current_receivable_amount 
		= coalesce(( select sum(rd.receivable_balance_no)       
				      from tb_receivable_detail rd,
				           tb_receivable_collection_status rcs
				    where rcs.receivable_detail_id = rd.receivable_detail_id
				      and rd.receivable_id = pp.receivable_id
				      and rd.receivable_status_cd in ('19','22') 
				      and ((rd.manual_sw = 'N') or (rd.manual_sw = 'Y' and rd.approval_status_cd = '3047'))
				      and rd.delete_sw = 'N' 
				      and rcs.delete_sw = 'N'	
				      and rcs.active_sw = 'Y'   
				      and rcs.collection_status_cd <> '775'   
			    ),0),
    amount_no 
		= coalesce(((( select sum(rd.receivable_balance_no)       
				      from tb_receivable_detail rd,
				           tb_receivable_collection_status rcs
				    where rcs.receivable_detail_id = rd.receivable_detail_id
				      and rd.receivable_id = pp.receivable_id
				      and rd.receivable_status_cd in ('19','22') 
				      and ((rd.manual_sw = 'N') or (rd.manual_sw = 'Y' and rd.approval_status_cd = '3047'))
				      and rd.delete_sw = 'N' 
				      and rcs.delete_sw = 'N'	
				      and rcs.active_sw = 'Y'   
				      and rcs.collection_status_cd <> '775'   
			    ) * pp.percentage_no ) / 100 ),0),
    update_ts = now(),
	update_user_id = 'CDM-40364'
where pp.delete_sw = 'N'
	and pp.end_dt is null 
	and pp.receivable_id = 1254259 ;
	
	
-- Baltimore City	241040312447	202895741	1068897	2024-04-25	2040-04-23	2024-04-24	2040-04-23	2024-07-18 14:44:49.262	1254260 -  5087882 - $29.16	Baltimore City
-- receivable_id  = 1254260

update tb_receivable_collection_status
set delete_sw = 'Y',
	update_ts = now(),
	update_user_id = 'CDM-40364'
where delete_sw = 'N'
	and receivable_detail_id = 1747588 ;
	
update tb_receivable_detail
set delete_sw = 'Y',
	update_ts = now(),
	update_user_id = 'CDM-40364'
where delete_sw = 'N'
	and receivable_detail_id = 1747588 ;

-- 	Update Provider AR Balances & Payment Plan		   
update tb_receivable_header rh
set balance_no 
		= coalesce(( select sum(rd.receivable_balance_no)
						from tb_receivable_detail rd
					 where rd.receivable_id = rh.receivable_id
						and rd.delete_sw = 'N'
						and ((rd.manual_sw = 'N') or (rd.manual_sw = 'Y' and rd.approval_status_cd = '3047'))
					),0),
	receivable_original_amount_no 
		= coalesce(( select sum(rd.amount_no)
						from tb_receivable_detail rd
					 where rd.receivable_id = rh.receivable_id
						and rd.delete_sw = 'N'
						and ((rd.manual_sw = 'N') or (rd.manual_sw = 'Y' and rd.approval_status_cd = '3047'))
					),0),					  
	written_off_amount_no
		= coalesce(( select sum(rd.written_off_amount_no)
						from tb_receivable_detail rd
					 where rd.receivable_id = rh.receivable_id
						and rd.delete_sw = 'N'
						and ((rd.manual_sw = 'N') or (rd.manual_sw = 'Y' and rd.approval_status_cd = '3047'))
					),0),
	update_ts = now(),
	update_user_id = 'CDM-40364'
where rh.delete_sw = 'N'  
	and rh.receivable_id = 1254260 ;
		 
-- 	Update Payment Plan
update tb_payment_plan pp
set current_receivable_amount 
		= coalesce(( select sum(rd.receivable_balance_no)       
				      from tb_receivable_detail rd,
				           tb_receivable_collection_status rcs
				    where rcs.receivable_detail_id = rd.receivable_detail_id
				      and rd.receivable_id = pp.receivable_id
				      and rd.receivable_status_cd in ('19','22') 
				      and ((rd.manual_sw = 'N') or (rd.manual_sw = 'Y' and rd.approval_status_cd = '3047'))
				      and rd.delete_sw = 'N' 
				      and rcs.delete_sw = 'N'	
				      and rcs.active_sw = 'Y'   
				      and rcs.collection_status_cd <> '775'   
			    ),0),
    amount_no 
		= coalesce(((( select sum(rd.receivable_balance_no)       
				      from tb_receivable_detail rd,
				           tb_receivable_collection_status rcs
				    where rcs.receivable_detail_id = rd.receivable_detail_id
				      and rd.receivable_id = pp.receivable_id
				      and rd.receivable_status_cd in ('19','22') 
				      and ((rd.manual_sw = 'N') or (rd.manual_sw = 'Y' and rd.approval_status_cd = '3047'))
				      and rd.delete_sw = 'N' 
				      and rcs.delete_sw = 'N'	
				      and rcs.active_sw = 'Y'   
				      and rcs.collection_status_cd <> '775'   
			    ) * pp.percentage_no ) / 100 ),0),
    update_ts = now(),
	update_user_id = 'CDM-40364'
where pp.delete_sw = 'N'
	and pp.end_dt is null 
	and pp.receivable_id = 1254260 ;

	
-- Baltimore City	3231548	3597131	39107	2024-11-01	2027-12-14	2013-11-26	2027-12-14	2024-07-17 11:40:36.794	240961 -  5063647 - $119923.20	Baltimore City
-- receivable_id  = 240961
update tb_receivable_collection_status
set delete_sw = 'Y',
	update_ts = now(),
	update_user_id = 'CDM-40364'
where delete_sw = 'N'
	and receivable_detail_id 
		in ( 
			1747325, 1747326, 1747327, 1747328, 1747329, 1747330, 1747331, 1747332, 1747333, 1747334,
			1747335, 1747336, 1747337, 1747338, 1747339, 1747340, 1747341, 1747342, 1747343, 1747344,
			1747345, 1747346, 1747347, 1747348, 1747349, 1747350, 1747351, 1747352, 1747353, 1747354,
			1747355, 1747356, 1747357, 1747358, 1747359, 1747360, 1747361, 1747362, 1747363, 1747364,
			1747365, 1747366, 1747367, 1747368, 1747369, 1747370, 1747371, 1747372, 1747373, 1747374,
			1747375, 1747376, 1747377, 1747378, 1747379, 1747380, 1747381, 1747382, 1747383, 1747384,
			1747385, 1747386, 1747387, 1747388, 1747389, 1747390, 1747391, 1747392, 1747393, 1747394,
			1747395, 1747396, 1747397, 1747398, 1747399, 1747400, 1747401, 1747402, 1747403, 1747404,
			1747405, 1747406, 1747407, 1747408, 1747409, 1747410, 1747411, 1747412, 1747413, 1747414,
			1747415, 1747416, 1747417, 1747418, 1747419, 1747420, 1747421, 1747422, 1747423, 1747424,
			1747425, 1747426, 1747427, 1747428, 1747429, 1747430, 1747431, 1747432, 1747433, 1747434,
			1747435, 1747436, 1747437, 1747438, 1747439, 1747440, 1747441, 1747442, 1747443, 1747444,
			1747445, 1747446, 1747447, 1747448, 1747449, 1747450, 1747451
			);
	
update tb_receivable_detail
set delete_sw = 'Y',
	update_ts = now(),
	update_user_id = 'CDM-40364'
where delete_sw = 'N'
	and receivable_detail_id 
		in ( 
			1747325, 1747326, 1747327, 1747328, 1747329, 1747330, 1747331, 1747332, 1747333, 1747334,
			1747335, 1747336, 1747337, 1747338, 1747339, 1747340, 1747341, 1747342, 1747343, 1747344,
			1747345, 1747346, 1747347, 1747348, 1747349, 1747350, 1747351, 1747352, 1747353, 1747354,
			1747355, 1747356, 1747357, 1747358, 1747359, 1747360, 1747361, 1747362, 1747363, 1747364,
			1747365, 1747366, 1747367, 1747368, 1747369, 1747370, 1747371, 1747372, 1747373, 1747374,
			1747375, 1747376, 1747377, 1747378, 1747379, 1747380, 1747381, 1747382, 1747383, 1747384,
			1747385, 1747386, 1747387, 1747388, 1747389, 1747390, 1747391, 1747392, 1747393, 1747394,
			1747395, 1747396, 1747397, 1747398, 1747399, 1747400, 1747401, 1747402, 1747403, 1747404,
			1747405, 1747406, 1747407, 1747408, 1747409, 1747410, 1747411, 1747412, 1747413, 1747414,
			1747415, 1747416, 1747417, 1747418, 1747419, 1747420, 1747421, 1747422, 1747423, 1747424,
			1747425, 1747426, 1747427, 1747428, 1747429, 1747430, 1747431, 1747432, 1747433, 1747434,
			1747435, 1747436, 1747437, 1747438, 1747439, 1747440, 1747441, 1747442, 1747443, 1747444,
			1747445, 1747446, 1747447, 1747448, 1747449, 1747450, 1747451
			);

-- 	Update Provider AR Balances & Payment Plan		   
update tb_receivable_header rh
set balance_no 
		= coalesce(( select sum(rd.receivable_balance_no)
						from tb_receivable_detail rd
					 where rd.receivable_id = rh.receivable_id
						and rd.delete_sw = 'N'
						and ((rd.manual_sw = 'N') or (rd.manual_sw = 'Y' and rd.approval_status_cd = '3047'))
					),0),
	receivable_original_amount_no 
		= coalesce(( select sum(rd.amount_no)
						from tb_receivable_detail rd
					 where rd.receivable_id = rh.receivable_id
						and rd.delete_sw = 'N'
						and ((rd.manual_sw = 'N') or (rd.manual_sw = 'Y' and rd.approval_status_cd = '3047'))
					),0),					  
	written_off_amount_no
		= coalesce(( select sum(rd.written_off_amount_no)
						from tb_receivable_detail rd
					 where rd.receivable_id = rh.receivable_id
						and rd.delete_sw = 'N'
						and ((rd.manual_sw = 'N') or (rd.manual_sw = 'Y' and rd.approval_status_cd = '3047'))
					),0),
	update_ts = now(),
	update_user_id = 'CDM-40364'
where rh.delete_sw = 'N'  
	and rh.receivable_id = 240961 ;
		 
-- 	Update Payment Plan
update tb_payment_plan pp
set current_receivable_amount 
		= coalesce(( select sum(rd.receivable_balance_no)       
				      from tb_receivable_detail rd,
				           tb_receivable_collection_status rcs
				    where rcs.receivable_detail_id = rd.receivable_detail_id
				      and rd.receivable_id = pp.receivable_id
				      and rd.receivable_status_cd in ('19','22') 
				      and ((rd.manual_sw = 'N') or (rd.manual_sw = 'Y' and rd.approval_status_cd = '3047'))
				      and rd.delete_sw = 'N' 
				      and rcs.delete_sw = 'N'	
				      and rcs.active_sw = 'Y'   
				      and rcs.collection_status_cd <> '775'   
			    ),0),
    amount_no 
		= coalesce(((( select sum(rd.receivable_balance_no)       
				      from tb_receivable_detail rd,
				           tb_receivable_collection_status rcs
				    where rcs.receivable_detail_id = rd.receivable_detail_id
				      and rd.receivable_id = pp.receivable_id
				      and rd.receivable_status_cd in ('19','22') 
				      and ((rd.manual_sw = 'N') or (rd.manual_sw = 'Y' and rd.approval_status_cd = '3047'))
				      and rd.delete_sw = 'N' 
				      and rcs.delete_sw = 'N'	
				      and rcs.active_sw = 'Y'   
				      and rcs.collection_status_cd <> '775'   
			    ) * pp.percentage_no ) / 100 ),0),
    update_ts = now(),
	update_user_id = 'CDM-40364'
where pp.delete_sw = 'N'
	and pp.end_dt is null 
	and pp.receivable_id = 240961 ;	
	
	