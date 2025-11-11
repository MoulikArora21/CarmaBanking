# Carma Banking - Deployment Guide

This guide covers deployment options for the Carma Banking application based on your existing infrastructure.

## Your Current Infrastructure

- **Digital Ocean Droplet**: 2GB RAM, 50GB storage with domain `moulikarora.me` (running thesis chatbot)
- **Vercel**: Frontend for chatbot with domain `moulikarora.tech`
- **Heroku**: Free $13/month credit via GitHub Student Pack

## Deployment Options Analysis

### Option 1: Heroku (RECOMMENDED for Simplicity)

**Pros:**
- ✅ Free $13/month credit covers basic dyno
- ✅ Easiest setup with built-in PostgreSQL
- ✅ No interference with your existing Digital Ocean chatbot
- ✅ Built-in SSL, domain management, and auto-scaling
- ✅ You already have a `Procfile` configured

**Cons:**
- ⚠️ Dynos sleep after 30 min of inactivity (can upgrade to prevent)
- ⚠️ Limited to 10,000 rows on free PostgreSQL tier

**Cost**: $0-5/month (within your $13 credit)

**Use Case**: Best for development/testing or low-traffic production

---

### Option 2: Digital Ocean - Separate Droplet (RECOMMENDED for Production)

**Pros:**
- ✅ Full control over environment
- ✅ No sleep/downtime issues
- ✅ Can use subdomain: `banking.moulikarora.me` or `carma.moulikarora.me`
- ✅ Isolated from thesis chatbot

**Cons:**
- ⚠️ Additional cost: $6-12/month for 1-2GB droplet
- ⚠️ Requires manual setup and maintenance

**Cost**: $6/month (1GB RAM) or $12/month (2GB RAM)

**Use Case**: Best for production deployment with reliability

---

### Option 3: Digital Ocean - Same Droplet (NOT RECOMMENDED)

**Pros:**
- ✅ No additional cost
- ✅ Can use subdomain on existing domain

**Cons:**
- ❌ Only 2GB RAM total (shared with chatbot)
- ❌ Risk of resource conflicts and crashes
- ❌ Banking app needs ~512MB-1GB RAM + PostgreSQL needs ~256-512MB
- ❌ Could disrupt your thesis chatbot

**Cost**: $0 additional

**Use Case**: Only if chatbot uses <500MB RAM and you monitor closely

---

### Option 4: Vercel (NOT SUPPORTED)

**Cons:**
- ❌ Vercel doesn't support Spring Boot/Java applications
- ❌ Serverless functions only (Node.js, Python, Go, Ruby)

---

## Recommended Deployment Strategy

### 🏆 Best Choice: **Heroku for Now, Digital Ocean for Later**

**Phase 1: Quick Start (This Week)**
- Deploy to **Heroku** for immediate access
- Use your $13/month credit
- Test and develop features
- Share with users for feedback

**Phase 2: Production Ready (Later)**
- Move to **separate Digital Ocean droplet**
- Set up at `banking.moulikarora.me`
- Keep Heroku as staging environment

---

## Deployment Instructions

## 1. Heroku Deployment (Easiest - 10 minutes)

### Prerequisites
- Heroku account with GitHub Student Pack activated
- Heroku CLI installed

### Steps

#### A. Install Heroku CLI

```bash
# Ubuntu/Debian
curl https://cli-assets.heroku.com/install.sh | sh

# macOS
brew tap heroku/brew && brew install heroku
```

#### B. Login to Heroku

```bash
heroku login
```

#### C. Create Heroku App

```bash
cd /home/user/CarmaBanking

# Create app (choose a unique name)
heroku create carma-banking-moulik

# Or let Heroku generate a name
heroku create
```

#### D. Add PostgreSQL Database

```bash
# Free tier (10,000 rows limit)
heroku addons:create heroku-postgresql:mini

# Check database URL was added
heroku config
```

#### E. Set Environment Variables

```bash
heroku config:set MAIL_USERNAME="your-email@gmail.com"
heroku config:set MAIL_PASSWORD="your-gmail-app-password"
heroku config:set TWILIO_ACCOUNT_SID="your-sid"
heroku config:set TWILIO_AUTH_TOKEN="your-token"
heroku config:set TWILIO_PHONE_NUMBER="+1234567890"
```

#### F. Fix Procfile (Current one has wrong jar name)

Update the `Procfile`:

```bash
web: java -jar target/carmabanking-0.0.1-SNAPSHOT.jar
```

#### G. Deploy

