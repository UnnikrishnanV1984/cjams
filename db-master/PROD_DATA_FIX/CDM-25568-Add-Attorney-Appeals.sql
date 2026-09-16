/*
   Issue Description: CDM-25586
   Category/ Module  : Investigation Findings 
   Root cause: user wants to add attorney to display in list
   Pull request# for code fix: 6741
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/


INSERT INTO cjams.attorneyaddress(attorneyaddressid, attorneyname, addressline1, attorneyphonenumber, attorneyfax, attorneyemail, activeflag, effectivedate, insertedby, updatedby, insertedon, updatedon, addressline2, county, statekey, zipcode, division)
VALUES(gen_random_uuid(), 'Emily White', '80 West Street', '410-269-4669', '410-974-8566', 'emily.white@maryland.gov', 1, now(), 'CDM-25568', 'CDM-25568', now(), now(), NULL, 'Annapolis', 'MD', 21401, NULL);