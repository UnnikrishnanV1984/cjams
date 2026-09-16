update checklist set activeflag=0 where checklistid='c78a4c4e-b87f-49ca-9553-d1ffb14be82e';

update checklist set displayorder=1 where checklisttypekey='COLANG' and checklistname='Child home is not contary';
update checklist set displayorder=2 where checklisttypekey='COLANG' and checklistname='Child home is contrary';
update checklist set displayorder=3 where checklisttypekey='COLANG' and checklistname='Due to emergency nature of situation';
update checklist set displayorder=4 where checklisttypekey='COLANG' and checklistname='Prevent removal';
update checklist set displayorder=5 where checklisttypekey='COLANG' and checklistname='Court has waived reunification efforts';
update checklist set displayorder=6 where checklisttypekey='COLANG' and checklistname='Reasonable not removal';

update checklist set displayorder=7 where checklisttypekey='COLANG' and checklistname='Finalize permanency plan' and description='Reasonable efforts were made to finalize the child''s permanency plan';
update checklist set displayorder=8 where checklisttypekey='COLANG' and checklistname='Finalize permanency plan' and description='Reasonable efforts were not made to finalize the child''s permanency plan';
update checklist set displayorder=9 where checklisttypekey='COLANG' and checklistname='Permanency plan';
update checklist set displayorder=10 where checklisttypekey='COLANG' and checklistname='Voluntary placement';
update checklist set displayorder=11 where checklisttypekey='COLANG' and checklistname='Voluntary placement disinterest';
update checklist set displayorder=12 where checklisttypekey='COLANG' and checklistname='Reasonable unable';
update checklist set displayorder=13 where checklisttypekey='COLANG' and checklistname='Legal custodian';