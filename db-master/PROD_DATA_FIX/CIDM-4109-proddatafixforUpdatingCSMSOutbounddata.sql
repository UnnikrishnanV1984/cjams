/*
   Issue Description: CIDM-4109
   Category/ Module  : Data fix for updating CSMS Out put json
   Root cause: user requeseted to remove it
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/


/*
 * {"iveCaseNumber":200818172,"iveCaseStatus":"PENDING","iveCaseType":"S","iveApprovalDate":null,"effectiveDate":"2021-12-03","iveGrantEndDate":"0001-01-01","ivdRecordType":"NAPP","iveGrantDate":"0001-01-01","iveGrantAmount":null,"parentalRightsTerminationInd":"N","courtOrderInd":"N","courtOrderType":null,"familyViolenceIndicator":null,"referralId":null,"referralDate":"2021-12-03","referralWorkerCaseNotes":null,"referralJurisd":"10","referralWorkerName":"Jennifer Long","referralWorkerCounty":"24021","referralWorkerEmail":"jennifer.long@maryland.gov","referralWorkerPhone":null,"children":[{"childIrn":401061231,"firstName":"Liam","lastName":"Henderson","middleName":"Carter","suffixName":"","maidenName":null,"race":"WH","gender":"M","dateOfBirth":"2021-10-09","ssn":"","childMbrType":"RE","healthInsuranceDetails":null,"medicalCoverageInd":"","paternityEstablishedInd":"N","medicalCoverageInd":"","fosterCareDetails":null,"mdmId":"MDT-140012072","childOnCrtord":"","tprInitDate":null,"email":null,"resAddress":{"addressLine1":"88 SHERWOOD DR","addressLine2":"","city":"Walkersville","state":"MD","zipCode":"21793","county":null,"country":"USA","smartyStreetValidatedInd":"N","isInternationalAddr":"N","lastAddrDt":"0001-01-01","addrVerificationDt":null},"mailingAddress":{"addressLine1":"88 SHERWOOD DR","addressLine2":"","city":"Walkersville","state":"MD","zipCode":"21793","county":null,"country":"USA","smartyStreetValidatedInd":"N","isInternationalAddr":"N","lastAddrDt":"0001-01-01","addrVerificationDt":null}}],"nonCustodialParents":[{"clientid":4445615,"personid":"beff35fc-cb9e-4ede-b5f5-e16238598b17","mdmId":"MDT-126704112","ncpIrn":477042731,"firstName":"MARCUS","lastName":"HENDERSON","middleName":"ROYNELL JORDN","suffixName":null,"maidenName":null,"race":"BA","gender":"M","dateOfBirth":"1989-05-30","ssn":"220233559","ncpMbrType":"AP","ncpRelationshipCode":"","ncpLegalEstablishedInd":"","ncpLegalEstablishedDate":"0001-01-01","ncpBirthHospital":"","ncpBirthCity":"","ncpBirthState":"","ncpDeathDate":"","ncpMaritalStatus":"","ncpMarriageDate":"","ncpMarriageTermDate":"","ncpMarriageTermCity":"","healthInsuranceInd":"","email":null,"lastKnownAddressType":null,"lastKnownAddress":{"addressLine1":"88 SHERWOOD DR","addressLine2":"","city":"Walkersville","state":"MD","zipCode":"21793","county":null,"country":"USA","smartyStreetValidatedInd":"N","isInternationalAddr":"N","lastAddrDt":"0001-01-01"},"lastKnownEmployerDetails":null,"militaryServiceDetails":null,"healthInsuranceDetails":null}, 
 {"clientid":3549797,"personid":"b4eae109-2de5-47d2-b05a-b3b5cc22ed78","mdmId":"MDT-127723553","ncpIrn":498017343,"firstName":"GEORGIA","lastName":"POOLE","middleName":"MAE","suffixName":null,"maidenName":null,"race":"WH","gender":"F","dateOfBirth":"1996-05-22","ssn":"215478503","ncpMbrType":"AP","ncpRelationshipCode":"","ncpLegalEstablishedInd":"","ncpLegalEstablishedDate":"0001-01-01","ncpBirthHospital":"","ncpBirthCity":"","ncpBirthState":"","ncpDeathDate":"","ncpMaritalStatus":"","ncpMarriageDate":"","ncpMarriageTermDate":"","ncpMarriageTermCity":"","healthInsuranceInd":"","email":null,"lastKnownAddressType":null,"lastKnownAddress":{"addressLine1":"88 SHERWOOD DR","addressLine2":"","city":"Walkersville","state":"MD","zipCode":"21793","county":null,"country":"USA","smartyStreetValidatedInd":"N","isInternationalAddr":"N","lastAddrDt":"0001-01-01"},"lastKnownEmployerDetails":null,"militaryServiceDetails":null,"healthInsuranceDetails":null}]}
 * 
 */

