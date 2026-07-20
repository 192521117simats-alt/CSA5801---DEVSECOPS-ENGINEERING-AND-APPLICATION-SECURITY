############################################################
# STEP 1 : THREAT PROPAGATION DATA GENERATION
############################################################

# Clean environment
rm(list = ls())

# For reproducibility
set.seed(100)

# Number of records
n <- 1000

############################################################
# 1. THREAT SOURCES (External + Internal)
############################################################

Threat_Source <- sample(
  c("Hacker_AI",        # external
    "Hacker_Human",     # external
    "Virus",            # external
    "Malware",          # external
    "Phishing",         # external
    "Weak_Password",    # internal
    "Insider_Attack",   # internal
    "Data_Leak",        # internal
    "Unpatched_System", # internal
    "Misconfiguration"  # internal
  ),
  n,
  replace = TRUE
)

############################################################
# 2. PROPAGATION DIRECTION
############################################################

Direction <- sample(
  c("Forward", "Backward", "Upward", "Downward", "Cross"),
  n,
  replace = TRUE
)

############################################################
# 3. PROPAGATION PATTERN
############################################################

Pattern <- sample(
  c("Linear", "Circular", "Random", "Hybrid"),
  n,
  replace = TRUE
)

############################################################
# 4. TRANSMISSION MEDIUM
############################################################

Medium <- sample(
  c("Network", "Email", "USB", "Cloud", "Internal_System"),
  n,
  replace = TRUE
)

############################################################
# 5. NUMERICAL FACTORS
############################################################

Attack_Strength <- round(runif(n, 1, 10), 2)
Propagation_Speed <- round(runif(n, 1, 10), 2)
Impact <- round(runif(n, 10, 100), 2)

############################################################
# 6. MUTATION (0 = No, 1 = Yes)
############################################################

Mutation <- sample(c(0, 1), n, replace = TRUE)

############################################################
# 7. VULNERABILITY SCORE
############################################################

Vulnerability_Score <- round(runif(n, 1, 10), 2)

############################################################
# 8. RISK SCORE (COMBINED LOGIC)
############################################################

Risk_Score <- round(
  (Attack_Strength * 0.30) +
    (Propagation_Speed * 0.20) +
    (Impact * 0.04) +
    (Vulnerability_Score * 0.10),
  2
)

############################################################
# 9. CREATE DATA FRAME
############################################################

threat_data <- data.frame(
  Threat_Source,
  Direction,
  Pattern,
  Medium,
  Attack_Strength,
  Propagation_Speed,
  Impact,
  Mutation,
  Vulnerability_Score,
  Risk_Score
)

############################################################
# 10. SAVE CSV FILE
############################################################

write.csv(
  threat_data,
  "threat_data.csv",
  row.names = FALSE
)

############################################################
# 11. OUTPUT CHECK
############################################################

cat("========================================\n")
cat("STEP 1 COMPLETED SUCCESSFULLY\n")
cat("========================================\n")

cat("Total Records:", nrow(threat_data), "\n")
cat("Columns:", ncol(threat_data), "\n")

cat("\nCSV File Created: threat_data.csv\n\n")

print(head(threat_data))