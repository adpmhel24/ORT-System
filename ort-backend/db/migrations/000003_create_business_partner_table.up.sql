CREATE TABLE business_partner(
    id SERIAL PRIMARY KEY,
    bp_name TEXT UNIQUE NOT NULL,
    bp_type TEXT UNIQUE NOT NULL,
    is_active BOOLEAN DEFAULT TRUE,
    address TEXT NULL,
)

CREATE TABLE business_partner_logs(
    id SERIAL PRIMARY KEY,
    bp_id INTEGER NOT NULL,
    user_id INTEGER,
    log_date DATE,
    action TEXT,
    remarks TEXT,
    created_at TIMESTAMP DEFAULT NOW(),

    CONSTRAINT fk_business_partner
        FOREIGN KEY (bp_id)
        REFERENCES business_partner(id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,

    CONSTRAINT fk_user
        FOREIGN KEY (user_id)
        REFERENCES user(id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT

)