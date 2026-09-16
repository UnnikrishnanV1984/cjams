/* 
    Issue Description: CDM-38935
   Category/ Module  : SDM
   Root cause: Modified this indicated neglect finding to ruled out neglect
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Case is closed without closing removal and placement. Need to do data fix
*/

update tb_conv_inv_finding set investigation_finding_cd= 'Ruled out' where inv_finding_id = 246642;