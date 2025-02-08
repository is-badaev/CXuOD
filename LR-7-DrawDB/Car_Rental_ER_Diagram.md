# Car_Rental_ER_Diagram documentation
## Summary

- [Introduction](#introduction)
- [Database Type](#database-type)
- [Table Structure](#table-structure)
	- [Clients](#Clients)
	- [Cars](#Cars)
	- [Rental](#Rental)
	- [Insurance](#Insurance)
- [Relationships](#relationships)
- [Database Diagram](#database-Diagram)

## Introduction

## Database type

- **Database system:** PostgreSQL
## Table structure

### Clients

| Name        | Type          | Settings                      | References                    | Note                           |
|-------------|---------------|-------------------------------|-------------------------------|--------------------------------|
| **client_id** | INTEGER | 🔑 PK, not null , unique, autoincrement | fk_Clients_client_id_Rental | |
| **full_name** | VARCHAR(100) | not null  |  | |
| **passport_series_number** | BIGINT | not null , unique |  | | 


#### Indexes
| Name | Unique | Fields |
|------|--------|--------|
| client_index_0 | ✅ | passport_series_number |
| client_index_1 |  | full_name |
### Cars

| Name        | Type          | Settings                      | References                    | Note                           |
|-------------|---------------|-------------------------------|-------------------------------|--------------------------------|
| **car_id** | INTEGER | 🔑 PK, not null , unique, autoincrement | fk_Cars_car_id_Rental,fk_Cars_car_id_Insurance | |
| **model** | VARCHAR(50) | not null  |  | |
| **color** | VARCHAR(50) | not null  |  | |
| **year_of_manufacture** | SMALLINT | not null  |  | |
| **license_plate** | VARCHAR(25) | not null , unique |  | |
| **insurance_value** | NUMERIC(10, 2) | not null  |  | |
| **rental_price_per_day** | NUMERIC(8, 2) | not null  |  | | 


#### Indexes
| Name | Unique | Fields |
|------|--------|--------|
| car_index_0 |  | model |
| car_index_1 | ✅ | license_plate |
| car_index_2 |  | rental_price_per_day |
| car_index_3 |  | insurance_value |
### Rental

| Name        | Type          | Settings                      | References                    | Note                           |
|-------------|---------------|-------------------------------|-------------------------------|--------------------------------|
| **rental_id** | INTEGER | 🔑 PK, not null , unique, autoincrement |  | |
| **client_id** | INTEGER | not null  |  | |
| **car_id** | INTEGER | not null  |  | |
| **start_date** | DATE | not null  |  | |
| **end_date** | DATE | not null  |  | |
| **rental_days** | INTEGER | not null  |  | | 


### Insurance

| Name        | Type          | Settings                      | References                    | Note                           |
|-------------|---------------|-------------------------------|-------------------------------|--------------------------------|
| **insurance_id** | INTEGER | 🔑 PK, not null , unique, autoincrement |  | |
| **car_id** | INTEGER | not null  |  | |
| **insurance_value** | NUMERIC(10, 2) | not null  |  | |
| **insurance_fee** | NUMERIC(8, 2) | not null  |  | | 


## Relationships

- **Clients to Rental**: one_to_many
- **Cars to Rental**: one_to_many
- **Cars to Insurance**: one_to_one

## Database Diagram

```mermaid
erDiagram
	Clients ||--o{ Rental : references
	Cars ||--o{ Rental : references
	Cars ||--|| Insurance : references

	Clients {
		INTEGER client_id
		VARCHAR(100) full_name
		BIGINT passport_series_number
	}

	Cars {
		INTEGER car_id
		VARCHAR(50) model
		VARCHAR(50) color
		SMALLINT year_of_manufacture
		VARCHAR(25) license_plate
		NUMERIC(10, 2) insurance_value
		NUMERIC(8, 2) rental_price_per_day
	}

	Rental {
		INTEGER rental_id
		INTEGER client_id
		INTEGER car_id
		DATE start_date
		DATE end_date
		INTEGER rental_days
	}

	Insurance {
		INTEGER insurance_id
		INTEGER car_id
		NUMERIC(10, 2) insurance_value
		NUMERIC(8, 2) insurance_fee
	}
```