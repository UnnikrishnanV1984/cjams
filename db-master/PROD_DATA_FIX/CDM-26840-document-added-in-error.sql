/*
-- CDM-26840 - 
-- Issue Description: 
 Delete the test document under Documents tab 
-- Customer Email ID: kelly.glotfelty@maryland.gov
-- Root cause: Data fix to delete the document under the Documents tab
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

update documentproperties set activeflag = 0, updatedby = 'CDM-26840', updatedon = now() where documentpropertiesid = '672aee7e-3fb9-48ac-b03b-a0788d220588';

update documentattachment set activeflag = 0, updatedby = 'CDM-26840', updatedon = now() where documentpropertiesid = '672aee7e-3fb9-48ac-b03b-a0788d220588';

/*
assessmenttemplateid: null
attachmentclassificationsubtypekey: "CW-CPS Document"
attachmentclassificationtypekey: "CW-CPS"
attachmenttypekey: "Document"
documentpropertiesid: "672aee7e-3fb9-48ac-b03b-a0788d220588"
documentdate: "2022-11-22T18:54:45.298"
documentpropertiesid: "672aee7e-3fb9-48ac-b03b-a0788d220588"
documenttypekey: "Attachment"
ecmsdocumentid: "637d1af67b7864363b8c06d9"
filename: "637d1af67b7864363b8c06d9"
insertedby: "936ce49e-956d-46f8-bb8e-7e37415221ad"
insertedon: "2022-11-22T13:54:48"
mime: "application"
numberofbytes: 108402
objecttypekey: "ServiceRequest"
originalfilename: "2022-11-22 SHANE SAO Closing Notice.pdf"
s3bucketpathname: "/attachments/downloadFileFromECMS?docId=637d1af67b7864363b8c06d9&filename=2022-11-22 SHANE SAO Closing Notice.pdf"
servicecaseid: null
title: "2022.11.22 SAO Notice"
updatedby: "936ce49e-956d-46f8-bb8e-7e37415221ad"
updatedon: "2022-11-22T13:54:48"
*/