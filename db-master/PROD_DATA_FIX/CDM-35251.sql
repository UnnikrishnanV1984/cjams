/*
 * CDM-35251 - data fix request to transfer info
 * Customer Email ID:julie.boyd@montgomerycountymd.gov
 * Customer Name:Julie Boyd
 * Focus Area:Contacts: Notes
 * Description - 231030215198:Hi, I am requesting a data fix to transfer contacts/assessments (any other case info that typically transfers during case connect) 
 * from IR 231021078288 to service case #231030215198. CPS worker closed the IR case before connecting to the service case and a new intake/service case were opened. 
 * Family Pres worker Nathaniel Tipton needs IR case info to provide ongoing services. Thank
 * 
 */

SELECT  
count(1) over() ,    
PN.EntityTypeId, 
PN.ProgressNoteId,
PN.intakeserviceid, 
PN.servicecaseid, 
PN.ProgressNoteTypeId,
pn.insertedby,
tma.TeamMemberId, 
tm.TeamId, 
PN.progressnotepurposetypekey 
FROM  ProgressNote AS PN 
INNER JOIN ProgressNoteType AS PNT ON PNT.ProgressNoteTypeId = PN.ProgressNoteTypeId        
LEFT JOIN UserProfile up on pn.insertedby = up.SecurityUsersId  
LEFT JOIN DocumentProperties DP On DP.DocumentPropertiesId = PN.DocumentPropertiesId                  
LEFT JOIN teammemberassignment tma on  tma.securityusersid = up.securityusersid AND tma.ActiveFlag = 1                
LEFT JOIN TeamMember tm on tm.TeamMemberId = tma.TeamMemberId AND tm.ActiveFlag = 1                
LEFT JOIN Team te on te.TeamId = tm.TeamId AND te.ActiveFlag = 1
LEFT JOIN Progressnoteroletype AS PNRT ON PN.ProgressNoteId = PNRT.ProgressNoteId AND PNRT.ActiveFlag = 1
LEFT JOIN progressnotepurposetype AS PNPT ON PNPT.progressnotepurposetypekey = PN.progressnotepurposetypekey AND PNRT.ActiveFlag = 1          
where (PN.EntityTypeId in ( '9c32885e-2260-4a47-aded-c7660a36b1c1' :: character varying));

update cjams.progressnote 
SET entitytypeid='ed0e4d0a-4cf2-48d2-918a-d824fd8acfd7', 
	updatedby = 'CDM-35251',
	updatedon = now()       
where (entitytypeid in ( '9c32885e-2260-4a47-aded-c7660a36b1c1' :: character varying)); 

select distinct assessmenttemplateid ,assessmentid, objectid, servicecaseid  from assessment where objectid  in ('9c32885e-2260-4a47-aded-c7660a36b1c1','ed0e4d0a-4cf2-48d2-918a-d824fd8acfd7');	
UPDATE cjams.assessment
SET objectid='ed0e4d0a-4cf2-48d2-918a-d824fd8acfd7'::uuid, servicecaseid='ed0e4d0a-4cf2-48d2-918a-d824fd8acfd7'::uuid,  
	updatedby = 'CDM-35251',
	updatedon = now()   
WHERE objectid  in ('9c32885e-2260-4a47-aded-c7660a36b1c1');
