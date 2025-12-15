# Logistics Data Cleaning & Reporting Pipeline

## Overview
This project simulates a logistics data operations workflow where raw shipment and customer data is cleaned, validated, and loaded into SQL tables to support recurring internal reports.

## Data Cleaning
- Removed duplicate records
- Standardized mixed date formats (M/D/YYYY, YYYY-MM-DD)
- Normalized text fields (status, region)
- Handled missing values

## Data Validation
- Checked for duplicate shipment IDs
- Identified missing foreign keys
- Verified total shipment cost

## Reporting
- Shipments and cost by customer
- Shipment status summary

## Tools
- MySQL
- MySQL Workbench
- SQL
- CSV files

## Focus
Accuracy, data integrity, and repeatable processes.
