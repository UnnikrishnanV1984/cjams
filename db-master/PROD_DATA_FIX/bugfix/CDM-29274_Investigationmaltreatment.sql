/*
   Issue Description: CDM-29321
   Category/ Module  : Investigation Maltreatment 
   Root cause: As requested by user
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/

update Investigationmaltreatment 
set activeflag = 0, updatedby ='CDM-29321', updatedon = now()
where maltreatmentid in ('05ed7151-99e3-455f-a6de-e8ee57c7c3a5','416fc321-28d5-4aef-86fd-a8cf568ca8d7','2fd778e0-d00a-4aa1-b95d-93e5f09ae529',
'a4fce504-8961-4266-828c-947398f0f349','218fe66a-3db2-42b1-a81b-994629593bf2','5d2b42ad-b063-491b-93d3-ce84dace464d',
'2c192648-d27e-438d-b7f0-5ac3d4010cce','a62dab23-fd4b-4557-8b77-dfd6199f462b','578d20d2-406b-46e1-82ba-d6bf8a204757',
'd9d1152e-b741-44ec-bafe-24939a0caf64','237360c3-3db3-4b37-a907-dba819454afc','8bc3670c-e8c4-4a22-9a18-dff352f2b12f','55904e21-54fe-4a51-85c8-d1bf95040be8');

update Investigationallegation
set activeflag = 0, updatedby ='CDM-29321', updatedon = now()
where maltreatmentid in ('05ed7151-99e3-455f-a6de-e8ee57c7c3a5','416fc321-28d5-4aef-86fd-a8cf568ca8d7','2fd778e0-d00a-4aa1-b95d-93e5f09ae529',
'a4fce504-8961-4266-828c-947398f0f349','218fe66a-3db2-42b1-a81b-994629593bf2','5d2b42ad-b063-491b-93d3-ce84dace464d',
'2c192648-d27e-438d-b7f0-5ac3d4010cce','a62dab23-fd4b-4557-8b77-dfd6199f462b','578d20d2-406b-46e1-82ba-d6bf8a204757',
'd9d1152e-b741-44ec-bafe-24939a0caf64','237360c3-3db3-4b37-a907-dba819454afc','8bc3670c-e8c4-4a22-9a18-dff352f2b12f','55904e21-54fe-4a51-85c8-d1bf95040be8');
