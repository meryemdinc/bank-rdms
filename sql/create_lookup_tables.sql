CREATE TABLE lookup_transaction_types (
    transaction_type_id SERIAL PRIMARY KEY,
    transaction_name VARCHAR(50) NOT NULL UNIQUE
);
