-- D-26005

ALTER TABLE cjams.intakeservicerequest ADD responsetimer timestamp NULL;

ALTER TYPE getdsdsactionsummarydtls_type DROP ATTRIBUTE  IF exists da_responsetime;
ALTER TYPE getdsdsactionsummarydtls_type ADD ATTRIBUTE da_responsetime timestamp;