DO $$
DECLARE
    new_customer_id INT;
    new_account_id INT;
    new_card_id INT;
BEGIN
    -- Müşteri oluştur
    INSERT INTO customers (full_name, tc_no, birth_place, birth_date)
    VALUES ('Gün Gören', '11111111111', 'Eskişehir', '1993-02-01')
    RETURNING customer_id INTO new_customer_id;

    -- Hesap oluştur
    INSERT INTO accounts (customer_id, account_name, account_number, iban)
    VALUES (new_customer_id, 'Vadesiz Anadolu', '1234154645788999', 'TR011234154645788999')
    RETURNING account_id INTO new_account_id;

    -- Kart oluştur (hesap kartı)
    INSERT INTO cards (account_id, card_number, expiry_month, expiry_year, ccv, limit_amount, is_credit)
    VALUES (new_account_id, '5555444433332222', 12, 2030, '123', 20000, FALSE)
    RETURNING card_id INTO new_card_id;

    -- İşlem örneği: para yatırma
    INSERT INTO transactions (card_id, account_id, transaction_type_id, amount, description)
    VALUES (
        new_card_id,
        new_account_id,
        (SELECT transaction_type_id FROM lookup_transaction_types WHERE transaction_name = 'Para Yatırma'),
        5000,
        'ATM üzerinden para yatırma'
    );
END;
$$;
