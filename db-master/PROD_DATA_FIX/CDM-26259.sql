/*
   Issue Description: CDM-26259
   Category/ Module  : bug
   Root cause:  need to do data fix to remove annual review.
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

select * from adoptioncase
where adoptioncasenumber  = '3250582';

select * from adoptioniverenewal
where adoptionid  = 'd2b3b43e-ef70-4df8-b46d-292bdce462b4'
and (assessmentdate::DAte) = TO_DATE('2022-10-27', 'YYYY-MM-DD');

update adoptioniverenewal
set activeflag = 0, updatedon = now(),
updatedby = 'CDM-26259'
where adoptioniverenewalid =  '7af4af0c-61ed-4085-b1ed-5c03c0a7661d'
and activeflag  = 1;

update routing set activeflag = 0, updatedon = now(),
updatedby = 'CDM-26259'
where objectid =  '7af4af0c-61ed-4085-b1ed-5c03c0a7661d'
and activeflag  = 1;