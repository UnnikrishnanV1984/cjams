/*
   Issue Description: CIDM-8675
   Child support  : data displaying key values
   Root cause: data displaying key values, need code fix for upcoming cases and data fix for current cases
   Fix provided by updating the current cases with data update query
*/
update csesclientsupportorder 
SET sopaymentfreqtypekey =
    coalesce( 
          (select description from referencevalues where referencetypeid = '190' AND btrim(ref_key) = btrim(sopaymentfreqtypekey) ),
          (select value_tx from cjams.tb_picklist_values where picklist_type_id = 254 and btrim(picklist_value_cd) = btrim(sopaymentfreqtypekey) )
         ) 
where sopaymentfreqtypekey is not null 
    and btrim(sopaymentfreqtypekey) <> ''
    and activeflag = 1 ;


update csesclientsupportorder 
set sostatustypekey = 'Final', updatedby='CIDM-8675', updatedon=now() 
where sostatustypekey = 'F';

update csesclientsupportorder 
set sostatustypekey = 'Pending', updatedby='CIDM-8675', updatedon=now() 
where sostatustypekey = 'P';