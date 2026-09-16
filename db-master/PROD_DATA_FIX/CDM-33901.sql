/*
 * CDM-33901 - missed mandate warning
 * Customer Email ID:jacksj06@montgomerycountymd.gov
 * Customer Name:Jessica Jackson
 * Severity:Critical
 * Focus Area:Contacts: Notes
 * Description - 231020923823:I have an alert that a mandate was missed. The mandate was not missed and the contact was documented accurately. 
 * data fix is needed to update the answer to Yes
 * 
 */

SELECT dangertoself,isdangertoworker,initialresponse
				from personrole WHERE activeflag=1 
				and (('32afb845-69e2-41c2-ac7a-5cb41ef30e73' is not null and intakeserviceid='32afb845-69e2-41c2-ac7a-5cb41ef30e73' ) 
				OR ('I231011010572' is not null and intakenumber='I231011010572'))
				AND  personid = '88f33639-79a8-4883-960d-29479241df67';
				
UPDATE cjams.personrole 
SET initialresponse=1, updatedby='CDM-33901', updatedon=now() 
WHERE activeflag=1 
and (('32afb845-69e2-41c2-ac7a-5cb41ef30e73' is not null and intakeserviceid='32afb845-69e2-41c2-ac7a-5cb41ef30e73' ) 
OR ('I231011010572' is not null and intakenumber='I231011010572'))
AND personid = '88f33639-79a8-4883-960d-29479241df67'; 
