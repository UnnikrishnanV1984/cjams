
ALTER TYPE getdsdsactionsummarydtls_type DROP ATTRIBUTE  IF exists da_reporterincidentdate;
ALTER TYPE getdsdsactionsummarydtls_type DROP ATTRIBUTE  IF exists da_intakedaterecieved;

ALTER TYPE getdsdsactionsummarydtls_type ADD ATTRIBUTE da_reporterincidentdate timestamp;
ALTER TYPE getdsdsactionsummarydtls_type ADD ATTRIBUTE da_intakedaterecieved timestamp;