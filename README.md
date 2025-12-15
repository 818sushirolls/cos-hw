# eShopOnContainers - Docker Compose & Swarm Deployment

## Author
DockerHub Username: ew8nought

## Prerequisites
- Docker Desktop installed and running
- All images pushed to DockerHub (ew8nought/*)

## Services Overview

### Core Services
| Service | Image | Port |
|---------|-------|------|
| Catalog API | ew8nought/catalog-api | 5101 |
| Basket API | ew8nought/basket-api | 5103 |
| Ordering API | ew8nought/ordering-api | 5102 |
| Identity API | ew8nought/identity-api | 5105 |
| Payment API | ew8nought/payment-api | 5108 |

### Frontend Services
| Service | Image | Port |
|---------|-------|------|
| Web MVC | ew8nought/webmvc | 5100 |
| Web SPA | ew8nought/webspa | 5104 |
| Web Status | ew8nought/webstatus | 5107 |
| Webhook Client | ew8nought/webhookclient | 5114 |

### Gateway & Additional Services
| Service | Image | Port |
|---------|-------|------|
| Mobile Shopping Aggregator | ew8nought/mobileshoppingagg | 5120 |
| Web Shopping Aggregator | ew8nought/webshoppingagg | 5121 |
| Ordering SignalR Hub | ew8nought/ordering-signalrhub | 5112 |
| Webhooks API | ew8nought/webhooks-api | 5113 |
| Ordering Background Tasks | ew8nought/ordering-backgroundtasks | 5111 |

### Infrastructure (Pre-built Images)
| Service | Image | Port |
|---------|-------|------|
| SQL Server | mcr.microsoft.com/mssql/server:2019-latest | 5433 |
| MongoDB | mongo | 27017 |
| Redis | redis:alpine | 6379 |
| RabbitMQ | rabbitmq:3-management-alpine | 5672, 15672 |
| Seq (Logging) | datalust/seq:latest | 5340 |
| Envoy Gateway | envoyproxy/envoy:v1.11.1 | 5200, 5202 |

---

## Part 1: Running with Docker Compose

### Step 1: Navigate to the src directory
```bash
cd Container_Operating_Systems/Code/Homework/src
```

### Step 2: Start all services
```bash
docker compose up -d
```

### Step 3: Check status
```bash
docker compose ps
```

### Step 4: Access the applications
- **Web Status:** http://localhost:5107/
- **Web MVC:** http://localhost:5100/
- **Web SPA:** http://localhost:5104/

### Step 5: Stop all services
```bash
docker compose down
```

---

## Part 2: Running with Docker Swarm

### Step 1: Initialize Docker Swarm
```bash
docker swarm init
```

### Step 2: Generate the rendered stack file
```bash
docker compose --env-file .env -f docker-compose.yml -f docker-compose.override.yml config > stack.rendered.yml
```

### Step 3: Verify the stack file
```bash
docker stack config -c stack.rendered.yml
```

### Step 4: Deploy the stack
```bash
docker stack deploy -c stack.rendered.yml mystack
```

### Step 5: Check status
```bash
docker stack services mystack
```

### Step 6: Access the applications
- **Web Status:** http://localhost:5107/
- **Web MVC:** http://localhost:5100/
- **Web SPA:** http://localhost:5104/

### Step 7: Tear down
```bash
docker stack rm mystack
```

### Step 8: Leave Swarm (optional)
```bash
docker swarm leave --force
```

---

## Troubleshooting

| Issue | Solution |
|-------|----------|
| Port already in use | `docker stop $(docker ps -q)` |
| SQL Server won't start | Ensure 2GB+ RAM for Docker |
| Services show unhealthy | Wait 2-3 minutes for initialization |
| Cannot access web pages | Verify services are running with `docker compose ps` |

---

## Files Included
- `docker-compose.yml` - Main compose file with service definitions
- `docker-compose.override.yml` - Environment variables and port mappings
- `.env` - Environment configuration
- `stack.rendered.yml` - Generated file for Swarm deployment
- `README.md` - This documentation

