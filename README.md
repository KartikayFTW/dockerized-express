# Dockerized Express App with TypeScript, PostgreSQL, and Prisma

This project is a dockerized Express application using TypeScript, PostgreSQL, and Prisma ORM. It includes signup and signin routes.

## Project Structure

The project has been developed incrementally with the following feature branches:

1. `feat/add-docker-support`: Initial app setup with Dockerfile
2. `feat/postgres`: Added Prisma, signup, and signin routes
3. `feat/docker-compose`: Added Docker Compose for easier multi-container management

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

## Start the Application Using Docker Compose
Run the following command to start the application and its dependencies:

```docker-compose up -d```


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
  
     
Why use Docker Compose?
1. **Simplified Multi-Container Management**:

Docker Compose simplifies the process of running and managing multiple containers.
It manages network creation automatically and links containers together with ease.

2. **Ease of Configuration**:

Allows for easy configuration of environment variables and volume mounts.
Provides a single YAML file to define and manage your multi-container application setup.

3. **Improved Maintainability and Version Control**:

Easier to maintain and version control your application setup.
Allows for defining all container configurations in one place.

4. **Dependency Management**:

Ensures that the dependent containers are started in the correct order.
Handles restarting of containers if one fails, ensuring the application remains available.
With Docker Compose, you can manage and run your multi-container application with a single command, making development and deployment more efficient and streamlined.



