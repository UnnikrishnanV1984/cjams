-- Remove finance Read only permission for the user.
update userresource set activeflag = 0 , isallowed = false , isvisible = false , isenabled = false, updatedby= 'CDM-18425', updatedon = now()  
where userid = '7065' and activeflag = 1 and userresourceid = '36cd9221-1f7e-48db-8c8f-5ee4597242d9';