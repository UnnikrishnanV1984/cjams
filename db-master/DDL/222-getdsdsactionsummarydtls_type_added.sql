
ALTER TYPE getdsdsactionsummarydtls_type DROP ATTRIBUTE  IF exists da_assignedby;

ALTER TYPE getdsdsactionsummarydtls_type ADD ATTRIBUTE da_assignedby character varying;