/*
 * CDM-34716 - Error Made
 * Customer Email ID:susan.kansler@maryland.gov
 * Customer Name:Susan Kansler
 * Focus Area:Contacts: Notes
 * Sub Component:Application
 * Description - 231021159282:Hello,An error was made when choosing "completed" instead of "attempted" contact. 
 * change the contact from "completed" to "attempted" for the contact id # 11580903
 */				
				
select progressnoteid, contactstatus, * from progressnote where witsid = 11580903;
UPDATE cjams.progressnote
SET contactstatus=false, updatedby='CDM-34716', updatedon=now() 
WHERE progressnoteid='badbb718-2b4d-41bf-a196-47e74a0bd33a'; 