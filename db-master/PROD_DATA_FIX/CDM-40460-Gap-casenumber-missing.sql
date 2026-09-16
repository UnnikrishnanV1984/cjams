/* 
   Issue Description: CDM-40460 Guardian ID Missing/ Relationship Missing
   Category/ Module  : Title IVE GAP
   Root cause: The GAP case is not linked with case number due as it is chessie data and it has not been mapped correctly in services actors table.
               User requested to update the relationship as Maternal Cousin in IV-E screen as well as Service Case GAP screen
   Fix Provided : Data fix has been provided to servicecaseid in actors table and also relationship of primary guardian.
   Pull request# for code fix: N/A
   Reason why no related code fix: N/A 
   Status of the code fix if already submitted and expected prod fix date: N/A
   Backup before update/ delete: N/A
*/


update gapeligibilityinfo set casenumber = '2020035004790', primaryguardianisrelative = 'YES', 
primaryguardianrelationship = 'Maternal Cousin', primaryguardianrelationshipid = '1015',
servicecaseid = 'e6adcc26-3e0c-4f91-b6b7-46d3d29a4486',updatedby = 'CDM-40460', updatedon = now()
where client_id = '3566688' and activeflag =1;
                                    

update guardianship 
set primaryrelationshipkey = 'MTNLCN', updatedby = 'CDM-40460', updatedon =  now()
where gapid = 'a33ce894-8b75-442d-9c44-aae6b8557381';
