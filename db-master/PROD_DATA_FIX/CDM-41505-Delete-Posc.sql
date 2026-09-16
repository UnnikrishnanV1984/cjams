/* 
   Issue Description: CDM-41505 Plan of Safe Care
   Category/ Module  : Services: Other
   Root cause: User requested to Delete Plan of Safe care which is in draft case for the case 2020034904779
   Fix Provided : Data fix has been provided to delete Plan of Safe care for the case 2020034904779
   Pull request# for code fix: N/A
   Reason why no related code fix: N/A 
   Status of the code fix if already submitted and expected prod fix date: N/A
   Backup before update/ delete: N/A
*/

-- INSERT INTO cjams.safecareplan
-- (safecareplanid, objectid, objecttypekey, safecaredate, persondetails, planparticipants, healthneedsdetails, otherservices, planreviewdetails, "comments", justification, consentform, recommendedforclosure, insufficientevidencetocourt, familypreservationtransfer, referredtocps, shelterorder, signatures, activeflag, insertedby, insertedon, updatedby, updatedon, approvalstatus)
-- VALUES('2699b90b-bb75-4988-8dab-77848af1ae4a', '0feb78d8-2f9d-4d1c-9ce3-067ebf292327', 'servicecase', NULL, '{"ldss":{"safecareplandate":"2024-09-10T13:44:11.022Z","name":"Kelly Lind","unit":"CPS Assessment Unit","email":"kelly.lind@maryland.gov","phoneno":"3013926563"},"data":[{"id":1,"familymember":"Parent","memberAddress":"3002 Gallery Pl, Apt 18, Waldorf, MD - 20602","memberDob":"02-23-2003","declinemember":"Household","homelessmember":null,"phonenumber":"2026199902","dobdeclinemember":null,"declinememberphonenumber":null,"personid":"69f251f3-4222-433f-83ee-f4796990b293","personName":" Makayla  Chase ","selectedOpioids":[],"selectedStimulants":[],"selectedDepressants":[],"selectedHallucinogens":["22"],"othercategory":null},{"id":2,"familymember":"Newborn","memberAddress":"3002 Gallery Pl, Apt 18, Waldorf, MD - 20602","memberDob":"08-09-2024","declinemember":null,"homelessmember":null,"phonenumber":null,"dobdeclinemember":null,"declinememberphonenumber":null,"personid":"78b5caa9-f3bf-4296-b5fc-a6f66117e99e","personName":" Serenity  Makle ","selectedOpioids":[],"selectedStimulants":[],"selectedDepressants":[],"selectedHallucinogens":["22"],"othercategory":null}]}', '{}', '{}', '{}', '{}', '', '', '{}', false, false, false, false, false, '{}', 0, '36d2f073-58c2-464c-83db-8d77b3ff14a8', '2024-09-10 09:44:47.285', '36d2f073-58c2-464c-83db-8d77b3ff14a8', '2024-09-10 09:45:10.677', '');


delete from safecareplan where objectid='0feb78d8-2f9d-4d1c-9ce3-067ebf292327';