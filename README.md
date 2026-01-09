# 🚀 Fintech AWS Platform — Terraform, CI/CD & Full-Stack Application

A **production-grade Fintech web application** deployed on **AWS** using **Terraform** and a fully automated **CI/CD pipeline**.  
This project demonstrates real-world cloud architecture, infrastructure-as-code, security best practices, and end-to-end application delivery suitable for professional portfolios and interviews.

---

## 🎯 Project Objective

Design and implement a **highly available, secure, and scalable Fintech platform** on AWS using modern DevOps practices.  
The solution mirrors real production systems used by fintech and SaaS companies.

---

## 🏗️ Architecture Overview


### Architecture Principles
- Multi-AZ for high availability
- Private subnets for application and database layers
- Secure internet access through ALB and NAT Gateways
- End-to-end HTTPS with ACM certificates
- Fully automated CI/CD pipeline

---

## 🧱 Technology Stack

### AWS & Infrastructure
- Amazon VPC (Public & Private Subnets)
- Internet Gateway & NAT Gateways
- Application Load Balancer (ALB)
- Amazon ECS Fargate
- Amazon RDS (PostgreSQL, Multi-AZ)
- Amazon CloudFront
- Amazon Route 53
- AWS Certificate Manager (ACM)
- AWS Secrets Manager

### DevOps
- Terraform (modular Infrastructure as Code)
- Amazon ECR
- AWS CodePipeline
- AWS CodeBuild
- GitHub

### Application
- **Frontend:** React
- **Backend:** Node.js + Express
- **Database:** PostgreSQL

---

## 🔐 Security Design

- ECS tasks and RDS run in **private subnets**
- ALB is the only public entry point
- TLS enforced using ACM certificates
- IAM roles follow **least-privilege** access
- Database credentials stored in **AWS Secrets Manager**
- Encrypted RDS storage and automated backups

---

## 📂 Repository Structure


---

## 🔄 CI/CD Pipeline


Every push to the `main` branch triggers an automated build and deployment.

---

## 🚀 Deployment Steps

### 1️⃣ Prerequisites
- AWS account
- AWS CLI configured
- Terraform ≥ 1.5
- Registered domain in Route 53
- GitHub repository

---

### 2️⃣ Create Remote Terraform State

```bash
aws s3api create-bucket \
  --bucket tfstate-example-bucket \
  --region us-east-1

aws dynamodb create-table \
  --table-name tfstate-locks \
  --attribute-definitions AttributeName=LockID,AttributeType=S \
  --key-schema AttributeName=LockID,KeyType=HASH \
  --billing-mode PAY_PER_REQUEST
