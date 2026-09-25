# Salon Appointment System ✂️💈

An interactive command-line application built with Bash and PostgreSQL to manage a men's salon database. 

## 🛠️ Technologies Used
* **Bash Scripting:** Handles the interactive terminal menu, user input validation, and database querying.
* **PostgreSQL & SQL:** Relational database management, table constraints, and dynamic data insertion.

## 🗂️ Project Structure
* **`salon.sh`**: The executable script that displays the service menu, registers new customers, and books appointment times.
* **`salon.sql`**: The database dump containing the complete schema and initial data.

## 📊 Database Schema
The `salon` database consists of three related tables:
* **`services`**: Stores available salon services like haircuts, beard trims, and fades.
* **`customers`**: Stores customer names and unique phone numbers.
* **`appointments`**: Links customers to their chosen services and booking times using foreign keys.

## 🚀 How to Run
1. Rebuild the database using the SQL dump:
   ```bash
   psql -U freecodecamp < salon.sql
