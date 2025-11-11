# Carma Banking - Local Development Setup

This guide will help you set up the Carma Banking application locally using Docker and PostgreSQL.

## Prerequisites

- **Docker Desktop** (or Docker Engine + Docker Compose)
- **Git** (for cloning/updating the repository)
- **Gmail Account** (for email OTP functionality)
- **Twilio Account** (for SMS OTP functionality) - Optional for basic testing

## Quick Start (5 minutes)

### 1. Clone the Repository (if not already done)

```bash
git clone https://github.com/MoulikArora21/CarmaBanking.git
cd CarmaBanking
```

### 2. Set Up Environment Variables

Create a `.env` file from the example:

```bash
cp .env.example .env
```

Edit `.env` and add your credentials:

```bash
# Gmail Configuration
MAIL_USERNAME=your-email@gmail.com
MAIL_PASSWORD=your-app-specific-password

# Twilio Configuration (optional for basic testing)
TWILIO_ACCOUNT_SID=your-sid
TWILIO_AUTH_TOKEN=your-token
TWILIO_PHONE_NUMBER=+1234567890
```

**Important: Gmail App Password Setup**
1. Go to https://myaccount.google.com/apppasswords
2. Create a new App Password for "Mail"
3. Copy the 16-character password to `MAIL_PASSWORD`

### 3. Start the Application

```bash
docker-compose up --build
```

This will:
- Build the Spring Boot application
- Start PostgreSQL database on port 5432
- Start the application on port 8080

### 4. Access the Application

Open your browser and go to:
- **Application**: http://localhost:8080
- **Login Page**: http://localhost:8080/login

### 5. Stop the Application

Press `Ctrl+C` in the terminal, then run:

```bash
docker-compose down
```

To remove all data and start fresh:

```bash
docker-compose down -v
```

## Development Workflow

### Run in Detached Mode (Background)

```bash
docker-compose up -d
```

### View Logs

```bash
# All services
docker-compose logs -f

# Just the app
docker-compose logs -f app

# Just the database
docker-compose logs -f postgres
```

### Restart After Code Changes

```bash
docker-compose up --build app
```

### Access PostgreSQL Database

```bash
# Using Docker
docker-compose exec postgres psql -U carmauser -d carmabanking

# Or using any PostgreSQL client with these credentials:
# Host: localhost
# Port: 5432
# Database: carmabanking
# Username: carmauser
# Password: carmapass
```

### Common SQL Commands

```sql
-- List all tables
\dt

-- View users (bankers table)
SELECT * FROM bankers;

-- View transactions
SELECT * FROM transaction;

-- View recipients
SELECT * FROM recipient;

-- View OTPs
SELECT * FROM otp;
```

## Troubleshooting

### Port Already in Use

If port 8080 or 5432 is already in use, edit `docker-compose.yml`:

```yaml
# For app (change left side only)
ports:
  - "8081:8080"  # Access via localhost:8081

# For postgres (change left side only)
ports:
  - "5433:5432"  # Use port 5433 on your machine
```

### Database Connection Issues

1. Wait for PostgreSQL to fully start (check logs)
2. Ensure healthy status: `docker-compose ps`
3. If issues persist, recreate: `docker-compose down -v && docker-compose up --build`

### Application Won't Start

1. Check logs: `docker-compose logs app`
2. Verify environment variables in `.env`
3. Ensure Docker has enough resources (minimum 2GB RAM)

### Email/SMS Not Working

- **Email**: Verify Gmail App Password is correct
- **SMS**: Twilio requires a paid account for production use
- For development: You can skip OTP verification by checking logs for the generated OTP codes

## Development Without Docker

If you prefer to run without Docker:

### Prerequisites
- Java 17
- Maven 3.9+
- PostgreSQL 15

### Steps

1. Install and start PostgreSQL:
```bash
# Ubuntu/Debian
sudo apt install postgresql-15

# macOS
brew install postgresql@15
brew services start postgresql@15
```

2. Create database:
```bash
psql -U postgres
CREATE DATABASE carmabanking;
CREATE USER carmauser WITH PASSWORD 'carmapass';
GRANT ALL PRIVILEGES ON DATABASE carmabanking TO carmauser;
\q
```

3. Set environment variables:
```bash
export DATABASE_URL="jdbc:postgresql://localhost:5432/carmabanking?user=carmauser&password=carmapass"
export MAIL_USERNAME="your-email@gmail.com"
export MAIL_PASSWORD="your-app-password"
export TWILIO_ACCOUNT_SID="your-sid"
export TWILIO_AUTH_TOKEN="your-token"
export TWILIO_PHONE_NUMBER="+1234567890"
```

4. Run the application:
```bash
./mvnw spring-boot:run
```

## Next Steps

- See `DEPLOYMENT.md` for production deployment options
- Check the codebase in `src/main/java/arora/moulik/springboot/carma/` for application logic
- JSP views are in `src/main/resources/META-INF/resources/WEB-INF/jsp/`

## Tech Stack

- **Framework**: Spring Boot 3.4.5
- **Language**: Java 17
- **Database**: PostgreSQL 15
- **ORM**: Hibernate/JPA
- **Security**: Spring Security
- **Views**: JSP
- **Build**: Maven
