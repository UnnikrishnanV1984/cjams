/* 
    Issue Description: CJAMS-69771
   Category/ Module  : Contact
   Root cause: ser wants to remove one line from contact notes description
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Case is closed without closing removal and placement. Need to do data fix
*/





update progressnote 
set description ='',updatedby ='CJAMS-69771',updatedon =now() 
where witsid ='16489472' and activeflag =1;
