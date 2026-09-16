/*
   Issue Description: CDM-37932 Incorrect Child Listed Under Permanency Plan
   Category/ Module  : Permanency plan
   Root cause: Kehlani Robinson doesn't belong to the case 3293191. the client is listed under the permanency plan section in this case.
   Fix Provided : Kehlani Robinson should be removed from the Permanency Plan section 
*/

select *from permanencyplan where servicecaseid='b36c29a0-70e3-4c6c-8a3a-b5e1d0d84148';

update permanencyplan 
set activeflag = 0, 
updatedby = 'CDM-37932', 
updatedon = now () 
where permanencyplanid = '30e205ff-56ce-4dcd-b2d5-c03d61d1da42';

select * from routing
where objectid = '30e205ff-56ce-4dcd-b2d5-c03d61d1da42'
and activeflag = 1;

update routing 
set activeflag =0,
updatedby = 'CDM-37932', 
updatedon = now () 
where objectid = '30e205ff-56ce-4dcd-b2d5-c03d61d1da42'
