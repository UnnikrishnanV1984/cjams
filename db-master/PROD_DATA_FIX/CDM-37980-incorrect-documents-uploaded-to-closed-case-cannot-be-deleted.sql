/*
    Issue Description: CDM-37980
    Category/ Module  : Document 
    Root cause: user requested to remove the requested document 
    Fix Provided: Data fix updated for the requested document.
*/

select activeflag,updatedby,updatedon,documentpropertiesid from documentproperties where documentpropertiesid='577e869e-9198-4737-954b-e4defd268132' and objectid='c64dc36a-31e2-424d-a344-9f0aa9ee71ad';
-- UPDATE cjams.documentproperties
-- SET activeflag=1, updatedby='fc18350a-e495-49c7-929a-049679f0a228', updatedon='2024-03-08 13:29:14.000'
-- WHERE documentpropertiesid='577e869e-9198-4737-954b-e4defd268132' and objectid='c64dc36a-31e2-424d-a344-9f0aa9ee71ad';

update documentproperties set activeflag = 0, updatedby ='CDM-37980', updatedon = now() where documentpropertiesid='577e869e-9198-4737-954b-e4defd268132' and objectid='c64dc36a-31e2-424d-a344-9f0aa9ee71ad';

select activeflag,updatedby,updatedon,documentpropertiesid from documentattachment where documentpropertiesid='577e869e-9198-4737-954b-e4defd268132';
-- UPDATE cjams.documentattachment
-- SET activeflag=1, updatedby='fc18350a-e495-49c7-929a-049679f0a228', updatedon='2024-03-08 13:29:14.000' WHERE documentpropertiesid='577e869e-9198-4737-954b-e4defd268132' and documentattachmentid='0be64315-d1f7-45ba-9ce7-8a3afbb98d92';

update documentattachment set activeflag = 0, updatedby ='CDM-37980', updatedon = now() where documentpropertiesid='577e869e-9198-4737-954b-e4defd268132' and documentattachmentid='0be64315-d1f7-45ba-9ce7-8a3afbb98d92';