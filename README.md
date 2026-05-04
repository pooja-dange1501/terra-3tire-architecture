# 📦 3-Tier Web Application Deployment using AWS & Terraform

---

## 🎯 Objective
This project demonstrates the deployment of a **secure and scalable 3-tier architecture on AWS using Terraform**.

The system allows users to submit registration data through a web interface, which is processed by an application server and stored in a database.

---

## 🏗️ Architecture Overview
👤 User (Browser)
↓
🌐 Web Tier (EC2 - Public Subnet)
↓
⚙️ Application Tier (EC2 - Private Subnet)
↓
🗄️ Database Tier (RDS - Private Subnet)

---

## 🛠️ Tech Stack

| Layer | Technology |
|------|------------|
| ☁️ Cloud | AWS (EC2, RDS, VPC, Subnets, Security Groups) |
| 🏗️ IaC | Terraform |
| 🌐 Web Server | Nginx |
| ⚙️ Backend | PHP |
| 🗄️ Database | MySQL / PostgreSQL |
| 🐧 OS | Ubuntu Linux |

---

## 🌐 Web Tier (Public Subnet)

• 🖥️ Hosted on EC2 instance  
• 🌍 Configured with Nginx and PHP  

### 🔧 Function:
• 📄 Displays registration form (index.php)  
• ✍️ Accepts user input  
• 🔄 Forwards data to Application Tier  

---

## ⚙️ Application Tier (Private Subnet)

• 🔒 EC2 instance without public access  

### 🔧 Function:
• ⚡ Executes submit.php  
• 📥 Processes form data  
• 🔗 Connects securely to database  
• 💾 Inserts records into RDS  

---

## 🗄️ Database Tier (Private Subnet)

• 🛢️ Amazon RDS (MySQL/PostgreSQL)  

### 🔧 Function:
• 📊 Stores user registration data  
• 🔐 Ensures data persistence and reliability  

---

## 🔐 Security Configuration

• 🌐 Web Tier → Accessible from internet (Port 80)  
• 🔒 App Tier → Accessible only from Web Tier  
• 🛢️ DB Tier → Accessible only from App Tier (Port 3306)  

---

## ⚙️ Terraform Implementation

### 🔧 Resources Provisioned:
• 🌐 VPC with public & private subnets  
• 🖥️ EC2 instances (Web + App Tier)  
• 🛢️ RDS instance  
• 🔐 Security Groups  
• 🌍 Route Tables  

---

## 🔄 Application Workflow

1️⃣ 👤 User opens web application  
2️⃣ 📄 Registration form displayed  
3️⃣ ✍️ User submits details  
4️⃣ 🔄 Request sent to application server  
5️⃣ ⚙️ App processes data  
6️⃣ 💾 Data stored in RDS database  

---

## 🔑 Accessing Servers

### Step 1: Set key permission
```bash
chmod 400 key.pem
### Step 2: Connect to EC2
ssh -i key.pem ubuntu@<EC2-PUBLIC-IP>

## 🗄️ Database Verification

### Step 1: Connect to RDS
mysql -h <RDS-ENDPOINT> -u admin -p

### Step 2: Run query
USE database_name;
SELECT * FROM users;

📸 Screenshots

• EC2 Instances
• Web Page UI
• Form Submission Success
• RDS Table Data
• Terraform Apply Output

🔍 Observations

• ✅ 3-tier architecture deployed successfully
• 🔐 Secure communication between tiers
• 🔄 End-to-end data flow working
• 🛡️ Private subnet improves security

🎯 Conclusion

This project demonstrates a real-world 3-tier architecture using AWS and Terraform.

It ensures:
• 🔒 Secure system design
• 🧩 Proper separation of layers
• 📈 Scalable infrastructure
• ⚙️ Infrastructure as Code automation

👩‍💻 Author

Pooja Dange
Cloud & DevOps Learner

📧 Email: poojadange1501@gmail.com

🔗 LinkedIn: https://www.linkedin.com/in/pooja-dange-0270072b3

💻 GitHub: https://github.com/pooja-dange1501/terra-3tire-architecture
