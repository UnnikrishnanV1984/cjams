/*
   Issue Description: CDM-35132
   Category/ Module  : User Access Profile   
   Root cause: user is has readonly in cw login 
   Fix Provided: Did data fix To remove Read_only_access
*/


--To remove Read_only_access
update cjams.userresource set activeflag  =0,
updatedby ='CDM-35132', updatedon  = now()
where userid ='9659' and userresourceid ='46483bed-1274-4577-9da1-c0902176f2bb' and activeflag =1;