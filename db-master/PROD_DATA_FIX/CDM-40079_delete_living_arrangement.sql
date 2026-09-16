/*
Issue Description: CDM-40079
-- Category/ Module: Living Arrangement (Case Management)
-- Root cause: User error.
-- Fix Provided: Datafix has been promoted to update the flag.
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/


update placement 
set activeflag =0, updatedby ='CDM-40079', updatedon =now()
where placementid = '73d8ab0f-247b-4580-bf26-5942925ffba5' and activeflag = 1;

update placementrevision 
set activeflag =0, updatedby ='CDM-40079', updatedon =now()
where placementid = '73d8ab0f-247b-4580-bf26-5942925ffba5' and activeflag = 1;

update livingarrangement 
set activeflag =0, updatedby ='CDM-40079', updatedon =now()
where placementid = '73d8ab0f-247b-4580-bf26-5942925ffba5' and activeflag = 1;

update routing 
set activeflag =0, updatedby ='CDM-40079', updatedon =now()
where objectid = '73d8ab0f-247b-4580-bf26-5942925ffba5' and activeflag = 1;