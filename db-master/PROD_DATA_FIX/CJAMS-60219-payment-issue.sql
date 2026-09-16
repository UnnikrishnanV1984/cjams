/*
Issue Description:CJAMS-60219 payment issue
Category/Module: Payments
Root cause: The new removal created on 06/02/2025 and approved on 06/04/2025 with removal start date was entered on 08/16/2023 so the system created an auto suspension with start date 09/16/2023.
            The GAP agreement and subsidy rate start date is entered with 05/20/2025, so there will be no GAP payment prior to 05/20/2025
            Data fix needs to be done to remove the system generated suspension as the part of this fix.
Fix provided: Data fix is done to remove the GAP suspension 
Data/Code fix ticket#:CJAMS-60219
Regression Impacts: N/A
Is Code fix Required?: NO
Code fix ticket#: N/A
Reason why no related code fix: Issue happened to incorrect void of previous placement and data fix is needed to resolve it.
*/

update gapsuspension
set activeflag = 0,
	updatedby = 'CJAMS-60219', 
	updatedon = now() 
where gapsuspensionid = '6e6572bd-9a7b-4a23-8a52-1344a4ae88a9'
	and activeflag = 1 ;

update gapsuspensionrevision
set activeflag = 0,
	updatedby = 'CJAMS-60219', 
	updatedon = now() 
where suspensionid = '6e6572bd-9a7b-4a23-8a52-1344a4ae88a9'
	and activeflag = 1 ;

update routing
set activeflag = 0,
	updatedby = 'CJAMS-60219',
	updatedon = now() 
where objectid = '6e6572bd-9a7b-4a23-8a52-1344a4ae88a9'
	and activeflag = 1 ;


--updating gapraterevision table to trigger finance batch.

update gapratesrevision
set approvalDate = now(),
    updatedby = 'CJAMS-60219',
    updatedon = now()
where gaprateid='26e8f344-7b75-41f4-90eb-6327580842f4'
and activeflag = 1;  
