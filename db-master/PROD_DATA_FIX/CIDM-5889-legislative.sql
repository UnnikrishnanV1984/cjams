
/*
   Issue Description: CIDM-5889
   Category/ Module  : Legislative 
   Root cause: user wants to chnage annual date review. 
   Pull request# for code fix: 4673
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Case is closed without closing removal and placement. Need to do data fix
*/

update cjams. legislative set islegislativereporting ='', isreasonnotprovided ='', isdataentrynotes='',isemergency ='', updatedby ='CIDM-5889', updatedon =now()
where intakeserviceid in('f30d1380-223f-44e9-adb9-93ecd32fca11','8de0977a-4bc4-4526-bb17-53f425b9b58d','13e54697-03e0-45cb-9c3f-151dc6bdf686',
'a3edc05c-eeeb-4440-bc4c-f2d9daa4a386','6ea3d039-c74d-488b-ad17-431b84bd23f9','a94fd017-9246-40f8-8dde-4ea82e7e0661','bf2419ea-9ba6-4e39-aa3f-b3df2e3e9d2b','3e727ad2-568e-4cf5-846f-e93db6bde7fa',
'2a14d1dc-aa87-43ed-b6a0-4d06b8fc4ae5','11b7b628-43d9-464e-ae79-aea896f69d42','0d17dc1c-9713-4174-820e-a2feeaf86504','b05c2e5a-4bbd-4bdc-9b15-8fee0f87fdb1');