/*
   Issue Description: CJAMS-67126
   Category/ Module  : Reverse write off approval
   Root cause: A write-off request was sent to Debra Dandridge who is retired so requested to re route to linnel.benton@maryland.gov for approval
   Fix provided: Data fix has been done to re route the write-off request to Linnel benton
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/


update routing 
set tosecurityusersid ='b0fbf926-91a3-4a91-a6a4-62e458683797',
updatedby ='CJAMS-67126',
updatedon =now()
where eventcode = 'FNSWO'
and activeflag =1 
and routingstatustypeid ='30'
and tosecurityusersid='df4e91fc-5824-45b0-baae-788cacf3bc79';