/*
Issue: 251023120728:As I was closing this case, the Caseworker had changed the finding without my knowledge; I had already approved the unsubstantiated finding and had sent the SAO the disposition and closed it. 
She had changed it to Rule Out, which is incorrect, seconds before I closed it.
Category/Module: Investigation Findings
Root cause: Findings was saved incorrectly and data fix needs to done to update from Ruled out to Unsubtantiated.
Fix provided: Data fix has been done to update the Findings from Ruled out to unsubtantiated.
Data/Code fix ticket#: CJAMS-63577
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: We got SSA approval and we are working on updating the Findings
*/

update
	investigationfinding
set
	updatedby = 'CJAMS-63577',
	updatedon = now(),
	investigationfindingtypekey = 'UD'
where investigationfindingid in ('53b2ab93-3923-4672-b38e-71ad811272ff','bf40de01-0b58-41e8-bd99-808f6e6b17b0','f568915e-83f2-477c-8227-e184e58d7285')
	and activeflag = 1;