```bash
git add .
git commit -m "Fix Procfile for deployment"
git push heroku claude/carma-baking-docker-setup-011CV2u7z4sVdBuxX97MNRHh:main
```

#### H. Open Your App

```bash
heroku open
```

Your app will be at: `https://carma-banking-moulik.herokuapp.com`

### Custom Domain on Heroku (Optional)

If you want to use a subdomain from your Digital Ocean domain:

```bash
# Add domain to Heroku
heroku domains:add banking.moulikarora.me

# Get DNS target from Heroku
heroku domains

# Add CNAME record in Digital Ocean DNS:
# Type: CNAME
# Name: banking
# Value: <dns-target-from-heroku>
```

---

## 2. Digital Ocean Deployment - Separate Droplet (Production)

### Prerequisites
- New Digital Ocean droplet (Ubuntu 22.04)
- Domain access (moulikarora.me)

### Steps

#### A. Create New Droplet

1. Go to Digital Ocean Dashboard
2. Create Droplet:
   - **Image**: Ubuntu 22.04 LTS
   - **Plan**: Basic $6/month (1GB RAM) or $12/month (2GB RAM)
   - **Region**: Closest to your users
   - **Add SSH key** for secure access

#### B. Initial Server Setup

```bash
# SSH into droplet
ssh root@your-droplet-ip

# Update system
apt update && apt upgrade -y

# Install Docker
curl -fsSL https://get.docker.com -o get-docker.sh
sh get-docker.sh

# Install Docker Compose
apt install docker-compose -y

# Create deployment user
adduser carma
usermod -aG docker carma
su - carma
```

#### C. Clone and Configure

```bash
# Clone repository
git clone https://github.com/MoulikArora21/CarmaBanking.git
cd CarmaBanking

# Create production .env file
nano .env

# Add your environment variables:
MAIL_USERNAME=your-email@gmail.com
MAIL_PASSWORD=your-app-password
TWILIO_ACCOUNT_SID=your-sid
TWILIO_AUTH_TOKEN=your-token
TWILIO_PHONE_NUMBER=+1234567890
```

#### D. Create Production Docker Compose

Create `docker-compose.prod.yml`:

```yaml
version: '3.8'

services:
  postgres:
    image: postgres:15-alpine
    container_name: carma-banking-db
    restart: always
    environment:
      POSTGRES_DB: carmabanking
      POSTGRES_USER: carmauser
      POSTGRES_PASSWORD: ${DB_PASSWORD}
    volumes:
      - postgres_data:/var/lib/postgresql/data
    networks:
      - carma-network

  app:
    build:
      context: .
      dockerfile: Dockerfile
    container_name: carma-banking-app
    restart: always
    environment:
      DATABASE_URL: jdbc:postgresql://postgres:5432/carmabanking?user=carmauser&password=${DB_PASSWORD}
      MAIL_USERNAME: ${MAIL_USERNAME}
      MAIL_PASSWORD: ${MAIL_PASSWORD}
      TWILIO_ACCOUNT_SID: ${TWILIO_ACCOUNT_SID}
      TWILIO_AUTH_TOKEN: ${TWILIO_AUTH_TOKEN}
      TWILIO_PHONE_NUMBER: ${TWILIO_PHONE_NUMBER}
    depends_on:
      - postgres
    networks:
      - carma-network

  nginx:
    image: nginx:alpine
    container_name: carma-banking-nginx
    restart: always
    ports:
      - "80:80"
      - "443:443"
    volumes:
      - ./nginx.conf:/etc/nginx/nginx.conf
      - ./ssl:/etc/nginx/ssl
    depends_on:
      - app
    networks:
      - carma-network

volumes:
  postgres_data:

networks:
  carma-network:
    driver: bridge
```

#### E. Create Nginx Configuration

Create `nginx.conf`:

```nginx
events {
    worker_connections 1024;
}

http {
    upstream backend {
        server app:8080;
    }

    server {
        listen 80;
        server_name banking.moulikarora.me;

        location / {
            proxy_pass http://backend;
            proxy_set_header Host $host;
            proxy_set_header X-Real-IP $remote_addr;
            proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
            proxy_set_header X-Forwarded-Proto $scheme;
        }
    }
}
```

#### F. Set Up SSL with Let's Encrypt

```bash
# Install certbot
sudo apt install certbot python3-certbot-nginx -y

# Get SSL certificate
sudo certbot --nginx -d banking.moulikarora.me
```

#### G. Configure DNS

In your Digital Ocean account:

