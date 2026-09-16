/*
   Issue Description: CDM-36172
   Category/ Module  : case
   Root cause: As requested by user
   Fix Privided: removed the case as requested
*/

select activeflag,* from routing where objectid ='2d3ac6a7-07fb-44c2-ae61-64bf7099f4cd';

update routing
set activeflag =0, updatedby ='CDM-36172', updatedon =now()
where objectid ='2d3ac6a7-07fb-44c2-ae61-64bf7099f4cd' and activeflag =1;