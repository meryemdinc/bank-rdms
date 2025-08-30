CREATE OR REPLACE PROCEDURE sp_create_customer(
    in_full_name VARCHAR,
    in_tc_no CHAR(11),
    in_birth_place VARCHAR,
    in_birth_date DATE
)
LANGUAGE plpgsql
AS $$
DECLARE
    new_customer_id INT;
BEGIN
    -- müşteri ekle
    INSERT INTO customers (full_name, tc_no, birth_place, birth_date, risk_limit, created_at)
    VALUES (in_full_name, in_tc_no, in_birth_place, in_birth_date, 10000, NOW())
    RETURNING customer_id INTO new_customer_id;

    -- otomatik 1 adet hesap ekle
    INSERT INTO accounts (customer_id, account_name, account_number, iban, opened_at, is_active)
    VALUES (
        new_customer_id,
        'Default Account',
        concat('ACC', new_customer_id),
        concat('TR', lpad((floor(random() * 1000000000000000)::bigint)::text, 22, '0')), 
        NOW(),
        TRUE
    );
END;
$$;

