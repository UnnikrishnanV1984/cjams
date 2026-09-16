/*
   Issue Description: CDM-28472
   Category/ Module  : Additional maltreatment
   Root cause: There are additional maltreatment tabs appearing for this case when there should only be a total of four.
   Pull request# for code fix: It's a data fix
   Reason why no related code fix:  
   
*/

update investigationallegation set activeflag = 0, updatedby = 'CDM-28472', updatedon = now() where investigationallegationid in ('384d1705-38cd-42ee-91d5-acaeeaf9d38c', '9e3e088d-e3a5-40e2-a1d8-b9475b05f1ce', '7096cbeb-f51e-4b84-80d1-963066116da8');