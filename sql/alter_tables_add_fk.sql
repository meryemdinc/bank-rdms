-- Accounts → Customers
ALTER TABLE accounts
    ADD CONSTRAINT fk_accounts_customer FOREIGN KEY (customer_id) REFERENCES customers(customer_id);

-- Cards → Accounts
ALTER TABLE cards
    ADD CONSTRAINT fk_cards_account FOREIGN KEY (account_id) REFERENCES accounts(account_id);

-- Transactions → Cards
ALTER TABLE transactions
    ADD CONSTRAINT fk_transactions_card FOREIGN KEY (card_id) REFERENCES cards(card_id);

-- Transactions → Accounts
ALTER TABLE transactions
    ADD CONSTRAINT fk_transactions_account FOREIGN KEY (account_id) REFERENCES accounts(account_id);

-- Transactions → Lookup Transaction Types
ALTER TABLE transactions
    ADD CONSTRAINT fk_transactions_type FOREIGN KEY (transaction_type_id) REFERENCES lookup_transaction_types(transaction_type_id);
