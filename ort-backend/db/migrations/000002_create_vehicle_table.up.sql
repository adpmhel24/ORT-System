CREATE TABLE vehicles (
    id SERIAL PRIMARY KEY,
    category TEXT NOT NULL,
    plateNumber TEXT NOT NULL,
    maker TEXT NOT NULL,
    year_model INTEGER NOT NULL,
    status TEXT NOT NULL DEFAULT 'available',

);

CREATE TABLE vehicle_logs (
    id SERIAL PRIMARY KEY,
    vehicle_id INTEGER NOT NULL,
    user_id INTEGER,
    log_date TIMESTAMP DEFAULT NOW(),
    action TEXT,
    remarks TEXT,

    CONSTRAINT fk_vehicle
        FOREIGN KEY (vehicle_id)
        REFERENCES vehicles(id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,

    CONSTRAINT fk_user
        FOREIGN KEY (user_id)
        REFERENCES users(id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
);


-- ✅ Add indexes for faster lookups
CREATE INDEX idx_vehicle_logs_vehicle_id ON vehicle_logs(vehicle_id);
CREATE INDEX idx_vehicle_logs_user_id ON vehicle_logs(user_id);
