update cjams.personaddresstype set activeflag=0 
where personaddresstypekey not in (
select ref_key from referencevalues
);
