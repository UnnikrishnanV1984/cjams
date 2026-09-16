
    /*
  Issue Description:  CDM-29425
   Category/ Module  :  Person profile 
   Root cause: wrongly created
   Pull request# for code fix: 
   Reason why no related code fix: user requested 
   Status of the code fix if already submitted and expected prod fix date: 
   Backup before update/ delete:
   
*/

--- Need to remove deleted document from personexamination document path 

---For future person profiles documents  already implemented this feature on dev environment once QA valaidate all person profile documents on dev will move to stage 

update cjams.personexamination set uploadpath ='[
  
  {
    "filename": "6411ff906602b426b1732a16",
    "originalfilename": "20221019_Well_Woman_631E_ AmS.pdf",
    "date": "2023-03-15T17:25:36.662Z",
    "mime": "application/*",
    "numberofbytes": 108988,
    "s3bucketpathname": "/attachments/downloadFileFromECMS?docId=6411ff906602b426b1732a16&filename=20221019_Well_Woman_631E_ AmS.pdf",
    "ecmsdocumentid": "6411ff906602b426b1732a16",
    "srno": "123434",
    "documentdate": "2023-03-15T17:25:35.519Z",
    "title": "20221019 Well Woman 631E AmS",
    "objecttypekey": "ServiceRequest",
    "rootobjecttypekey": "ServiceRequest",
    "activeflag": 1,
    "servicerequestid": "de7d6047-1da8-46e2-ba15-b96f3206eb6e",
    "documentattachment": {
      "attachmenttypekey": "Document",
      "attachmentclassificationtypekey": "CW-Health",
      "attachmentclassificationsubtypekey": "CW-Health-Annual Report-Receipt",
      "attachmentdate": "2023-03-15T17:25:35.519Z",
      "sourceauthor": "",
      "attachmentsubject": "",
      "sourceposition": "",
      "attachmentpurpose": "",
      "sourcephonenumber": "",
      "acquisitionmethod": "",
      "sourceaddress": "",
      "locationoforiginal": "",
      "insertedby": "BrianDavis",
      "note": "",
      "updatedby": "BrianDavis",
      "activeflag": 1
    },
    "daNumber": "123434",
    "insertedby": "BrianDavis",
    "updatedby": "BrianDavis",
    "securityusersid": "52f46641-70f6-4e8d-aefd-1dbaa11c56a0",
    "servicecaseid": null,
    "attachmenttype": "person",
    "personid": "78906269-e195-4913-9ace-54a069a7ba98",
    "actualdocumentdate": "10/19/2022",
    "documentpropertiesid": "844d5bf4-4cc1-40e8-8a16-08ef4d67ab75"
  }
]',

updatedby ='CDM-29425', updatedon = now()

 where personexaminationid ='8dcccb15-894b-4b4d-ac8b-60bbefbec412';




