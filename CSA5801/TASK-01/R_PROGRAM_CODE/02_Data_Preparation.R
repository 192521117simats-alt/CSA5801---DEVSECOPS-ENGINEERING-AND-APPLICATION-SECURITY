############################################################
# STEP 2 : DATA PREPARATION FOR SIMULATION
# DEVSECOPS SIMULATION
############################################################

# Clear workspace
rm(list = ls())

############################################################
# Load Step 1 CSV file
############################################################

data <- read.csv("devsecops_synthetic_data.csv")

############################################################
# Check dataset
############################################################

cat("Original rows:", nrow(data), "\n")
cat("Original columns:", ncol(data), "\n")

print(head(data))

############################################################
# Check missing values
############################################################

missing_values <- colSums(is.na(data))

cat("\nMissing values in each column:\n")
print(missing_values)

############################################################
# Remove duplicate records
############################################################

data <- unique(data)

cat("\nRows after removing duplicates:", nrow(data), "\n")

############################################################
# Convert categorical columns into factors
############################################################

data$Threat <- as.factor(data$Threat)
data$Vulnerability <- as.factor(data$Vulnerability)
data$Attack_Type <- as.factor(data$Attack_Type)
data$Severity <- as.factor(data$Severity)
data$Attack_Success <- as.factor(data$Attack_Success)

############################################################
# Normalization function
############################################################

normalize <- function(x) {
  
  if (max(x) == min(x)) {
    return(rep(0, length(x)))
  }
  
  return((x - min(x)) / (max(x) - min(x)))
}

############################################################
# Normalize numerical variables
############################################################

data$CVSS_Norm <- normalize(data$CVSS_Score)

data$Detection_Norm <- normalize(data$Detection_Time)

data$Response_Norm <- normalize(data$Response_Time)

data$Risk_Norm <- normalize(data$Risk_Score)

############################################################
# Create simulation variables
############################################################

set.seed(234)

data$Attack_Probability <- round(
  0.20 + (data$Risk_Norm * 0.60),
  2
)

data$Detection_Probability <- round(
  0.30 +
    ((data$Security_Control_Effectiveness / 100) * 0.60),
  2
)

data$Recovery_Time <- round(
  5 +
    (data$Risk_Norm * 45) +
    runif(nrow(data), 0, 10),
  2
)

############################################################
# Keep probabilities between 0 and 1
############################################################

data$Attack_Probability <- pmin(
  pmax(data$Attack_Probability, 0),
  1
)

data$Detection_Probability <- pmin(
  pmax(data$Detection_Probability, 0),
  1
)

############################################################
# Save simulation-ready dataset
############################################################

write.csv(
  data,
  "devsecops_simulation_ready.csv",
  row.names = FALSE
)

############################################################
# Display result
############################################################

cat("\n========================================\n")
cat("STEP 2 COMPLETED SUCCESSFULLY\n")
cat("========================================\n")

cat("Final rows:", nrow(data), "\n")
cat("Final columns:", ncol(data), "\n")
cat("CSV created: devsecops_simulation_ready.csv\n")

print(head(data))