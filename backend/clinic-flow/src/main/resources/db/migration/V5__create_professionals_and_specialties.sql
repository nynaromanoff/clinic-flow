CREATE TABLE professionals (
    id UUID PRIMARY KEY,
    name VARCHAR(150) NOT NULL,
    cpf VARCHAR(11),
    birth_date DATE,
    email VARCHAR(180),
    phone VARCHAR(20),
    created_at TIMESTAMP WITH TIME ZONE
        NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITH TIME ZONE
        NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT chk_professionals_cpf
        CHECK (
            cpf IS NULL
            OR cpf ~ '^[0-9]{11}$'
        )
);

CREATE UNIQUE INDEX idx_professionals_cpf
    ON professionals (cpf)
    WHERE cpf IS NOT NULL;

CREATE TABLE professional_credentials (
    id UUID PRIMARY KEY,
    professional_id UUID NOT NULL,
    council_type VARCHAR(20) NOT NULL,
    registration_number VARCHAR(30) NOT NULL,
    state CHAR(2) NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE
        NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT fk_professional_credentials_professional
        FOREIGN KEY (professional_id)
        REFERENCES professionals (id)
        ON DELETE CASCADE,

    CONSTRAINT chk_professional_credentials_state
        CHECK (state ~ '^[A-Z]{2}$')
);

CREATE UNIQUE INDEX idx_professional_credentials_unique
    ON professional_credentials (
        council_type,
        state,
        registration_number
    );

CREATE INDEX idx_professional_credentials_professional
    ON professional_credentials (professional_id);


CREATE TABLE clinic_professionals (
    id UUID PRIMARY KEY,
    clinic_id UUID NOT NULL,
    professional_id UUID NOT NULL,
    active BOOLEAN NOT NULL DEFAULT TRUE,
    created_at TIMESTAMP WITH TIME ZONE
        NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITH TIME ZONE
        NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT fk_clinic_professionals_clinic
        FOREIGN KEY (clinic_id)
        REFERENCES clinics (id)
        ON DELETE RESTRICT,

    CONSTRAINT fk_clinic_professionals_professional
        FOREIGN KEY (professional_id)
        REFERENCES professionals (id)
        ON DELETE RESTRICT,

    CONSTRAINT uk_clinic_professional
        UNIQUE (clinic_id, professional_id)
);

CREATE INDEX idx_clinic_professionals_clinic
    ON clinic_professionals (clinic_id);

CREATE INDEX idx_clinic_professionals_professional
    ON clinic_professionals (professional_id);

CREATE INDEX idx_clinic_professionals_active
    ON clinic_professionals (clinic_id, active);

CREATE TABLE specialties (
    id UUID PRIMARY KEY,
    name VARCHAR(120) NOT NULL,
    slug VARCHAR(120) NOT NULL UNIQUE,
    description VARCHAR(255),
    active BOOLEAN NOT NULL DEFAULT TRUE,
    created_at TIMESTAMP WITH TIME ZONE
        NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT uk_specialties_name
        UNIQUE (name)
);


CREATE TABLE clinic_professional_specialties (
    clinic_professional_id UUID NOT NULL,
    specialty_id UUID NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE
        NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT pk_clinic_professional_specialties
        PRIMARY KEY (clinic_professional_id, specialty_id),

    CONSTRAINT fk_cps_clinic_professional
        FOREIGN KEY (clinic_professional_id)
        REFERENCES clinic_professionals (id)
        ON DELETE CASCADE,

    CONSTRAINT fk_cps_specialty
        FOREIGN KEY (specialty_id)
        REFERENCES specialties (id)
        ON DELETE RESTRICT
);

CREATE INDEX idx_cps_specialty
    ON clinic_professional_specialties (specialty_id);
