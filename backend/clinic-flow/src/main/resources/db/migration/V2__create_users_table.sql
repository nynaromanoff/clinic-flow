CREATE TABLE users (
    id UUID PRIMARY KEY,
    clinic_id UUID NOT NULL,
    name VARCHAR(150) NOT NULL,
    email VARCHAR(180) NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    active BOOLEAN NOT NULL DEFAULT TRUE,
    created_at TIMESTAMP WITH TIME ZONE
        NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITH TIME ZONE
        NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT fk_users_clinic
        FOREIGN KEY (clinic_id)
        REFERENCES clinics (id)
        ON DELETE RESTRICT
);

CREATE UNIQUE INDEX idx_users_clinic_email
    ON users (clinic_id, LOWER(email));
