
/*
Issue Description: Case was closed on 03/28/2025 and there is one purchase authorization that has been forwarded 
for supervisor approval. Authorization was submitted by Emilee Howard and forwarded to her name.
Category/Module: Bug
Root cause: user can only create Purchase Authorization, but they do not have access to update or edit record.
Fix provided:DB queries to update record in rouing,tb_service_purchase_authorization table.
Data/Code fix ticket#: CJAMS-59070
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: user error
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/
insert into routing 
(routingid,                           
eventcode,                           
fromsecurityusersid,                 
tosecurityusersid,                   
teamid,                              
fromroleid,                          
toroleid,                            
objectid,                            
routingstatustypeid,                 
activeflag,                          
insertedby,                          
insertedon,                          
updatedby,                           
updatedon,                           
isreviewrequest,                     
remarks,                             
old_id,                              
routeddescription,                   
servicerequestnumber,                
objecttypekey,                       
old_from_id,                         
old_to_id,                           
principaltype,                       
actiondatetime,                      
etl_userid,                          
etl_load_date,                       
entityid,                            
reassignnotes,                       
intakerecommendation,                
supervisordecision,                  
approveddate)
values 
( gen_random_uuid(),
'PCAUTH',
'630385e1-9785-404a-899d-1e7bd95c8368',
'630385e1-9785-404a-899d-1e7bd95c8368',
'39e58699-0d23-44a3-b229-1479a8ae97d1',
'CWSP',
'FNSFS',
'3759118',
'62',
'1',
'CJAMS-59072',
now(),
'CJAMS-59072',
now(),
'true',
'supervisor denied',
null,
null,
'241030344932',
'ServiceCase',
null,
null,
null,
null,
null,
null,
null,
null,
null,
null,
null);
