/*
Audit columns are not updated for table personeducation
Pr Number: 5698
*/


update personeducation 
set updatedby = 'CIDM-4763', updatedon = insertedon 
where updatedby is null and updatedon is null;