/*
   Issue Description: CDM-15924
   Category/ Module  :  
   Root cause: updating Gap disclosure
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

UPDATE cjams.gapdisclosure
SET disclosuredate='2021-09-13 08:34:30.293', ischildplacedsixmonths=true, isproviderapprovedgap=true, iscourthearingcustody=true, isreunificationremoved=true, isadoptionremoved=true, iscgprovidesafe=true, isothergapfinsupport=true, iscgattendedorientation=true, orientationmeetingdate='2021-09-13 08:34:30.293', isrequirementdiscussed=true, iscgparticipategap=true, iscgenteredagreement=true, iscgcompleteauthorization=true, iscgaftercareservice=true, isneedadditionalservices=true, iscgcompleteannualreview=true, issuspendedfromguardian=true, updatedby='CDM-15924', updatedon=now(), issuccessorguardianexists=true, isconsultationchildage=true, isguardianattach=true, isguardiantwoattach=true
WHERE gapid in ('755faa37-7d8f-4c09-a085-4434632bc22e','54b6a1c2-4f4f-403e-a09e-9b13dbc980bf');
