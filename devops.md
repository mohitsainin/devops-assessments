## DevOps Project: Full-stack Hello World Application
<img width="1114" height="747" alt="image" src="https://github.com/user-attachments/assets/8cefb72b-f3a7-4d99-b01f-e70890b449e9" />


---

### Version History

| **Date** | **Version** | **Description** | **Reading Time** | **Author** |
|---------|-------------|-----------------|------------------|------------|
| **JAN '26'** | v1.0 | Initial DevOps Setup & Documentation | ~8–10 minutes | Mohit Saini |


## Table of Content
- [Introduction](#introduction)
- [Architecture Overview](#architecture-overview)
- [Directory Structure](#directory-structure)
- [Setup Guide (Self-Hosted)](#setup-guide-self-hosted)
- [CI/CD Automation](#cicd-automation)
- [Troubleshooting Log](#troubleshooting-log)
- [Conclusion](#conclusion)
- [References](#references)


## Introduction

This project demonstrates a **Docker-based DevOps implementation** for a full-stack application consisting of a **Frontend** and **Backend** service.

The goal of this setup is to:
- Follow containerization best practices
- Enable smooth local and server deployments
- Ensure secure, repeatable, and automated builds

The application is orchestrated using **Docker Compose**, allowing multiple services to communicate over an internal Docker network.

## Architecture Overview

The application follows a **Docker Compose based architecture**:

- Frontend runs inside an **Nginx container**
- Backend runs inside a **Python (Django) container**
- Both services communicate using **Docker internal DNS**
- Users access the application via exposed ports


<img width="705" height="472" alt="image" src="https://github.com/user-attachments/assets/a36ae2a1-02f6-4f25-8474-e10c7b1ed0b7" />

Frontend → Backend communication 

## Directory Structure

#### For Dockerized Application


```
devops-assessments-/
├── backend/
│ ├── Dockerfile
│ ├── .dockerignore
│ ├── manage.py
│ ├── requirements.txt
│ ├── config/
│ └── core/
├── frontend/
│ ├── Dockerfile
│ ├── .dockerignore
│ ├── package.json
│ ├── src/
│ └── public/
├── docker-compose.yml
├── .env
├── DEVOPS.md
└── README.md
```

## Setup Guide (Self-Hosted)

### Prerequisites (Windows 11 – 64 Bit)

Install the following:
- **Docker Desktop for Windows**
- **Git**
- **WSL 2** (required by Docker Desktop)

Verify installation:
```powershell
docker --version
docker compose version
git --version
```

## Clone the Repository
```
git clone <repository-url>
cd devops-assessments-
```

## Build and Run Containers
```
docker-compose up --build
```
Docker Compose will:
Build frontend and backend images
Create an internal Docker network
Start containers in correct dependency order

## Access the Application
Frontend: http://localhost:3000
Backend API: http://localhost:8000

<img width="1889" height="965" alt="Screenshot 2026-01-23 164840" src="https://github.com/user-attachments/assets/6777a77a-6ffd-494c-906e-3567c23e3e0f" />

## CI/CD Automation

This project includes an automated **CI/CD pipeline** configured using **GitHub Actions** to ensure consistent builds and reliable container images.

<img width="1881" height="731" alt="Screenshot 2026-01-24 221943" src="https://github.com/user-attachments/assets/2c452ef3-261c-4b83-a42e-2109e894eb3a" />

### Pipeline Overview

The pipeline is triggered automatically on every push to the repository and performs the following steps:

1. **Set up Job**
   - Initializes the GitHub Actions runner.

2. **Checkout Code**
   - Fetches the latest source code from the repository.

3. **Prepare Docker Username**
   - Prepares Docker Hub credentials using GitHub Secrets.

4. **Build and Push Backend Image**
   - Builds the backend Docker image.
   - Pushes the image to Docker Hub.

5. **Build and Push Frontend Image**
   - Builds the frontend Docker image.
   - Pushes the image to Docker Hub.

6. **Email Notification on Success**
   - Sends an email notification when the pipeline completes successfully.
  
     <img width="752" height="477" alt="image" src="https://github.com/user-attachments/assets/d08d3528-41c9-43fe-82ba-c67dd3b733e2" />


7. **Email Notification on Failure**
   - Sends an alert email if any pipeline step fails.

8. **Post Checkout & Cleanup**
   - Performs post-build cleanup tasks.
   - Completes the job execution.


### Issue: Backend Container Failed to Access Database File

**Problem:**  
The Django backend container started successfully, but database operations failed or the database file was not being created/read correctly inside the container.

This resulted in unexpected runtime behavior during API requests.

**Initial Configuration (Before Troubleshooting):**

In `backend/config/settings.py`, the database was configured as:

```python
DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.sqlite3',
        'NAME': BASE_DIR / 'db.sqlite3',
    }
}
```
Additionally:

ALLOWED_HOSTS was empty

Database path was dependent on host filesystem resolution

```
ALLOWED_HOSTS = ["*"]
```

## Conclusion

This project successfully demonstrates a **self-hosted DevOps implementation** for a full-stack application using Docker and Docker Compose on a Windows 11 (64-bit) environment. The frontend and backend services are fully containerized following industry best practices such as service isolation, internal Docker networking, and environment-based configuration.

The setup ensures **consistency, portability, and repeatability** across environments, allowing the application to be easily deployed on any system with Docker support. The use of a CI/CD pipeline with GitHub Actions further enhances reliability by automating Docker image builds, pushing images to Docker Hub, and providing real-time email notifications on success or failure.

## References

| **S.No** | **Title** | **Link** | **Purpose** |
|--------|-----------|----------|-------------|
| 1 | Docker Networking Explained (Official Docs) | https://docs.docker.com/network/ | Used to understand Docker internal networking, service name resolution, and why `localhost` does not work inside containers. |
| 2 | Dockerizing Django – Database & File Path Handling | https://testdriven.io/blog/dockerizing-django-with-postgres-gunicorn-and-nginx/ | Helped in understanding Django database configuration, container filesystem paths, and resolving database access issues inside Docker. |


