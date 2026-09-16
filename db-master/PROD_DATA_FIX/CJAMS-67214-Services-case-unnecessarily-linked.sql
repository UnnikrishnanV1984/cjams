/* Category/ Module  :  case connect
   Root cause: user error
        Case# 251030468563 was linked wrongly to CPS IR# 251023034401.  Please carry out data fix to  link Service Case# 3150545 to CPS IR# 251023034401
   Pull request# for code fix: 
   Reason why no related code fix: 
   user error requested data fix
*/

update intakeservicerequest 
set servicecaseid = null,updatedby = 'CJAMS-67214',updatedon = now()
where servicerequestnumber = '251023034401' and activeflag = 1;


--link service case
select * from cjams.createservicecase('483986c3-faa3-442b-a0a5-fe7c1bb8bb90'::uuid, 'f17712bf-6117-40cb-b150-f17b83eb2566'::character varying, 0::integer, 'd0a086a2-51d7-4ee2-bfed-2622feb2789c'::character varying, NULL::uuid[],
  ''::character varying,
  'intake'::character varying,
  false::boolean);