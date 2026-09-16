/*
   Issue Description: CJAMS-67839
   Category/ Module  : Annual Review
   Root cause: user wants to remove annual date review. 
   Fix provided: Data fix is done to remove the annual review record
   Pull request# for code fix: 
   Reason why no related code fix: Its one time data fix so no code fix is required
   Status of the code fix if already submitted and expected prod fix date: 
    Case is closed without closing removal and placement. Need to do data fix
*/
update gapannualreview 
set activeflag =0,
updatedby ='CJAMS-67839',
updatedon =now()
where gapannualreviewid ='83954fe4-997f-4da7-8e4f-0885f4ff7701' and activeflag =1;

update routing
set activeflag =0,
updatedby ='CJAMS-67839',
updatedon =now()
where objectid ='83954fe4-997f-4da7-8e4f-0885f4ff7701' and activeflag =1;