update ivecsesoutbounddata set inputjson = '{
  "iveCaseNumber": 200818172,
  "iveCaseStatus": "PENDING",
  "iveCaseType": "S",
  "iveApprovalDate": null,
  "effectiveDate": "2021-12-03",
  "iveGrantEndDate": "0001-01-01",
  "ivdRecordType": "NAPP",
  "iveGrantDate": "0001-01-01",
  "iveGrantAmount": null,
  "parentalRightsTerminationInd": "N",
  "courtOrderInd": "N",
  "courtOrderType": null,
  "familyViolenceIndicator": null,
  "referralId": null,
  "referralDate": "2021-12-03",
  "referralWorkerCaseNotes": null,
  "referralJurisd": "10",
  "referralWorkerName": "Jennifer Long",
  "referralWorkerCounty": "24021",
  "referralWorkerEmail": "jennifer.long@maryland.gov",
  "referralWorkerPhone": null,
  "children": [
    {
      "childIrn": 401061231,
      "firstName": "Liam",
      "lastName": "Henderson",
      "middleName": "Carter",
      "suffixName": "",
      "maidenName": null,
      "race": "WH",
      "gender": "M",
      "dateOfBirth": "2021-10-09",
      "ssn": "",
      "childMbrType": "RE",
      "healthInsuranceDetails": null,
      "medicalCoverageInd": "",
      "paternityEstablishedInd": "N",
      "fosterCareDetails": null,
      "mdmId": "MDT-140012072",
      "childOnCrtord": "",
      "tprInitDate": null,
      "email": null,
      "resAddress": {
        "addressLine1": "88 SHERWOOD DR",
        "addressLine2": "",
        "city": "Walkersville",
        "state": "MD",
        "zipCode": "21793",
        "county": null,
        "country": "USA",
        "smartyStreetValidatedInd": "N",
        "isInternationalAddr": "N",
        "lastAddrDt": "0001-01-01",
        "addrVerificationDt": null
      },
      "mailingAddress": {
        "addressLine1": "88 SHERWOOD DR",
        "addressLine2": "",
        "city": "Walkersville",
        "state": "MD",
        "zipCode": "21793",
        "county": null,
        "country": "USA",
        "smartyStreetValidatedInd": "N",
        "isInternationalAddr": "N",
        "lastAddrDt": "0001-01-01",
        "addrVerificationDt": null
      }
    }
  ],
  "nonCustodialParents": [
    {
      "clientid": 3549797,
      "personid": "b4eae109-2de5-47d2-b05a-b3b5cc22ed78",
      "mdmId": "MDT-127723553",
      "ncpIrn": 498017343,
      "firstName": "GEORGIA",
      "lastName": "POOLE",
      "middleName": "MAE",
      "suffixName": null,
      "maidenName": null,
      "race": "WH",
      "gender": "F",
      "dateOfBirth": "1996-05-22",
      "ssn": "215478503",
      "ncpMbrType": "AP",
      "ncpRelationshipCode": "",
      "ncpLegalEstablishedInd": "",
      "ncpLegalEstablishedDate": "0001-01-01",
      "ncpBirthHospital": "",
      "ncpBirthCity": "",
      "ncpBirthState": "",
      "ncpDeathDate": "",
      "ncpMaritalStatus": "",
      "ncpMarriageDate": "",
      "ncpMarriageTermDate": "",
      "ncpMarriageTermCity": "",
      "healthInsuranceInd": "",
      "email": null,
      "lastKnownAddressType": null,
      "lastKnownAddress": {
        "addressLine1": "88 SHERWOOD DR",
        "addressLine2": "",
        "city": "Walkersville",
        "state": "MD",
        "zipCode": "21793",
        "county": null,
        "country": "USA",
        "smartyStreetValidatedInd": "N",
        "isInternationalAddr": "N",
        "lastAddrDt": "0001-01-01"
      },
      "lastKnownEmployerDetails": null,
      "militaryServiceDetails": null,
      "healthInsuranceDetails": null
    }
  ]
}',updatedon = now() where ivecsesoutboundid = '92d0cb8f-72c2-4dcf-b0dd-c7d80c41d4da';
