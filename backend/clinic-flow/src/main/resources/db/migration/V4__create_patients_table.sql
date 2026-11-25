CREATE TABLE patients (
    id UUID PRIMARY KEY,
    clinic_id UUID NOT NULL,
    name VARCHAR(150) NOT NULL,
    cpf VARCHAR(11),
    birth_date DATE,
    email VARCHAR(180),
    phone VARCHAR(20),
    active BOOLEAN NOT NULL DEFAULT TRUE,
    created_at TIMESTAMP WITH TIME ZONE
        NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITH TIME ZONE
        NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT fk_patients_clinic
        FOREIGN KEY (clinic_id)
        REFERENCES clinics (id)
        ON DELETE RESTRICT,

    CONSTRAINT chk_patients_cpf
        CHECK (
            cpf IS NULL
            OR cpf ~ '^[0-9]{11}$'
        )
);

CREATE UNIQUE INDEX idx_patients_clinic_cpf
    ON patients (clinic_id, cpf)
    WHERE cpf IS NOT NULL;

CREATE INDEX idx_patients_clinic_name
    ON patients (clinic_id, name);

CREATE INDEX idx_patients_clinic_active
    ON patients (clinic_id, active);
