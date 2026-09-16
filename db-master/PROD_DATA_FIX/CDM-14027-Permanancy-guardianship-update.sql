update gapdisclosure 
set iscgprovidesafe = true
    , isothergapfinsupport = true
    , iscgattendedorientation = true
    , isrequirementdiscussed = true
    , iscgparticipategap = true
    , iscgenteredagreement = true
    , iscgcompleteauthorization = true
    , iscgaftercareservice = true
    , isneedadditionalservices = true
    , iscgcompleteannualreview = true
    , issuspendedfromguardian = true
    , isguardianattach = true
    , isguardiantwoattach = true
    , updatedby = 'CDM-14027'
    , updatedon = now()
where gapdisclosureid = '67de58db-e99a-4963-a8ac-026794459e6f';