-- Customers
CREATE TABLE customers (
    id          BIGSERIAL PRIMARY KEY,
    customer_id VARCHAR(50) NOT NULL UNIQUE,
    password    VARCHAR(100),
    person_id   BIGINT,
    active      BOOLEAN NOT NULL DEFAULT true,
    created_at  TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);
-- Accounts
CREATE TABLE accounts (
    id               BIGSERIAL PRIMARY KEY,
    account_number   VARCHAR(50) NOT NULL UNIQUE,
    customer_id      VARCHAR(50) NOT NULL,
    account_type     VARCHAR(30) NOT NULL,
    initial_balance  NUMERIC(15,2) NOT NULL,
    current_balance  NUMERIC(15,2) NOT NULL,
    active           BOOLEAN NOT NULL DEFAULT true,
    created_at       TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Account movements 
CREATE TABLE account_movements (
    id              BIGSERIAL PRIMARY KEY,
    account_number  VARCHAR(50) NOT NULL,
    amount          NUMERIC(15,2) NOT NULL,
    movement_type   VARCHAR(20) NOT NULL,
    created_at      TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);