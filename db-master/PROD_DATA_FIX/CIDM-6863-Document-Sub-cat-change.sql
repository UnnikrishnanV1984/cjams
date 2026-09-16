
/*
   Issue Description:CIDM-6863
   Category/ Module  :Documents   
   Root cause: 
   Pull request# for code fix: 
   Reason why no related code fix: 
    requested a data fix to resolve
*/
--- Todo --> Need to Remind ECMS on prod day regarding this one 

update cjams.referencevalues set value_text ='Representative Payee Report of Benefits and Dedicated Account (SSA 6233)', 
description ='Representative Payee Report of Benefits and Dedicated Account (SSA 6233)', updatedby ='CIDM-6863', updatedon = now()
where ref_key ='rep623' and referencetypeid ='1000';