/*   Issue Description: To revert the inserted records
   Category/ Module  :  Service log
   Root cause: user added the new role in as.
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
   Backup before update/ delete:
    https://source.mdthink.maryland.gov/projects/DHSCJAMS/repos/cjams_db_scripts/pull-requests/3769/diff#DML/B-113799_Master_data_script.sql

*/


delete prov.tb_services where service_id in (
'13032',
'13033',
'13034',
'13035',
'13036',
'13037',
'13038',
'13039'
);