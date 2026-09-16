/* 
    Issue Description: CJAMS-65701
   Category/ Module  : Investigation findings has duplicate records
   Root cause: : User requested to delete the duplicate entries.
   Fix Provided: Fix provided by deleting the duplicate entries of same victim.
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
   Backup before update/ delete:
*/

update investigationallegation 
set activeflag =0, updatedby ='CJAMS-65701', updatedon =now()
where maltreatmentid in ('d856fd7e-8c78-4794-b4b1-6fa81d6a339a', '34dca69b-245b-4ea6-b539-edd660f07248');