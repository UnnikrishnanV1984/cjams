/*
   Issue Description: CDM-22056
   Category/ Module  : Create new service case
   Root cause: service case was closed so creating new one
   Pull request# for code fix:6690
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/

update routing 
set updatedby = '959c3774-bfb3-4f52-9770-8b0487d4daf8', updatedon = now()
where objectid = 'I221010251670' and activeflag = 1;

select * from cjams.createservicecase('f1eae0c1-d7cf-4d79-b817-8c20d33a771f', null, 1, '959c3774-bfb3-4f52-9770-8b0487d4daf8', 'intake', '');