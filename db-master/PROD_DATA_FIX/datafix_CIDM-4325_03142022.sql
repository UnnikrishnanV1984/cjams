-- To update newly added column progressnoteid in progressnote_audit_detail table

-- Before 
select count(*) 
	from progressnote_audit_detail
where progressnoteid is null ;

update progressnote_audit_detail pd
set pd.progressnoteid = ( select pt.progressnoteid from progressnote pt where pt.witsid = pd.conatctid ),
	pd.updatedon = now(),
	pd.updatedby = 'CIDM-4325_0314'
where pd.progressnoteid is null ;

-- After
select count(*) 
	from progressnote_audit_detail
where progressnoteid is null ;
