General Idea:
build an Gui app tool that will automate the workflow of an employee offboarding.

what have to be:
1. Gui that will show the admin whos terminating the employee a window of "Next , Next ..." - via python flask
2. Docker that will contain all the app so it can run anywhere, on any pc
3. CI/CD that will ensure all the processes
4. git for version managemt 
5. git-hub to push and pull the changes
6. kubernetes to make sure the app is always availbe 


Tech Stack

Python Flask → Provides a simple GUI (“Next → Next → Finish”) for admins to trigger the offboarding workflow.

Bash Script → Executes the actual employee offboarding steps (user data deletion, access revocation, etc.).

Docker → Packages the Flask app + script into a portable container image.

Git + GitHub → Source code version control and collaboration.

GitHub Actions (CI/CD) → Builds, tests, and pushes the Docker image automatically on code changes, then deploys updates to the cluster.

k3s (Lightweight Kubernetes) → Runs the containerized app, ensures availability, and manages scaling and networking.

Helm → Packages and manages Kubernetes manifests, enabling simple upgrades, rollbacks, and configuration management.

Prometheus & Grafana → Monitoring and observability stack: Prometheus collects app and cluster metrics, Grafana visualizes them in dashboards for admins.

Workflow

Admin Accesses GUI → The admin opens the Flask-based web app and enters the employee ID for termination.

Confirmation Wizard → The GUI guides the admin through a short wizard (“Next” → “Confirm” → “Execute”).

Script Execution → On confirmation, Flask securely invokes the offboarding Bash script (supports dry-run for safety).

Audit Logging → The tool records the action (employee ID, timestamp, result) for tracking.

Containerized Deployment → The app runs inside Docker and is deployed on a k3s cluster for portability and resilience.

Helm Deployment → The application is packaged as a Helm chart, making it easy to install, configure, and upgrade inside the k3s cluster.

CI/CD Pipeline → GitHub Actions automatically builds and pushes updated images to the registry and redeploys the Helm release on code changes.

Monitoring & Observability →

Prometheus scrapes metrics from the application and cluster.

Grafana provides dashboards for admins to track system health, offboarding execution results, and failures.


offboard-gui/
├─ app/
│  ├─ main.py             # Flask app (wizard + script runner)
│  ├─ requirements.txt
│  ├─ templates/
│  │   └─ wizard.html
│  ├─ static/
│  └─ scripts/
│      └─ offboard.sh
│
├─ charts/                # Helm chart for deployment
│  └─ offboard-gui/
│      ├─ Chart.yaml
│      ├─ values.yaml
│      ├─ templates/
│      │   ├─ deployment.yaml
│      │   ├─ service.yaml
│      │   ├─ ingress.yaml
│      │   ├─ configmap.yaml
│      │   └─ _helpers.tpl
│
├─ k3s/                   # k3s setup & cluster configs
│  ├─ install.sh          # script to install k3s locally or on VM
│  ├─ README.md           # how to set up k3s cluster
│  ├─ kubeconfig          # (example, not real one; in practice provided by k3s)
│  └─ metallb-values.yaml # optional if you add LoadBalancer (via Helm)
│
├─ monitoring/
│  ├─ prometheus-values.yaml
│  ├─ grafana-values.yaml
│  └─ dashboards/
│      └─ offboarding.json
│
├─ .github/
│  └─ workflows/
│      └─ ci-cd.yml
│
├─ Dockerfile
├─ docker-compose.yml
├─ project.md
├─ README.md
└─ LICENSE
