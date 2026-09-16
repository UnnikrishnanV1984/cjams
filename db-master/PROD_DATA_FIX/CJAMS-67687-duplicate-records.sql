/*
    Issue Description: CJAMS-67687
    Category/ Module: person 
    Root cause: User is not able to add the person due to the existing active duplicate records with cisclientid which is causing the error. 
    Fix Provided: Data fix provided by deleting the duplicate records. Now user should be able to add the person without any error
*/


update person 
set cisclientid = null, activeflag =0, updatedby ='CJAMS-67687', updatedon =now()
where personid ='cc82da90-87ea-407c-a7eb-49455173609a' and cjamspid ='201010171' and activeflag =1;

update personidentifier 
set activeflag =0, updatedby ='CJAMS-67687', updatedon =now()
where personid = 'cc82da90-87ea-407c-a7eb-49455173609a'
and personidentifiertypekey  = 'MDM_ID'
and activeflag  = 1;