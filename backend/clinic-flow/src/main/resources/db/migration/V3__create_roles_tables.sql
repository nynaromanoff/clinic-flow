CREATE TABLE roles (
    id UUID PRIMARY KEY,
    name VARCHAR(50) NOT NULL UNIQUE,
    description VARCHAR(255),
    created_at TIMESTAMP WITH TIME ZONE
        NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Relacionamento muitos-para-muitos entre usuários e papéis
CREATE TABLE user_roles (
    user_id UUID NOT NULL,
    role_id UUID NOT NULL,
    assigned_at TIMESTAMP WITH TIME ZONE
        NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT pk_user_roles
        PRIMARY KEY (user_id, role_id),

    CONSTRAINT fk_user_roles_user
        FOREIGN KEY (user_id)
        REFERENCES users (id)
        ON DELETE CASCADE,

    CONSTRAINT fk_user_roles_role
        FOREIGN KEY (role_id)
        REFERENCES roles (id)
        ON DELETE RESTRICT
);

CREATE INDEX idx_user_roles_role_id
    ON user_roles (role_id);

INSERT INTO roles (id, name, description)
VALUES
    (
        gen_random_uuid(),
        'ADMIN',
        'Administrador da clínica'
    ),
    (
        gen_random_uuid(),
        'RECEPTIONIST',
        'Responsável pela recepção e agendamentos'
    ),
    (
        gen_random_uuid(),
        'PROFESSIONAL',
        'Profissional de saúde'
    );
