/*
   Issue Description: CDM-23642
   Category/ Module :  Living Arrangement 
   Root cause: user wants to remove
   Pull request# for code fix: 5824
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/
update livingarrangement 
set updatedby = 'CDM-23642', updatedon = now(), activeflag = 0
where placementid in ('ae3cb394-b7b6-460c-af2d-d72505709979', 'b38b1ab4-09d4-414a-9cdf-44860d13b2c0', 'ae9b91d7-e67f-4b93-93cc-344acce0c065');

update placement
set updatedby = 'CDM-23642', updatedon = now(), activeflag = 0
where placementid in ('ae3cb394-b7b6-460c-af2d-d72505709979', 'b38b1ab4-09d4-414a-9cdf-44860d13b2c0', 'ae9b91d7-e67f-4b93-93cc-344acce0c065');

update routing 
set updatedby = 'CDM-23642', updatedon = now(), activeflag = 0
where objectid in ('ae3cb394-b7b6-460c-af2d-d72505709979', 'b38b1ab4-09d4-414a-9cdf-44860d13b2c0', 'ae9b91d7-e67f-4b93-93cc-344acce0c065');