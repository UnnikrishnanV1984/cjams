update crispconfig set activeflag = 0, updatedby = 'CIDM-8809', updatedon = now()
where cvxcode in ('167', '316') and immunizationkey = 'MENG-B' and activeflag = 1;

update crispconfig set activeflag = 0, updatedby = 'CIDM-8809', updatedon = now()
where cvxcode in ('109', '133', '215', '216') and immunizationkey = 'PNPL' and activeflag = 1;