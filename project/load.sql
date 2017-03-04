-- Drop the previous table declarations.
@&efb4\drop         
commit;
-- Reload the table declarations.
@&efb4\schema
commit;
-- Load the table data.
@&efb4\data
commit;