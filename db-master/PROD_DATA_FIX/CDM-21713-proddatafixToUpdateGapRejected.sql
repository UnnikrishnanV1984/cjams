
/*
   Issue Description: CDM-21713
   Category/ Module  : Prod data fix To remove remove rejected record
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

update guardianship set isapprovedresourceparent = false, updatedby = 'CDM-21713', updatedon = now() where gapid in ('18ce9907-7e0b-44bd-bc2a-9f72e2d357c5','6c4b6eff-e085-4a3c-95f2-61a1fe16b302');
update routing set activeflag = 0, updatedby = 'CDM-21713', updatedon = now() where routingid in ('6bd0415b-a042-4019-b36f-e576e3792058','e848d4eb-683f-41dc-9734-c5a55691529c') and activeflag = 1;
update routing set activeflag = 1, updatedby = 'CDM-21713', updatedon = now() where routingid in ('eb3a1f50-6101-483e-b644-56b149214788',
'a674c435-abe3-414d-ba17-0b175ef71866') and activeflag = 0;
