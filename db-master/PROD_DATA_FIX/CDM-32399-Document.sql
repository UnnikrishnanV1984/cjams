/*
   Issue Description: CDM-32399
   Category/ Module  : Documents tab
   Root cause: user requested to remove docs
   Fix Provided: Did data fix to remove the documents 
*/

update documentproperties set activeflag =0, updatedby = 'CDM-32399', updatedon = now()
where documentpropertiesid in ('8984e47a-944c-41df-b249-66f7cd3dcdd9','273ffc46-5ca8-40ba-bfda-1253a025845a','565b6d32-06ce-498a-aecc-3fd757a0979b','760c5092-879b-40d1-a252-fa146131c41c');	
		
update documentattachment set activeflag =0, updatedby = 'CDM-32399', updatedon = now()
where documentpropertiesid in ('8984e47a-944c-41df-b249-66f7cd3dcdd9','273ffc46-5ca8-40ba-bfda-1253a025845a','565b6d32-06ce-498a-aecc-3fd757a0979b','760c5092-879b-40d1-a252-fa146131c41c');	
			
				