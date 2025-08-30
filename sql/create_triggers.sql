-- Audit log tablosu (varsa sil, sonra oluştur)
DROP TABLE IF EXISTS audit_logs CASCADE;

CREATE TABLE audit_logs (
    log_id SERIAL PRIMARY KEY,
    table_name VARCHAR(50),
    operation_type VARCHAR(10),
    record_id INT,
    old_data JSONB,
    new_data JSONB,
    changed_at TIMESTAMP DEFAULT NOW()
);

-- Audit trigger fonksiyonu
CREATE OR REPLACE FUNCTION fn_audit_log()
RETURNS TRIGGER AS $$
DECLARE
    rec_id INT;
BEGIN
    -- record_id belirle (hem INSERT hem DELETE için)
    IF TG_OP = 'INSERT' THEN
        rec_id := NEW.customer_id;
    ELSIF TG_OP = 'UPDATE' THEN
        rec_id := NEW.customer_id;
    ELSIF TG_OP = 'DELETE' THEN
        rec_id := OLD.customer_id;
    END IF;

    -- Audit kaydı ekle
    INSERT INTO audit_logs(table_name, operation_type, record_id, old_data, new_data, changed_at)
    VALUES (
        TG_TABLE_NAME,
        TG_OP,
        rec_id,
        CASE WHEN OLD.* IS NOT NULL THEN row_to_json(OLD)::jsonb ELSE NULL END,
        CASE WHEN NEW.* IS NOT NULL THEN row_to_json(NEW)::jsonb ELSE NULL END,
        NOW()
    );

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Customers tablosu için trigger
DROP TRIGGER IF EXISTS trg_customers_audit ON customers;

CREATE TRIGGER trg_customers_audit
AFTER INSERT OR UPDATE OR DELETE ON customers
FOR EACH ROW EXECUTE FUNCTION fn_audit_log();
