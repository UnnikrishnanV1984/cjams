-- Category/ Module: Adoption
-- Root cause: Revision records has been removed so that correct status will be coming	
-- Pull request# Save as draft button removed from UI
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: Next Prod Build


update adoptioncaseagreementrevision set activeflag = 0, updatedby = 'CDM-16988', updatedon = now() where adoptioncaseagreementrevisionid ='625f8e30-8a67-4c3c-adae-84effa742ac1';
update adoptioncaseagreementrevision set activeflag = 0, updatedby = 'CDM-16989', updatedon = now() where adoptioncaseagreementrevisionid ='819bec0a-9fc6-4338-b949-7e0da842a64e';