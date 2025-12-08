# 🚀 StartBerlin Project (DevOps Pipeline)

This project demonstrates a full **End-to-End DevOps Lifecycle** for a Python Flask application.

## 🛠 Tech Stack
- **Code:** Python, Flask
- **Containerization:** Docker
- **CI/CD:** GitHub Actions (Automated Build & Push)
- **IaC:** Terraform (AWS Infrastructure)
- **Orchestration:** Kubernetes (Minikube), Helm Charts, Ingress

## 📂 Project Structure
- `app.py`: The main application logic.
- `Dockerfile`: Container image definition.
- `.github/workflows`: CI/CD pipeline configuration.
- `terraform/`: Infrastructure as Code for AWS.
- `startberlin-chart/`: Helm chart for Kubernetes deployment.

## 🚀 How to Run (Local Kubernetes)
1. Start Minikube: `minikube start`
2. Enable Ingress: `minikube addons enable ingress`
3. Install via Helm: `helm install my-release ./startberlin-chart`
4. Access the site: `minikube service my-release-startberlin-chart`

## 👤 Author
**Ehsan Setaregan** - DevOps Engineer
