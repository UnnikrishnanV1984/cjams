
/*
Issue Description: A user is trying to enter and save a hotel address for a living arrangement, but after supervisor approval the address does not show up. Even after multiple attempts, the system is not saving or displaying the address correctly.
Root cause: user could not abe to updated records  ,they can only create.
Fix provided: DB queries  update enddate intakeservreqchildremoval,personprogramarea tables
Data/Code fix ticket#: CJAMS-61170
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: Data error
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
delete from livingarrangement where placementid  in ('b4167eac-0a44-456f-9335-d331a66114e6','d49cfbd7-5b16-41e1-a93a-de53bcd6a8da');
*/



insert into livingarrangement(placementid,livingenddate,primarycaregiver,streetname,cityname, countytypekey,  statetypekey,
zip5no,   insertedby,insertedon,activeflag,livingarrangementtypekey, livingstartdate,updatedby,updatedon,personid,addresstypekey,
agency1to1rate,dailyrate,homephone,agency1to1,fostercarenonfoster,agency1to1desc,hotelorother,ratetype)
values(
'b4167eac-0a44-456f-9335-d331a66114e6','2025-08-06 12:00:00.000','Foster Care - Non-Foster Home setting',' 7021 Arundel Mills Circle','Hanover',
'1429','MD','21076','1a0996aa-442f-4d53-9a61-76c20d6d9d5a',now(),1,'FCNFHS','2025-07-01 12:00:00.000','CJAMS-61326',now(),'9a61d7ca-2ae9-4b90-b296-ef17f9439f1c','3357','50.00',
'150','4436766328',true,'HOTEL','Partnering for Success','Towne Place Suites','hourlyrate'),
('d49cfbd7-5b16-41e1-a93a-de53bcd6a8da','2025-07-01 00:00:00','Foster Care - Non-Foster Home setting',' 7021 Arundel Mills Circle','Hanover',
'1429','MD','21076','1a0996aa-442f-4d53-9a61-76c20d6d9d5a',now(),1,'FCNFHS','2025-06-24 00:00:00','CJAMS-61326',now(),'9a61d7ca-2ae9-4b90-b296-ef17f9439f1c','3357','50.00',
'150','4436766328',true,'HOTEL','Partnering for Success','Towne Place Suites','hourlyrate');


