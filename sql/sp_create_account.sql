CREATE OR REPLACE PROCEDURE sp_create_account(
    in_customer_id INT,
    in_account_name VARCHAR,
    in_account_number VARCHAR,
    in_iban VARCHAR
)
LANGUAGE plpgsql
AS $$
BEGIN
    INSERT INTO accounts (customer_id, account_name, account_number, iban, opened_at, is_active)
    VALUES (in_customer_id, in_account_name, in_account_number, in_iban, NOW(), TRUE);
END;
$$;
