# Employee Offboarding Automation Tool

## Tech Stack
- **Python Flask** → Web framework providing a polished GUI for admins to offboard employees by username.  
- **Bash Script** → Executes employee offboarding tasks (data deletion, access revocation, cleanup).  
- **Gunicorn** → Production-ready server to run Flask efficiently.  
- **Nginx / Traefik** → Reverse proxy to forward requests, handle HTTPS, and serve static files.  
- **Docker** → Containerizes the app for portability and consistency.  
- **k3s (Lightweight Kubernetes)** → Runs the containerized app for availability and scaling.  
- **Helm** → Packages Kubernetes manifests for easy deployment and upgrades.  
- **Git + GitHub** → Source code version control.  
- **GitHub Actions (CI/CD)** → Automates testing, Docker build, and deployment to k3s.  
- **Prometheus & Grafana** → Monitoring and dashboards for app and cluster metrics.  
- **Bootstrap + Custom CSS/JS** → Modern, responsive UI with form validation and confirmation wizard.

## Workflow

1. **Admin Accesses Web App**  
   - Admin opens the browser and navigates to the offboarding app via Nginx / Traefik ingress.

2. **Multi-step GUI Wizard**  
   - Admin enters the employee **username**.  
   - Wizard guides through steps: *Next → Confirm → Execute*.  
   - JS confirmation prevents accidental offboarding.

3. **Script Execution**  
   - Flask calls the **Bash offboarding script** to remove data and revoke access.

4. **Audit Logging**  
   - Records actions (username, timestamp, result) for tracking and compliance.

5. **Containerized Deployment**  
   - Flask + Gunicorn app runs in a **Docker container** for portability.

6. **Kubernetes Orchestration (k3s)**  
   - Helm deploys the container into **k3s cluster**.  
   - Deployment ensures availability and scaling.  
   - Ingress routes external requests to the app.

7. **CI/CD Automation**  
   - GitHub Actions automatically tests code, builds Docker image, pushes to registry, and deploys Helm release to k3s.

8. **Monitoring & Observability**  
   - Prometheus scrapes metrics from Flask/Gunicorn and the k3s cluster.  
   - Grafana dashboards visualize uptime, request counts, and offboarding results.

## Workflow Diagram

```mermaid
flowchart TD
    A[Admin Browser] -->|Open web app| B[Nginx / Traefik Ingress]
    B --> C[Gunicorn WSGI Server]
    C --> D[Flask App]
    D --> E[Bash Offboarding Script]
    D --> F[Audit Logging]
    C --> G[Prometheus Metrics Exporter]
    G --> H[Prometheus Server]
    H --> I[Grafana Dashboard]

    subgraph "CI/CD Pipeline"
        J[GitHub Repository] --> K[GitHub Actions]
        K --> L[Build Docker Image]
        L --> M[Push to Docker Registry]
        M --> N[Helm Deployment to k3s]
    end

    N --> C



