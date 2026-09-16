--D-24707

update routing set routingstatustypeid = 43, remarks= 'Approved', updatedon = now()
where objectid = 741966 and routingstatustypeid=41 and activeflag = 1

-- Remove DJS and AS document types
update attachmentclassificationtype set activeflag = 0, updatedon = now() where activeflag = 1  and attachmentclassificationtypekey like 'AS%'
update attachmentclassificationtype set activeflag = 0, updatedon = now() where activeflag = 1  and attachmentclassificationtypekey like 'JS%'
update attachmentclassificationtype set activeflag = 0, updatedon = now() where activeflag = 1  and attachmentclassificationtypekey like 'OLM%'