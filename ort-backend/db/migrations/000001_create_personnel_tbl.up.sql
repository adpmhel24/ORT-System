-- Create "personnels" table
CREATE TABLE personnel (
    id SERIAL PRIMARY KEY,
    full_name TEXT NOT NULL,
    role TEXT NOT NULL,
    is_active BOOLEAN DEFAULT TRUE,
);

-- Create "personnel_logs" table
CREATE TABLE personnel_logs (
    id SERIAL PRIMARY KEY,
    personnel_id INTEGER NOT NULL,
    user_id INTEGER,
    log_date DATE,
    action TEXT,
    remarks TEXT,
    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP DEFAULT NOW(),
    deleted_at TIMESTAMP NULL,

    CONSTRAINT fk_personnel
        FOREIGN KEY (personnel_id)
        REFERENCES personnel(id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,

    CONSTRAINT fk_user
        FOREIGN KEY (user_id)
        REFERENCES user(id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
);


-- ✅ Add indexes for faster lookups
CREATE INDEX idx_personnel_logs_personnel_id ON personnel_logs(personnel_id);
CREATE INDEX idx_personnel_logs_user_id ON personnel_logs(user_id);
