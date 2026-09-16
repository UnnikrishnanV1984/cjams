-- CDM-37689 - OOH Program Assignment Closed
/* Issue Description: CPS supervisor closed the OOH Program Assignment accidentallyUser request to remove enddate on client #200990163

--  case number: 221030033766
--  caseid: a5b17100-6886-490a-8cb1-511113eafe17
--  personid: c1e03b35-c4ce-4537-9839-a51c4e39a38a

-- Category/ Module: Program Info 

-- Root cause: CPS supervisor closed the OOH Program Assignment accidentallyUser request to remove enddate on client #200990163 
-- Fix Provided: Datafix has been provided to update end date for client #200990163
-- Pull request# N/A

*/

select enddate ,* from personprogramarea p where personid ='c1e03b35-c4ce-4537-9839-a51c4e39a38a' and objectid ='a5b17100-6886-490a-8cb1-511113eafe17';

UPDATE cjams.personprogramarea
SET enddate = null,
updatedon = now(),
updatedby = 'CDM-37689'
where personid ='c1e03b35-c4ce-4537-9839-a51c4e39a38a' and objectid ='a5b17100-6886-490a-8cb1-511113eafe17';
