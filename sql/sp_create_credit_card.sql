CREATE OR REPLACE PROCEDURE sp_create_credit_card(
    in_account_id INT,
    in_card_number CHAR(16),
    in_expiry_month INT,
    in_expiry_year INT,
    in_ccv CHAR(3),
    in_limit NUMERIC
)
LANGUAGE plpgsql
AS $$
BEGIN
    INSERT INTO cards (account_id, card_number, expiry_month, expiry_year, ccv, card_type_id, card_status_id, limit_amount, is_credit)
    VALUES (
        in_account_id,
        in_card_number,
        in_expiry_month,
        in_expiry_year,
        in_ccv,
        (SELECT card_type_id FROM card_type WHERE name = 'credit_card'),
        (SELECT card_status_id FROM card_status WHERE name = 'active'),
        in_limit,
        TRUE
    );
END;
$$;

