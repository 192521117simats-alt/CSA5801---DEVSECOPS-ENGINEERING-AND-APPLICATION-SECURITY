############################################################
# STEP 1 : SYNTHETIC DATA GENERATION USING GMM
# DEVSECOPS SIMULATION
############################################################

# Clear workspace
rm(list = ls())

# Random seed for reproducibility
set.seed(123)

############################################################
# Number of Records
############################################################

n <- 1000

############################################################
# Threat Categories (4)
############################################################

Threat <- sample(
  
  c(
    "Malware",
    "Phishing",
    "Insider Threat",
    "DDoS"
  ),
  
  n,
  
  replace = TRUE,
  
  prob = c(0.30,0.25,0.20,0.25)
  
)

############################################################
# Vulnerabilities (10)
############################################################

Vulnerability <- sample(
  
  c(
    
    "Weak Password",
    
    "Missing Security Patch",
    
    "SQL Injection",
    
    "Cross Site Scripting",
    
    "Open Port",
    
    "System Misconfiguration",
    
    "Outdated Software",
    
    "Weak Encryption",
    
    "Privilege Escalation",
    
    "Insecure API"
    
  ),
  
  n,
  
  replace = TRUE
  
)

############################################################
# Attack Types (3)
############################################################

Attack_Type <- sample(
  
  c(
    
    "Network Attack",
    
    "Web Attack",
    
    "Social Engineering"
    
  ),
  
  n,
  
  replace = TRUE,
  
  prob = c(0.40,0.35,0.25)
  
)

############################################################
# Gaussian Mixture Model Groups
############################################################

gmm_group <- sample(
  
  c(
    
    "Low",
    
    "Medium",
    
    "High"
    
  ),
  
  n,
  
  replace = TRUE,
  
  prob = c(0.30,0.45,0.25)
  
)

############################################################
# Empty Variables
############################################################

CVSS_Score <- numeric(n)

Detection_Time <- numeric(n)

Response_Time <- numeric(n)

############################################################
# Generate Numerical Values
############################################################

for(i in 1:n){
  
  if(gmm_group[i]=="Low"){
    
    CVSS_Score[i] <- rnorm(1,3.5,0.8)
    
    Detection_Time[i] <- rnorm(1,8,2)
    
    Response_Time[i] <- rnorm(1,12,3)
    
  }
  
  else if(gmm_group[i]=="Medium"){
    
    CVSS_Score[i] <- rnorm(1,6.2,0.9)
    
    Detection_Time[i] <- rnorm(1,18,4)
    
    Response_Time[i] <- rnorm(1,25,5)
    
  }
  
  else{
    
    CVSS_Score[i] <- rnorm(1,8.7,0.7)
    
    Detection_Time[i] <- rnorm(1,35,7)
    
    Response_Time[i] <- rnorm(1,45,8)
    
  }
  
}

############################################################
# Keep values within limits
############################################################

CVSS_Score <- pmin(pmax(CVSS_Score,0),10)

Detection_Time <- pmax(Detection_Time,1)

Response_Time <- pmax(Response_Time,1)

############################################################
# Severity
############################################################

Severity <- cut(
  
  CVSS_Score,
  
  breaks=c(-Inf,3.9,6.9,8.9,Inf),
  
  labels=c(
    
    "Low",
    
    "Medium",
    
    "High",
    
    "Critical"
    
  )
  
)

############################################################
# Attack Success
############################################################

Attack_Success <- ifelse(
  
  runif(n)<0.5,
  
  "Yes",
  
  "No"
  
)

############################################################
# Security Control
############################################################

Security_Control_Effectiveness <-
  
  round(
    
    runif(
      
      n,
      
      40,
      
      95
      
    ),
    
    2
    
  )

############################################################
# Risk Score
############################################################

Risk_Score <-
  
  round(
    
    (CVSS_Score*7)+
      
      (Detection_Time*0.4)+
      
      ifelse(
        
        Attack_Success=="Yes",
        
        15,
        
        0
        
      )-
      
      (Security_Control_Effectiveness*0.15),
    
    2
    
  )

Risk_Score <- pmin(pmax(Risk_Score,0),100)

############################################################
# Final Dataset
############################################################

devsecops_data <- data.frame(
  
  Record_ID=1:n,
  
  Threat,
  
  Vulnerability,
  
  Attack_Type,
  
  Severity,
  
  CVSS_Score=round(CVSS_Score,2),
  
  Detection_Time=round(Detection_Time,2),
  
  Response_Time=round(Response_Time,2),
  
  Security_Control_Effectiveness,
  
  Attack_Success,
  
  Risk_Score
  
)

############################################################
# Save CSV
############################################################

write.csv(
  
  devsecops_data,
  
  "devsecops_synthetic_data.csv",
  
  row.names=FALSE
  
)

############################################################
# Display
############################################################

cat("========================================\n")

cat("STEP 1 COMPLETED SUCCESSFULLY\n")

cat("========================================\n")

cat("Total Records :",nrow(devsecops_data),"\n")

cat("Columns :",ncol(devsecops_data),"\n")

cat("CSV Created : devsecops_synthetic_data.csv\n")

print(head(devsecops_data))