-- Duplicate Payments and NO ARs Production Issue
/*
-- Issue Description: 
	S20210126028306  CJAMS 18113  Second Family (5001652) 			- CDM-13055
	S20210126028307  Day By Day Residential Service, Inc. (5001569) - CDM-13056
	S20210126028309  Challengers Independent Living, Inc. (5001321) - CDM-13057
	S20210126028310  Center for Social Change, Inc (5001682) 		- CDM-13058
	S20210126028305  M.A.G.I.C, Inc. (5001278) 						- CDM-13059
	S20210126028304  Care With Class, Inc. (5001403)				- CDM-13060

-- Category/ Module: Account Receivables (Finance Management) 
-- Root cause: CJAMS failed to identify a duplicate payment for the client and generate an Accounts Receivable (Overpayment).
-- Pull request# TBD
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: TBD
*/

-- Datafix to Trigger Under/Over Batch for ARs

-- CDM-13055 - Duplicate Payment No A/R
------------------------------------------------------------------------------------
-- Private Organization: 5001652 (Second Family, Inc.)
-- Client ID: 1270695 (KAYSHA WILLIAMS) - 83579a9f-0336-4d2e-abf1-fdf2be4e61c8
-- Placement ID: 291985 - 01/14/2014 to 03/01/2021
-- Maintenance Payment ID: 3014868 - 04/13/2021 (Gross $1218475.77)
-- Service Period March 2021 --> $35193.68

select placement_id, validation_start_dt, validation_end_dt, validation_status_cd,
	update_ts, update_user_id 
from tb_placement_validation 
where placement_validation_id = 1953419
	and delete_sw = 'N' ;
	
update tb_placement_validation
set validation_status_cd = '1750',
	update_ts = now(),
	update_user_id = 'CDM-13055'
where placement_validation_id = 1953419
	and delete_sw = 'N' ;


-- CDM-13056 - Duplicate Payment No Accounts Receivable
------------------------------------------------------------------------------------
-- Private Organization: 5001569 (Day By Day Residential Services, Inc.)
-- Client ID: 4223399 (JUSTICE STINYARD) - d40c895b-0387-42d3-b607-a23193acb133
-- Placement ID: 1557058 - 08/23/2020 to 03/01/2021
-- Maintenance Payment ID: 3014856 - 04/13/2021 (Gross $117349.26)
-- Service Period March 2021 --> $24366.00

select placement_id, validation_start_dt, validation_end_dt, validation_status_cd,
	update_ts, update_user_id 
from tb_placement_validation 
where placement_validation_id = 1955202
	and delete_sw = 'N' ;

update tb_placement_validation
set validation_status_cd = '1750',
	update_ts = now(),
	update_user_id = 'CDM-13056'
where placement_validation_id = 1955202
	and delete_sw = 'N' ;


-- CDM-13057 - Duplicate Payment No Accounts Receivable
------------------------------------------------------------------------------------
-- Private Organization: 5001321 (Challengers Independent Living, Inc.)
-- Client ID: 200159705	(NORMA Martinez	RAMOS) - 18ebd84b-bc97-4ad9-908e-0831cc502380
-- Placement ID: 1558478 - 10/15/2020 to 03/01/2021
-- Maintenance Payment ID: 3014840 - 04/13/2021 (Gross $186780.92)
-- Service Period March 2021 --> $6426.92

select placement_id, validation_start_dt, validation_end_dt, validation_status_cd,
	update_ts, update_user_id 
from tb_placement_validation 
where placement_validation_id = 1955384
	and delete_sw = 'N' ;

update tb_placement_validation
set validation_status_cd = '1750',
	update_ts = now(),
	update_user_id = 'CDM-13057'
where placement_validation_id = 1955384
	and delete_sw = 'N' ;

-- CDM-13058 - Duplicate Payment No Accounts Receivable
------------------------------------------------------------------------------------
-- Private Organization: 5001682 (Center for Social Change, Inc)
-- Client ID: 3514151 (JUAN	CARLOS VASQUEZ) - 3d7446cf-a1a8-479d-8b6f-c4c96a05974c
-- Placement ID: 333965 - 04/05/2019 to 03/01/2021
-- Maintenance Payment ID: 3014866 - 04/13/2021 (Gross $266716.65)
-- Service Period March 2021 --> $13609.00

select placement_id, validation_start_dt, validation_end_dt, validation_status_cd,
	update_ts, update_user_id 
from tb_placement_validation 
where placement_validation_id = 1954096
	and delete_sw = 'N' ;

update tb_placement_validation
set validation_status_cd = '1750',
	update_ts = now(),
	update_user_id = 'CDM-13058'
where placement_validation_id = 1954096
	and delete_sw = 'N' ;
	

-- CDM-13059 - No Accounts Receivable for Duplicate Payment
------------------------------------------------------------------------------------
-- Private Organization: 5001278 (Making A Great Individual Contribution, Inc.)
-- Client ID: 200020216	(Nevaeh	Simmons) - 094947cb-1eb4-4ae4-b5fc-c3e1ed586eca
-- Placement ID: 1556526 - 07/14/2020 to 03/01/2021
-- Maintenance Payment ID: 3014855 - 04/13/2021 (Gross $67295.34)
-- Service Period March 2021 --> $13609.00

select placement_id, validation_start_dt, validation_end_dt, validation_status_cd,
	update_ts, update_user_id 
from tb_placement_validation 
where placement_validation_id = 1955140
	and delete_sw = 'N' ;

update tb_placement_validation
set validation_status_cd = '1750',
	update_ts = now(),
	update_user_id = 'CDM-13059'
where placement_validation_id = 1955140
	and delete_sw = 'N' ;


-- CDM-13060 - No Accounts Receivable -Duplicate Payment
------------------------------------------------------------------------------------
-- Private Organization: 5001403 (Care With Class, Inc.)
-- Client ID: 3988327 (ISAIAH SANDERS) - 8158eb4b-8411-4606-a09d-7be3ec529567
-- Placement ID: 337276 - 10/08/2019 to 03/01/2021
-- Maintenance Payment ID: 3014841 - 04/13/2021 (Gross $24005.56)
-- Service Period March 2021 --> $6380.11

select placement_id, validation_start_dt, validation_end_dt, validation_status_cd,
	update_ts, update_user_id 
from tb_placement_validation 
where placement_validation_id = 1954424
	and delete_sw = 'N' ;

update tb_placement_validation
set validation_status_cd = '1750',
	update_ts = now(),
	update_user_id = 'CDM-13060'
where placement_validation_id = 1954424
	and delete_sw = 'N' ;
