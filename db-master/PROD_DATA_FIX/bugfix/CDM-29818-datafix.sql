/*
   Issue Description: CDM-29818
   Category/ Module  : 
   Root cause: As requested by user
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/

update attorneyaddress set activeflag=0, updatedon = now(), updatedby ='CDM-29818' where 
attorneyaddressid in ('97cdd1c3-0d33-4d22-8030-aea8801a3634');
