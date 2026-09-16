/*
   Issue Description: CDM-14982
   Category/ Module  : SDM Choice to change
   Root cause: user wants to end date removal and placement 
   Pull request# for code fix: 4602
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Case is closed without closing removal and placement. Need to do data fix
*/



update intakesnapshot 
set jsondata = replace(jsondata::text, '"screeningRecommend": "ScreenOUT",' , '"screeningRecommend": "Screenin",')::json, 
updatedon = now(),updatedby = 'CDM-14982' where intakenumber = 'I211010173029';

update intakesnapshot 
set jsondata = replace(jsondata::text, '"screeningRecommend": "ScreenOUT",' , '"screeningRecommend": "Screenin",')::json, 
updatedon = now(),updatedby = 'CDM-14982' where intakenumber = 'I211010173029' and activeflag = 1;

update intakedastaging
set jsondata = replace(jsondata::text, '"screeningRecommend": "ScreenOUT",' , '"screeningRecommend": "Screenin",')::json, 
updatedon = now(),updatedby = 'CDM-14982' where intakenumber = 'I211010173029' and activeflag = 1;

update intakesnapshot 
set jsondata = replace(jsondata::text, '"isfinalscreenin": "false"' , '"isfinalscreenin": "true"')::json, 
updatedon = now(),updatedby = 'CDM-14982' where intakenumber = 'I211010173029' and activeflag = 1;

update intakedastaging 
set jsondata = replace(jsondata::text, '"isfinalscreenin": "false"' , '"isfinalscreenin": "true"')::json, 
updatedon = now(),updatedby = 'CDM-14982' where intakenumber = 'I211010173029' and activeflag = 1;



