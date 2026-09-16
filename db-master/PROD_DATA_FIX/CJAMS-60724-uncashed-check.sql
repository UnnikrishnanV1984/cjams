
/*
-- Issue Description: 
    CJAMS ID 4265886-Update name and address on Final Disbursement Payment InformationThe Final Disbursement Check# 1987 dated 1/26/2024
    in the amount of $2800.94 in the name of Brendy Garcia, CJAMS ID 4265886 is uncashed and stale dated. 
    This check needs to be re-issued.Youth has since gotten married and her name and address have changed. 
    The youth is unable to cash the check with her maiden name.
    Requesting the youths name and address to be updated in CJAMS Final Disbursement system so that D365 can also be updated and the check can be reissued with the correct name.
    New NAME: Brendy MaddoxNew Address: 215 Lakeside Drive, Apt 203, Greenbelt ,
-- Resolution: Updated the child disbursement and payment header table
-- Category/ Module: Case Management
-- Root cause: User Request
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A

*/	
/*
select payee_nm,adr_street_nm,adr_city_nm,adr_county_cd,adr_state_cd,adr_zip5_no,* from tb_child_account_disbursement where client_account_id = '14783';
--1025586
--4027768    

select payee_nm,adr_street_nm,adr_city_nm,adr_county_cd,adr_state_cd,adr_zip5_no,* from tb_payment_header where payment_id = '4027768';
*/
--.New NAME: Brendy MaddoxNew Address: 215 Lakeside Drive, Apt 203, Greenbelt , MD 20770
update tb_child_account_disbursement
set payee_nm = 'BRENDY MADDOX',
	adr_street_nm = '215 LAKESIDE DRIVE, APT 203',
	update_user_id = 'CJAMS-60724',
	update_ts = now() 
where client_account_id = '14783';

update tb_payment_header
set payee_nm = 'BRENDY MADDOX',
	adr_street_nm = '215 LAKESIDE DRIVE, APT 203',
	update_user_id = 'CJAMS-60724',
	update_ts = now() 
where payment_id  = '4027768';