/*
   Issue Description: CJAMS-68426
   Category/ Module  : Annual Review
   Root cause: user wants to remove annual date review. 
        The Annual Review was submitted twice (i.e.12/30/2024) against  

        Client ID: 3156364 (JERIMIAH SETTLES)
        Case ID: 3180319
        Please carry out data fix to remove the duplicate Annual Review record dated 12/30/2024.
   Fix provided: Data fix is done to remove the annual review record
   Pull request# for code fix: 
   Reason why no related code fix: Its one time data fix so no code fix is required
   Status of the code fix if already submitted and expected prod fix date: 
    Case is closed without closing removal and placement. Need to do data fix
*/
update gapannualreview 
set activeflag =0,
updatedby ='CJAMS-68426',
updatedon =now()
where gapannualreviewid ='7359597f-a247-4b4e-93f7-7fdf06e883b9' and activeflag =1;

update routing
set activeflag =0,
updatedby ='CJAMS-68426',
updatedon =now()
where objectid ='7359597f-a247-4b4e-93f7-7fdf06e883b9' and activeflag =1;