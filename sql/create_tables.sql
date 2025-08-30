-- Customers
CREATE TABLE customers (
    customer_id SERIAL PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    tc_no CHAR(11) NOT NULL UNIQUE,
    birth_place VARCHAR(50),
    birth_date DATE,
    risk_limit NUMERIC(15,2) DEFAULT 10000,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Accounts
CREATE TABLE accounts (
    account_id SERIAL PRIMARY KEY,
    customer_id INT NOT NULL REFERENCES customers(customer_id) ON DELETE CASCADE,
    account_name VARCHAR(50) NOT NULL,
    account_number VARCHAR(20) NOT NULL UNIQUE,
    iban CHAR(26) NOT NULL UNIQUE,
    opened_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    is_active BOOLEAN DEFAULT TRUE
);

-- Cards
CREATE TABLE cards (
    card_id SERIAL PRIMARY KEY,
    account_id INT NULL REFERENCES accounts(account_id) ON DELETE SET NULL,
    card_number CHAR(16) NOT NULL UNIQUE,
    expiry_month INT NOT NULL,
    expiry_year INT NOT NULL,
    ccv CHAR(3),
    limit_amount NUMERIC(15,2),
    is_credit BOOLEAN DEFAULT FALSE,
    is_active BOOLEAN DEFAULT TRUE
);

-- Transactions
CREATE TABLE transactions (
    transaction_id SERIAL PRIMARY KEY,
    card_id INT NOT NULL REFERENCES cards(card_id) ON DELETE CASCADE,
    account_id INT NULL REFERENCES accounts(account_id) ON DELETE SET NULL,
    transaction_type_id INT NOT NULL,
    amount NUMERIC(15,2) NOT NULL,
    description VARCHAR(100),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Audit Logs
CREATE TABLE audit_logs (
    log_id SERIAL PRIMARY KEY,
    table_name VARCHAR(50),
    operation_type VARCHAR(10),
    record_id INT,
    old_data JSONB,
    new_data JSONB,
    changed_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
