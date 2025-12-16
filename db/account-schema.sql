CREATE TABLE accounts (
    id              BIGSERIAL PRIMARY KEY,
    account_number  VARCHAR(50) NOT NULL UNIQUE,
    customer_id     VARCHAR(50) NOT NULL,
    balance         NUMERIC(15,2) NOT NULL,
    active          BOOLEAN NOT NULL DEFAULT true,
    created_at      TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE account_movements (
    id              BIGSERIAL PRIMARY KEY,
    account_number  VARCHAR(50) NOT NULL,
    amount          NUMERIC(15,2) NOT NULL,
    movement_type   VARCHAR(20) NOT NULL,
    created_at      TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);