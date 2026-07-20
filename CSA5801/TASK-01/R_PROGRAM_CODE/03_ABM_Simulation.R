############################################################
# STEP 3 : AGENT-BASED MODEL (ABM) SIMULATION
# DEVSECOPS THREAT SIMULATION
############################################################

# Clear workspace
rm(list = ls())

# Set seed for repeatable results
set.seed(456)

############################################################
# Load the prepared dataset from Step 2
############################################################

data <- read.csv("devsecops_simulation_ready.csv")

n_events <- nrow(data)

############################################################
# Create empty output variables
############################################################

Attack_Launched <- character(n_events)
Firewall_Blocked <- character(n_events)
IDS_Detected <- character(n_events)
System_Compromised <- character(n_events)
Security_Response <- character(n_events)
Damage_Level <- numeric(n_events)
Simulation_Result <- character(n_events)

############################################################
# ABM AGENTS
############################################################
# 1. Attacker Agent
# 2. Firewall Agent
# 3. IDS Agent
# 4. Server Agent
# 5. Security Team Agent
############################################################

for (i in 1:n_events) {
  
  ##########################################################
  # 1. ATTACKER AGENT
  ##########################################################
  
  attack_probability <- data$Attack_Probability[i]
  
  attack_launched <- runif(1) < attack_probability
  
  if (!attack_launched) {
    
    Attack_Launched[i] <- "No"
    Firewall_Blocked[i] <- "Not Required"
    IDS_Detected[i] <- "No Attack"
    System_Compromised[i] <- "No"
    Security_Response[i] <- "Not Required"
    Damage_Level[i] <- 0
    Simulation_Result[i] <- "Attack Not Launched"
    
    next
  }
  
  Attack_Launched[i] <- "Yes"
  
  ##########################################################
  # 2. FIREWALL AGENT
  ##########################################################
  
  control_effectiveness <-
    data$Security_Control_Effectiveness[i] / 100
  
  firewall_probability <-
    control_effectiveness * 0.75
  
  firewall_block <-
    runif(1) < firewall_probability
  
  if (firewall_block) {
    
    Firewall_Blocked[i] <- "Yes"
    IDS_Detected[i] <- "Not Required"
    System_Compromised[i] <- "No"
    Security_Response[i] <- "Attack Blocked"
    Damage_Level[i] <- round(runif(1, 0, 10), 2)
    Simulation_Result[i] <- "Blocked by Firewall"
    
    next
    
  } else {
    
    Firewall_Blocked[i] <- "No"
  }
  
  ##########################################################
  # 3. IDS AGENT
  ##########################################################
  
  detection_probability <-
    data$Detection_Probability[i]
  
  ids_detection <-
    runif(1) < detection_probability
  
  if (ids_detection) {
    
    IDS_Detected[i] <- "Yes"
    
  } else {
    
    IDS_Detected[i] <- "No"
  }
  
  ##########################################################
  # 4. SERVER AGENT
  ##########################################################
  
  cvss_effect <-
    data$CVSS_Score[i] / 10
  
  risk_effect <-
    data$Risk_Score[i] / 100
  
  compromise_probability <-
    0.20 +
    (cvss_effect * 0.35) +
    (risk_effect * 0.25)
  
  if (ids_detection) {
    
    compromise_probability <-
      compromise_probability - 0.25
  }
  
  compromise_probability <-
    max(0.05, min(compromise_probability, 0.95))
  
  compromised <-
    runif(1) < compromise_probability
  
  if (compromised) {
    
    System_Compromised[i] <- "Yes"
    
  } else {
    
    System_Compromised[i] <- "No"
  }
  
  ##########################################################
  # 5. SECURITY TEAM AGENT
  ##########################################################
  
  if (ids_detection && !compromised) {
    
    Security_Response[i] <- "Detected and Contained"
    
  } else if (ids_detection && compromised) {
    
    Security_Response[i] <- "Detected After Compromise"
    
  } else if (!ids_detection && compromised) {
    
    Security_Response[i] <- "Late Incident Response"
    
  } else {
    
    Security_Response[i] <- "No Major Response"
  }
  
  ##########################################################
  # DAMAGE CALCULATION
  ##########################################################
  
  if (compromised) {
    
    Damage_Level[i] <- round(
      (data$Risk_Score[i] * 0.65) +
        (data$CVSS_Score[i] * 3) +
        runif(1, 5, 20),
      2
    )
    
  } else {
    
    Damage_Level[i] <- round(
      data$Risk_Score[i] * runif(1, 0.05, 0.25),
      2
    )
  }
  
  Damage_Level[i] <-
    min(Damage_Level[i], 100)
  
  ##########################################################
  # FINAL SIMULATION RESULT
  ##########################################################
  
  if (compromised && !ids_detection) {
    
    Simulation_Result[i] <-
      "Successful Undetected Attack"
    
  } else if (compromised && ids_detection) {
    
    Simulation_Result[i] <-
      "Successful but Detected"
    
  } else if (!compromised && ids_detection) {
    
    Simulation_Result[i] <-
      "Detected and Prevented"
    
  } else {
    
    Simulation_Result[i] <-
      "Attack Failed"
  }
}

############################################################
# Create final simulation dataset
############################################################

simulation_results <- data.frame(
  data,
  Attack_Launched = Attack_Launched,
  Firewall_Blocked = Firewall_Blocked,
  IDS_Detected = IDS_Detected,
  System_Compromised = System_Compromised,
  Security_Response = Security_Response,
  Damage_Level = Damage_Level,
  Simulation_Result = Simulation_Result
)

############################################################
# Save simulation output
############################################################

write.csv(
  simulation_results,
  "simulation_results.csv",
  row.names = FALSE
)

############################################################
# Display simulation summary
############################################################

cat("\n========================================\n")
cat("STEP 3 ABM SIMULATION COMPLETED\n")
cat("========================================\n")

cat("Total simulation events:", nrow(simulation_results), "\n")

cat("\nAttack launched:\n")
print(table(simulation_results$Attack_Launched))

cat("\nFirewall result:\n")
print(table(simulation_results$Firewall_Blocked))

cat("\nIDS detection result:\n")
print(table(simulation_results$IDS_Detected))

cat("\nSystem compromise result:\n")
print(table(simulation_results$System_Compromised))

cat("\nFinal simulation result:\n")
print(table(simulation_results$Simulation_Result))

cat("\nAverage damage level:",
    round(mean(simulation_results$Damage_Level), 2),
    "\n")

cat("\nCSV created: simulation_results.csv\n")