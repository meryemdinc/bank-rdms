# Bank RDMS Project

## Project Description
This project is a relational database system for a simple banking application.  
It tracks customers, accounts, cards, transactions, and audit logs.

The system allows:
- Creating customers with personal details and default risk limit.
- Creating accounts linked to customers.
- Creating account cards and credit cards with limits.
- Performing transactions: deposits, withdrawals, credit card payments, transfers.
- Tracking all insert/update/delete operations via audit logs.

---

## Folder Structure
- `sql/` : All SQL scripts for creating tables, procedures, triggers, and sample data.
- `docs/` : ERD diagrams and project documentation.
- `README.md` : Project description and usage instructions.

---

## Database Setup
1. Install PostgreSQL.
2. Create a new database named `bank_rdms`.
3. Open `sql/create_tables.sql` and run it to create all tables.
4. Open and run procedures in `sql/` to insert initial data and sample transactions.
5. Use `sql/drop_tables.sql` to remove tables if needed.

---

## Naming Conventions
- **snake_case** is used for all table and column names.
- English is used for all procedure names, variable names, and parameters.
- Each procedure and table has its own `.sql` file.

---

## Sample Data
The project includes procedures to:
- Add a customer with automatic account and default risk limit.
- Add account cards and credit cards with defined limits.
- Perform example transactions according to the project scenario.

---

## Notes
- Audit logs are maintained for all table operations.
- Only one active account card per account is allowed.
- Credit cards can have multiple active cards per customer, subject to risk limits.
