-- CDM-14529 -  FM125R Revised Maint Pymt Stmt 
/*
-- Issue Description: 
   Placement Data Integrity issue (Multiple placements associated with inactive Removal) 
   
   Removal									Removal_ID	Period					Active Flag/ Audit Coilumns
   -----------------------------------------------------------------------------------------------------------------
    9ee7577b-bf85-45cb-b755-a2fdc284f4bb	174011		2015-05-18 To Current 	1	CIDM-2505	2021-05-03 19:16:27
	aa665f3d-e98f-4b57-8a3b-4c64f7c13677	251143		2013-11-29 To Current 	0	CDM-15053	2021-08-10 19:45:25

-- Category/ Module: Placements  (Case Management) 
-- Root cause: 
	Prior fix was done for CDM-15053 on 08/10/2021 to soft delete the removalid # 251143 (11/29/2013 to Current), 
	but this removal is having associated placements,
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- This datafix is to link those placements wih the approved/active removal. 
-- Placement
-- Update Removal ID
select activeflag, alternateid, altproviderid, startdatetime, enddatetime, updatedby, updatedon 
	from placement 
where intakeservreqchildremovalid = 'aa665f3d-e98f-4b57-8a3b-4c64f7c13677'
	and activeflag = 1
order by startdatetime ;

-- Removal
-- 0de8ab41-5c0e-42c5-9160-d58c1fd4470e - # 174011
update placement
set intakeservreqchildremovalid = '9ee7577b-bf85-45cb-b755-a2fdc284f4bb',
	updatedon = now(), 
	updatedby = 'CDM-14529'
where intakeservreqchildremovalid = 'aa665f3d-e98f-4b57-8a3b-4c64f7c13677'
	and activeflag = 1 ;

