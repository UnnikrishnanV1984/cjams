/*
   Issue Description: CDM-23827
   Category/ Module  : Remove service case
   Root cause: user created in error so delete service case
   Pull request# for code fix: 5311
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/

update servicecase set activeflag =0, updatedby = 'CDM-23827', updatedon = now() 
where servicecaseid = '2ffa4388-353f-494a-9830-dbd3621725b1';

update servicecasedisposition set activeflag = 0, updatedby = 'CDM-23827', updatedon = now() 
where servicecaseid = '2ffa4388-353f-494a-9830-dbd3621725b1';

select * from routing where servicerequestnumber  ='221030016585'; --no records in routing 
