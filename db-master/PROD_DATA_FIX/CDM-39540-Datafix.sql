/* 
    Issue Description: CDM-39540
  Category/ Module  : Case Closure
  Root cause: Worker PHONE numbers on Cases in CJAMS and E&E
  Pull request# for code fix: 
  Reason why no related code fix: 
  Status of the code fix if already submitted and expected prod fix date: 
  Backup before update/ delete: 
*/


--eric.bianco1@maryland.gov
UPDATE cjams.userprofilephonenumber
SET phonenumber='4106273757', updatedby='CDM-39540', updatedon=now()
WHERE securityusersid='f820d87f-eea8-4f7d-8a77-66207022a2cf' and activeflag=1;

--alison.farmer1@maryland.gov
UPDATE cjams.userprofilephonenumber
SET phonenumber='4434803527', updatedby='CDM-39540', updatedon=now()
WHERE securityusersid='ef15b336-bc7c-45b1-a5a2-e7e2a819564b' and activeflag=1;

--tracye.landon@maryland.gov
UPDATE cjams.userprofilephonenumber
SET phonenumber='4434805929', updatedby='CDM-39540', updatedon=now()
WHERE securityusersid='f7b97cee-2314-42a0-9582-8fa89c8efb9a' and activeflag=1;

--taylor.nickerson1@maryland.gov
UPDATE cjams.userprofilephonenumber
SET phonenumber='4107399702', updatedby='CDM-39540', updatedon=now()
WHERE securityusersid='f4148525-d903-48a3-b5eb-742f45bdbf32' and activeflag=1;

--amanda.plummer@maryland.gov
UPDATE cjams.userprofilephonenumber
SET phonenumber='4434807241', updatedby='CDM-39540', updatedon=now()
WHERE securityusersid='1f2c8db1-7ecf-4a4c-9d0c-3e039928c013' and activeflag=1;

--rachel.west@maryland.gov
UPDATE cjams.userprofilephonenumber
SET phonenumber='4434805674', updatedby='CDM-39540', updatedon=now()
WHERE securityusersid='5d555c41-8c42-4753-9662-e64bb29bb8b4' and activeflag=1;
