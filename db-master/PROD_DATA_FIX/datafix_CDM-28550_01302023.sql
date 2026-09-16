-- CDM-28550 - no case connect
/*
-- Issue Description: 
-- I231010402462:when approving a service case, no case connects to it
   
-- Category/ Module: Placement (Case Management) 
*/

select * from createservicecase('37bf64b8-b09c-4f90-965a-95747afd3fe1', null, 1,'4def862a-97a0-4f5d-9a53-5076470a5126', 'intake');
