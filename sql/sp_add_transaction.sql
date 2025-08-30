CREATE OR REPLACE PROCEDURE sp_add_transaction(
    in_card_id INT,
    in_account_id INT,
    in_transaction_type VARCHAR,
    in_amount NUMERIC,
    in_description VARCHAR
)
LANGUAGE plpgsql
AS $$
DECLARE
    type_id INT;
BEGIN
    -- lookup tablosundan transaction_type_id bul
    SELECT transaction_type_id INTO type_id
    FROM lookup_transaction_types
    WHERE transaction_name = in_transaction_type;

    IF type_id IS NULL THEN
        RAISE EXCEPTION 'Transaction type % not found in lookup_transaction_types', in_transaction_type;
    END IF;

    -- transactions tablosuna kayıt ekle
    INSERT INTO transactions (card_id, account_id, transaction_type_id, amount, description, created_at)
    VALUES (in_card_id, in_account_id, type_id, in_amount, in_description, NOW());

    -- balance güncelleme (hesap kartı işlemleri)
    IF in_transaction_type = 'Para Yatırma' THEN
        UPDATE accounts SET balance = COALESCE(balance,0) + in_amount
        WHERE account_id = in_account_id;
    ELSIF in_transaction_type = 'Para Çekme' THEN
        UPDATE accounts SET balance = COALESCE(balance,0) - in_amount
        WHERE account_id = in_account_id;
    END IF;

    -- Kredi kartı harcaması (limit kontrolü)
    IF in_transaction_type = 'Kart Harcaması' OR in_transaction_type = 'Online Ödeme' THEN
        UPDATE cards SET limit_amount = limit_amount - in_amount
        WHERE card_id = in_card_id;
    END IF;
END;
$$;
