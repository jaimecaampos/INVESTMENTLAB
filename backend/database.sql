create database investmentLab;

-- Creacion de tablas 
-- te falta añadir la tabla de consulta a api 


CREATE TYPE asset_type AS ENUM (
  'stock',
  'etf',
  'crypto',
  'bond',
  'fund'
);

CREATE TYPE interval_type AS ENUM (
  '1m',
  '5m',
  '15m',
  '1h',
  '1d'
);



CREATE TABLE users (
  id_user BIGSERIAL PRIMARY KEY,
  name VARCHAR(150) NOT NULL,
  password VARCHAR(150) NOT NULL,
  username VARCHAR(150) UNIQUE NOT NULL,
  email VARCHAR(150) UNIQUE NOT NULL,
  phone VARCHAR(20),
  created_at TIMESTAMP DEFAULT NOW(),
  updated_at TIMESTAMP DEFAULT NOW()
);



CREATE TABLE portfolio (
  id_portfolio BIGSERIAL PRIMARY KEY,
  name VARCHAR(150) NOT NULL,
  id_user BIGINT NOT NULL,
  currency VARCHAR(10) NOT NULL,
  created_at TIMESTAMP DEFAULT NOW(),
  updated_at TIMESTAMP DEFAULT NOW(),

  CONSTRAINT fk_user
    FOREIGN KEY (id_user)
    REFERENCES users(id_user)
    ON DELETE CASCADE
);


CREATE TABLE instrument (
  id_instrument BIGSERIAL PRIMARY KEY,
  symbol VARCHAR(20) UNIQUE NOT NULL,
  name VARCHAR(150) NOT NULL,
  country VARCHAR(50),
  currency VARCHAR(10),
  industry VARCHAR(100),
  type_of_asset asset_type NOT NULL
);


CREATE TABLE intportfolioinstrument (
  id BIGSERIAL PRIMARY KEY,
  portfolio_id BIGINT NOT NULL,
  instrument_id BIGINT NOT NULL,
  quantity BIGINT NOT NULL,
  avg_price NUMERIC(18,4) NOT NULL,
  created_at TIMESTAMP DEFAULT NOW(),
  updated_at TIMESTAMP DEFAULT NOW(),

  CONSTRAINT fk_portfolio
    FOREIGN KEY (portfolio_id)
    REFERENCES portfolio(id_portfolio)
    ON DELETE CASCADE,

  CONSTRAINT fk_instrument
    FOREIGN KEY (instrument_id)
    REFERENCES instrument(id_instrument)
    ON DELETE CASCADE,

  CONSTRAINT unique_portfolio_instrument
    UNIQUE (portfolio_id, instrument_id)
);


CREATE TABLE instrumentprice (
  id BIGSERIAL PRIMARY KEY,
  instrument_id BIGINT NOT NULL,
  open_price NUMERIC(18,4) NOT NULL,
  closing_price NUMERIC(18,4) NOT NULL,
  highest_price NUMERIC(18,4) NOT NULL,
  lowest_price NUMERIC(18,4) NOT NULL,
  consult_date TIMESTAMP NOT NULL,
  time_intervals interval_type NOT NULL,

  CONSTRAINT fk_instrument_price
    FOREIGN KEY (instrument_id)
    REFERENCES instrument(id_instrument)
    ON DELETE CASCADE
);