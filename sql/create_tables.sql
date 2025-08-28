CREATE TABLE customers (
    customer_id SERIAL PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    tc_no CHAR(11) UNIQUE NOT NULL,
    birth_place VARCHAR(50),
    birth_date DATE,
    risk_limit NUMERIC(12,2) DEFAULT 10000.00,
    created_at TIMESTAMP DEFAULT NOW()
);
CREATE TABLE accounts (
    account_id SERIAL PRIMARY KEY,
    customer_id INT NOT NULL REFERENCES customers(customer_id),
    account_name VARCHAR(50) NOT NULL,
    account_number CHAR(16) UNIQUE NOT NULL,
    iban CHAR(26) UNIQUE NOT NULL,
    balance NUMERIC(12,2) DEFAULT 0,
    status BOOLEAN DEFAULT TRUE, -- TRUE=active, FALSE=inactive
    created_at TIMESTAMP DEFAULT NOW()
);
CREATE TABLE cards (
    card_id SERIAL PRIMARY KEY,
    account_id INT REFERENCES accounts(account_id),
    card_number CHAR(16) UNIQUE NOT NULL,
    card_type VARCHAR(20) NOT NULL, -- "account" veya "credit"
    expiry_date DATE,
    ccv CHAR(3),
    limit NUMERIC(12,2) DEFAULT 0, -- kredi kartı limiti
    active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT NOW()
);
CREATE TABLE transactions (
    transaction_id SERIAL PRIMARY KEY,
    card_id INT REFERENCES cards(card_id),
    account_id INT REFERENCES accounts(account_id),
    transaction_type VARCHAR(20) NOT NULL, -- "deposit", "withdraw", "payment"
    amount NUMERIC(12,2) NOT NULL,
    description VARCHAR(100),
    created_at TIMESTAMP DEFAULT NOW()
);
CREATE TABLE audit_logs (
    audit_id SERIAL PRIMARY KEY,
    table_name VARCHAR(50) NOT NULL,
    operation_type VARCHAR(10) NOT NULL, -- "INSERT", "UPDATE", "DELETE"
    record_id INT NOT NULL,
    operation_time TIMESTAMP DEFAULT NOW()
);
