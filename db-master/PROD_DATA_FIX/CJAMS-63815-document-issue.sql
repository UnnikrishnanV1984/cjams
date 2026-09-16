/*
Description:CJAMS-63815 Pdf Document won't load or open
Category/Module: Documents
Root cause: This is an old document which was uploaded on 11/04/2020 and this upload didn't get saved in the ecms side.
            ECMS document id and other information is missing for this document. We also don't have api error logs captured as this is a very old document and we will not be able to
            recover it at this time. 
Fix provided:  Data fix has been done to delete this document from CJAMS side as it's source is not available in ECMS side.
                
Data/Code fix ticket#: CJAMS-63815 
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: This is an old document that didn't get uploaded in ECMS server and we cannot recover it.
*/

update documentproperties
set activeflag = 0,
    updatedby = 'CJAMS-63815',
    updatedon =now()
where  documentpropertiesid = '8b2045c9-3a78-463a-a60c-1f01f6b131bd'
and activeflag =1;

update documentattachment
set activeflag = 0,
    updatedby = 'CJAMS-63815',
    updatedon =now()
where  documentpropertiesid = '8b2045c9-3a78-463a-a60c-1f01f6b131bd'
and activeflag =1;