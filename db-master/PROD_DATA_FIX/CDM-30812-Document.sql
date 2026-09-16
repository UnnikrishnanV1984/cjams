-- CDM-30812 - Document did not Save   
-- CPS-IR: 202104305983 

-- Category/ Module: Services
-- Root cause: Additional objected id inserted null   
-- Pull request# 
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A 



update documentproperties set additionalobjectid ='2115300', updatedby ='CDM-30812', updatedon =now()

where documentpropertiesid ='d76c3bb0-0818-41f2-b7e0-a1d03eda197f';