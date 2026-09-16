/*
   Issue Description: CDM-17300
   Category/ Module  : Approval inbox
   Root cause: user wants to remove
   Pull request# for code fix: 
  explanantion: user wants to delete the approval record which is already approved
*/

update routing  set activeflag = 0 , updatedby ='CDM-17300',updatedon = now() 
	where routingid in ('a7ec71c4-2d06-4f31-afa3-af2433a547f6', 'a97dffae-6187-4625-9bc0-cf2031f96c90');