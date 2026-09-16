/*
   Issue Description: CJAMS-58593
   Root cause: In correct data fix done as part of CDM-36954:aca-removal
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/


update adoptionapplicabilityinfo set activeflag = 1, updatedby = 'CJAMS-58593', updatedon= now()
where clientid = '2886087' and removalid = '196160' and activeflag = 0;



update adoptionapplicabilityinfo set ivestatus = 'APPROVED',updatedby = 'CJAMS-58593', updatedon= now()
where adoptionapplicabilityid = '920f2157-098b-46c3-b240-01457ddf477b';

/*
INSERT INTO cjams.tb_adoptionaudit_siblingdetails
(adoptionsiblingdetailsid, adoptionauditid, siblingadoptiondecreedate, siblingadoptionapplicable, siblingapplicablechildassessmentdate, siblingadoptiveproviderid, siblingname)
VALUES('2123181f-8901-44b9-9527-d1bc9c25db96', 44422, NULL, 'NO', '2023-09-08', NULL, 'ALONAH MORGAN');
INSERT INTO cjams.tb_adoptionaudit_siblingdetails
(adoptionsiblingdetailsid, adoptionauditid, siblingadoptiondecreedate, siblingadoptionapplicable, siblingapplicablechildassessmentdate, siblingadoptiveproviderid, siblingname)
VALUES('67c03a92-9407-4ee4-b970-a7d676fcfbc6', 44422, NULL, 'NO', '2023-09-08', NULL, 'ANGELIQUE MORGAN');
INSERT INTO cjams.tb_adoptionaudit_siblingdetails
(adoptionsiblingdetailsid, adoptionauditid, siblingadoptiondecreedate, siblingadoptionapplicable, siblingapplicablechildassessmentdate, siblingadoptiveproviderid, siblingname)
VALUES('fd79059a-100f-4b04-9615-5a1324119aa3', 44422, NULL, 'NO', '2023-04-26', NULL, 'ANDREA MORGAN');
INSERT INTO cjams.tb_adoptionaudit_siblingdetails
(adoptionsiblingdetailsid, adoptionauditid, siblingadoptiondecreedate, siblingadoptionapplicable, siblingapplicablechildassessmentdate, siblingadoptiveproviderid, siblingname)
VALUES('c2c02552-6b5f-46e3-b842-3a4631686172', 44423, NULL, 'NO', '2023-09-08', NULL, 'ALONAH MORGAN');
INSERT INTO cjams.tb_adoptionaudit_siblingdetails
(adoptionsiblingdetailsid, adoptionauditid, siblingadoptiondecreedate, siblingadoptionapplicable, siblingapplicablechildassessmentdate, siblingadoptiveproviderid, siblingname)
VALUES('4964ab8d-65a8-4bc5-8a6c-6289d9c09f31', 44423, NULL, 'NO', '2023-09-08', NULL, 'ANGELIQUE MORGAN');
INSERT INTO cjams.tb_adoptionaudit_siblingdetails
(adoptionsiblingdetailsid, adoptionauditid, siblingadoptiondecreedate, siblingadoptionapplicable, siblingapplicablechildassessmentdate, siblingadoptiveproviderid, siblingname)
VALUES('169ecb86-3aa9-4d1c-901a-78111ababd5f', 44423, NULL, 'NO', '2023-04-26', NULL, 'ANDREA MORGAN');
*/


DELETE FROM cjams.tb_adoptionaudit_siblingdetails
WHERE adoptionsiblingdetailsid in ('2123181f-8901-44b9-9527-d1bc9c25db96','67c03a92-9407-4ee4-b970-a7d676fcfbc6','fd79059a-100f-4b04-9615-5a1324119aa3','c2c02552-6b5f-46e3-b842-3a4631686172','4964ab8d-65a8-4bc5-8a6c-6289d9c09f31','169ecb86-3aa9-4d1c-901a-78111ababd5f');


DELETE FROM cjams.tb_ive_adoption_audit
WHERE adoptionauditid in (44422,44423);
