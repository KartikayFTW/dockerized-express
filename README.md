# Dockerized Express App with TypeScript, PostgreSQL, and Prisma

This project is a dockerized Express application using TypeScript, PostgreSQL, and Prisma ORM. It includes signup and signin routes.

## Project Structure

The project has been developed incrementally with the following feature branches:

1. `feat/add-docker-support`: Initial app setup with Dockerfile
2. `feat/postgres`: Added Prisma, signup, and signin routes

All features are merged into the main branch.

## Prerequisites

- Docker

## Setup

### 1. Create a Docker network

Create a custom network to allow containers to communicate:

```bash
docker network create my-app-network
```

This network allows your Express app container and PostgreSQL container to communicate with each other.

### 2. Create a Docker volume

Create a volume to persist PostgreSQL data:

```bash
docker volume create postgres-data
```

Volumes are used to persist data even when containers are stopped or removed.

### 3. Start PostgreSQL container

```bash
docker run -d \
  --name postgres-db \
  -e POSTGRES_USER=your_username \
  -e POSTGRES_PASSWORD=your_password \
  -e POSTGRES_DB=your_database \
  -v postgres-data:/var/lib/postgresql/data \
  --network my-app-network \
  postgres:latest
```

### 4. Build the Express app

```bash
docker build -t express-app .
```

### 5. Run the Express app

```bash
docker run -d \
  --name express-app \
  -p 3000:3000 \
  -e DATABASE_URL="postgresql://your_username:your_password@postgres-db:5432/your_database?schema=public" \
  --network my-app-network \
  express-app
```

## API Routes

- POST `/signup`: Create a new user
- POST `/signin`: Authenticate a user

## Why use Docker network and volumes?

1. **Docker Network**: 
   - Allows containers to communicate with each other securely.
   - Provides isolation from other containers and the host system.
   - Enables the use of container names as hostnames for easy communication.

2. **Docker Volumes**:
   - Persist data beyond the lifecycle of containers.
   - Prevent data loss when containers are stopped or removed.
   - Easily backup and restore data.

## Future Improvements

In the future, we plan to use Docker Compose to simplify the process of running multiple containers and managing their configurations.
