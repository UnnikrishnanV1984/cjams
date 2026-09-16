
/*
-- CJAMS-68030 

-- Issue Description: 
 Delete Purchase Authorizations
  
-- Customer Email ID: wanda.nolt@maryland.gov

-- Root cause: Data fix to reroute purchase authorizations
-- Pull request#: N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

    update routing 
    set updatedon = now(), updatedby='CJAMS-68030', tosecurityusersid='d636ac2f-53ff-43e0-adbf-35c97e0427ec'
where objectid in ('758413','758411','758407','758405','756592') 
    and eventcode  in ( 'PCAUTHR', 'PCAUTH' ) and activeflag = 1 ;



