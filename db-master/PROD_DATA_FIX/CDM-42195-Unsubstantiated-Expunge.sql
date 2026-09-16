
/*
Issue: SSA Approved on 11/20/2024 to modify the investigation findings from Indicated to Unsubstantiated, and expunge the CPS IR case # CW2351141.
Category/Module: Support
Root cause: Case expungement as part of data cleanup
Fix provided: DB query to expunge the case
Data/Code fix ticket#: CDM-42195
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: CIS Converted Investigation with No information about maltreator or the maltreatment/allegation. CJAMS is not expunging such CIS converted investigations with automated batch. So, we are expunging these CIS Investigations with SSA approvals.
*/

--update Unsubstantiated investigationfinding
update investigationfinding
set updatedby = 'CDM-42195',updatedon = now(),investigationfindingtypekey = 'UD'
where investigationallegationid in ('55afacd2-806a-44b5-a44a-ff14ab372513','230e1764-bdf5-42f2-af41-2f0e5a0b2208') and activeflag = 1;


--expunging case
select vl_sqlcode, vs_err_message from cjams.expungcaserequest('IR'::character varying, 'CW2351141'::character varying, null::date);