/*
-- Issue Description: 
-- CDM-27264: Health Info will not save
-- Category/ Module: Person - Health  
-- Root cause: Health info not saving in Prod but in stag3. User requested for datafix
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: TBD
*/

SELECT parentexaminationid, appoinmentdate, starttime, endtime, nextappointmentdate, examinationtypekey, labtesttypekey, specialityexamtypekey, appointkeptflag, hivconsentflag, physicianspeciality, affiliateorg, physicianname, recommendations, "comments", address1, address2, cityname, statetypekey, countytypekey, zip5no, workphone, email, personid, insertedon, insertedby, nextappointmentreason, authformcompletion, notcompletedauthform, otherreason, notkeptreason, uploadpath, providerinfoflag, followupneeded, medicalreferrals, covidimpacted, exposedtocovid, covidtestconducted, typeoftest, covidtestresults, covidtestdate, updatedby, updatedon, timeframe, labtestother, specialityexamother, physicianfaxnumber
FROM cjams.personexamination
WHERE parentexaminationid = '01eb8773-f60f-486c-aeab-cd01030b9679';


INSERT INTO cjams.personexamination
(parentexaminationid, appoinmentdate, starttime, endtime, nextappointmentdate, examinationtypekey, labtesttypekey, specialityexamtypekey, appointkeptflag, hivconsentflag, physicianspeciality, affiliateorg, physicianname, recommendations, "comments", address1, address2, cityname, statetypekey, countytypekey, zip5no, workphone, email, personid, insertedon, insertedby, nextappointmentreason, authformcompletion, notcompletedauthform, otherreason, notkeptreason, uploadpath, providerinfoflag, followupneeded, medicalreferrals, covidimpacted, exposedtocovid, covidtestconducted, typeoftest, covidtestresults, covidtestdate, 
updatedby, updatedon, timeframe, labtestother, specialityexamother, physicianfaxnumber)
VALUES('4b3199c5-0e75-4545-9881-282c00f3ec9c', '2022-09-17 00:00:00.000', NULL, NULL, NULL, '32926', NULL, NULL, 0, 0, '', 'Choptank Community Health', '', '', '', NULL, NULL, NULL, NULL, NULL, NULL, '', '', '496b37ee-b2c8-43e1-8e44-5d0aba0f4ca8', '2022-12-12 12:12:44.466', '00b6c98a-472c-481e-ae79-ccdd318ded4f', NULL, NULL, NULL, '', 'NKR1', '[]', 1, '', '', false, NULL, NULL, NULL, NULL, NULL,
'CDM-27264', now(), NULL, NULL, NULL, '')
ON CONFLICT DO NOTHING;