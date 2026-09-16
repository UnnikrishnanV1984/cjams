/*
 -- Issue Description:CJAMS-69240 - Stuck YTP
 -- Category/Module: Approval inbox
 -- Root cause: There were stuck YTP on both active an dinactive users, we are doing the data cleanup
 -- Fix provided: Data fix is done to remove the stuck YTP'S on approval inbox 
 -- Code/Data fix ticket#: NA
 -- Regression Impacts: N/A
 -- Is Code fix Required?: N
 -- Reason why no related code fix: Data cleanup
 */



---Genuinely stuck on active users approval box 
update routing 
set activeflag =0,
updatedby ='CJAMS-69240',
updatedon =now()
where routingid in ('71314ccb-24da-42dd-9551-dea65f4f90d9',
'32443b72-b6c4-40b0-b1da-b1e85c4eaec9',
'32952197-b09a-4437-9a4e-0a19a8cf066a',
'3a3cf536-4734-479b-a4da-65494a4d4ea4',
'ed5a4250-9528-4397-9b44-adb81fa76f14',
'00dac67d-2976-4d4a-bf19-6111bfa7e8c3',
'58cb6ac7-c98c-4f96-abb8-eb078643d532',
'f2f5f9b2-8616-4d7a-847f-be70f69d0292',
'4487beed-5a16-41a3-a02a-f3d5da2bf6d4',
'628a862c-d07e-4061-86a6-157036e4b8b5',
'b911c670-a942-4f41-96c8-d5fc81bfd316',
'b577a3cb-cdf9-4cdf-884d-9389a477a9b1',
'0f1ed3a0-ed4c-4cf9-bcc3-549ef4765bdf',
'204b8af1-17eb-4a15-9bd1-29f02fe755bf',
'b9ac8d55-33b0-4172-91bc-e701e17dc0f2',
'60eec50c-fa83-44db-802b-4811c58f8900',
'268dcf76-3326-4a76-ac86-dafd0bc14120',
'7255c444-cda9-4fe6-8933-4ef345acea9f',
'6533a587-2cad-4c72-8ef6-36a52cce1671',
'c729a6b4-ed17-4371-8fe4-34d0ae0e70ba',
'7668f9f9-d1ca-474e-a158-7f11317f64cb',
'0acc0186-1621-488a-b06c-719114892848',
'adee7206-e5cc-4983-824a-127a7049e00a',
'cb795814-518e-46f3-adf7-0e2c38bcfa1b',
'10df124b-5fb9-462f-b32e-290a4aa30274',
'b9e175c6-64e7-47db-8211-7164374e577a',
'af78c136-e590-40ea-abf7-2fd2f3b84348',
'22dbfc79-9362-4023-851c-a78cb703729a',
'7a21c884-df34-4618-96b2-4f6012f4f3b0') 
and activeflag =1;

--- Genuinely stuck on  inactive users approval box
update routing 
set activeflag =0,
updatedby ='CJAMS-69240',
updatedon =now()
where routingid in ('987e0b59-0a09-4403-9043-ff3694ffb4ca',
'e47f6179-591c-481a-8cfb-30b16436f7d3',
'e94c22ad-d7a2-40fb-a33e-b1dfb301ed02',
'85cd32b2-d576-4bd5-84f5-eb9f5c7bc6ec',
'47ecd6b6-7e03-4653-9b80-9cdcaba87646',
'31541609-abf0-4264-b525-7e0b92cec2cc',
'25b6674f-9327-4655-80c0-a4abf6dd3cc9',
'00157df7-f632-47c9-b228-de38a5e1fe0c',
'16af7289-7ce6-491b-be84-93f99492b95e') and activeflag =1;

---Genuinely pending on inactive users approval box but its a legacy YTP so we are deativating it instead of routing it to Sheritta
update routing 
set activeflag =0,
updatedby ='CJAMS-69240',
updatedon =now()
where routingid='24ed6ae7-d09b-4901-981e-2b224f82b9c7' and activeflag =1;

---Genuinely pending on inactive users approval box , we are routing to sheritta.barr-stanley1@maryland.gov
update routing 
set tosecurityusersid ='056865a7-2a58-494e-9993-ccc6fd9aae58',
updatedby ='CJAMS-69240',
updatedon =now()
where routingid in ('9d33a425-6c30-47e4-9da4-cda82b041a44','616b27f9-fbc3-493f-b86e-7b9fd280900d','dbf54a8e-5dbe-40e4-80c2-278debe0fbba')
and activeflag =1;