1. Go to Networking → Domains
2. Select `moulikarora.me`
3. Add A Record:
   - **Type**: A
   - **Hostname**: banking
   - **Value**: Your new droplet's IP
   - **TTL**: 3600

#### H. Deploy

```bash
docker-compose -f docker-compose.prod.yml up -d --build
```

#### I. Set Up Auto-restart on System Reboot

```bash
# Create systemd service
sudo nano /etc/systemd/system/carma-banking.service
```

Add:

```ini
[Unit]
Description=Carma Banking Application
Requires=docker.service
After=docker.service

[Service]
Type=oneshot
RemainAfterExit=yes
WorkingDirectory=/home/carma/CarmaBanking
ExecStart=/usr/bin/docker-compose -f docker-compose.prod.yml up -d
ExecStop=/usr/bin/docker-compose -f docker-compose.prod.yml down
User=carma

[Install]
WantedBy=multi-user.target
```

Enable service:

```bash
sudo systemctl enable carma-banking
sudo systemctl start carma-banking
```

---

## 3. Digital Ocean - Same Droplet (Budget Option)

⚠️ **Only use if your chatbot uses less than 500MB RAM**

### Check Current Resource Usage

```bash
ssh root@your-existing-droplet-ip
free -h  # Check RAM usage
df -h    # Check disk usage
docker stats  # Check container usage
```

### If You Proceed (Not Recommended)

```bash
# Clone to separate directory
cd /opt
git clone https://github.com/MoulikArora21/CarmaBanking.git carma-banking
cd carma-banking

# Edit docker-compose.yml to use different ports
# Change 8080 → 8081 for app
# Change 5432 → 5433 for postgres

# Deploy
docker-compose up -d --build

# Configure Nginx to route subdomain
nano /etc/nginx/sites-available/banking

# Add configuration for banking.moulikarora.me → localhost:8081
```

---

## Comparison Table

| Feature | Heroku | DO Separate | DO Same | Vercel |
|---------|--------|-------------|---------|--------|
| **Cost/Month** | $0-5 | $6-12 | $0 | N/A |
| **Setup Time** | 10 min | 1-2 hours | 30 min | N/A |
| **RAM Available** | 512MB | 1-2GB | ~500MB | N/A |
| **Chatbot Impact** | None | None | High Risk | N/A |
| **Maintenance** | Low | Medium | High | N/A |
| **Reliability** | Good | Excellent | Poor | N/A |
| **SSL/HTTPS** | Auto | Manual | Manual | N/A |
| **Recommended** | ✅ Start | ✅ Production | ❌ | ❌ |

---

## Subdomain Options

For your domains, you can use:

- `banking.moulikarora.me` (professional)
- `carma.moulikarora.me` (branded)
- `bank.moulikarora.me` (short)

Keep your existing:
- `moulikarora.me` → Digital Ocean chatbot backend
- `moulikarora.tech` → Vercel chatbot frontend

---

## Monitoring and Maintenance

### Heroku

```bash
# View logs
heroku logs --tail

# Check status
heroku ps

# Restart app
heroku restart
```

### Digital Ocean

```bash
# View logs
docker-compose logs -f

# Check status
docker-compose ps

# Restart
docker-compose restart

# Update app
git pull
docker-compose up -d --build
```

---

## Cost Summary

### Recommended Approach

**Month 1-3: Development & Testing**
- Heroku: $0 (using free credits)
- **Total: $0/month**

**Month 4+: Production**
- Heroku (staging): $5/month (eco dyno)
- Digital Ocean: $6/month (new droplet)
- **Total: $11/month** (within your $13 Heroku credit if you want)

**Your Existing Costs Remain:**
- Digital Ocean (chatbot): $10/month (assuming current cost)
- Vercel: $0 (free tier)

---

## Final Recommendation

1. **Start with Heroku** (this week)
   - Quick, easy, no risk to chatbot
   - Perfect for development and initial testing
   - Use your free $13 credit

2. **Move to Digital Ocean separate droplet** (when ready for production)
   - Set up at `banking.moulikarora.me`
   - Better performance and control
   - $6-12/month for dedicated resources

3. **Keep away from same droplet**
   - 2GB RAM isn't enough for both apps
   - High risk of disrupting your thesis work

---

## Need Help?

- **Heroku Issues**: Check https://devcenter.heroku.com/
- **Digital Ocean Issues**: Check https://docs.digitalocean.com/
- **Application Issues**: Check application logs with `docker-compose logs -f`
