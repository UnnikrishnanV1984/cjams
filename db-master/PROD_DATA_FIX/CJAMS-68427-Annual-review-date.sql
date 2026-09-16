/*
   Issue Description: CJAMS-68427
   Category/ Module  : Annual Review
   Root cause: user wants to remove annual date review. 
        The Annual Review was submitted twice (i.e., 01/07/2027) against  

            Client ID:   3348954 / CORNELL PARKS
            Case ID: 3197311
            Please carry out data fix to remove the duplicate Annual Review record dated 01/07/2027.  
   Fix provided: Data fix is done to remove the annual review record
   Pull request# for code fix: 
   Reason why no related code fix: Its one time data fix so no code fix is required
   Status of the code fix if already submitted and expected prod fix date: 
    Case is closed without closing removal and placement. Need to do data fix
*/
update gapannualreview 
set activeflag =0,
updatedby ='CJAMS-68427',
updatedon =now()
where gapannualreviewid ='00877e86-edfc-4c0d-9ef5-cf7b5307462a' and activeflag =1;

update routing
set activeflag =0,
updatedby ='CJAMS-68427',
updatedon =now()
where objectid ='00877e86-edfc-4c0d-9ef5-cf7b5307462a' and activeflag =1;