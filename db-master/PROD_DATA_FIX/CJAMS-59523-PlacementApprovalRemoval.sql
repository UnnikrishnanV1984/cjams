
/*
Issue Description: the payment needs to be released for the Kinship provider Id: 6042916 (ERICA DAVIS) for the placement of the Client Id: 200887592 (Lanaya Davis) dated (12/12/2024 - 04/09/2025).
Root cause: Removal end date was cleared before re-entering placement,preventing provider data from populatingcorrectly.
Fix provided: Data fix has been done to update the data placement,tb_provider table.
Data/Code fix ticket#: CJAMS-59523
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: This is a data entry/order of operations issue, not a bug in the application.
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/

update placement 
set altproviderid = '6042916', updatedby = 'CJAMS-59523', updatedon = now()
where placementid  = '38463798-e0c2-4ee8-94c3-389e66a461ca' and activeflag =1;


update prov.tb_provider
set withhold_payment_sw = 'Y' , update_user_id = 'CJAMS-59523', update_ts = now()
where provider_id = '6042916' and delete_sw = 'N' ;






