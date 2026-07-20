############################################################
# STEP 2 : DATA PREPARATION
############################################################

# Clear environment
rm(list = ls())

############################################################
# 1. LOAD DATA FROM STEP 1
############################################################

data <- read.csv("threat_data.csv")

cat("Data Loaded Successfully\n")

############################################################
# 2. BASIC CHECK
############################################################

cat("Rows:", nrow(data), "\n")
cat("Columns:", ncol(data), "\n")

print(head(data))

############################################################
# 3. CONVERT CATEGORICAL VARIABLES TO FACTOR
############################################################

data$Threat_Source <- as.factor(data$Threat_Source)
data$Direction <- as.factor(data$Direction)
data$Pattern <- as.factor(data$Pattern)
data$Medium <- as.factor(data$Medium)

############################################################
# 4. NORMALIZATION FUNCTION
############################################################

normalize <- function(x){
  
  if(max(x) == min(x)){
    return(rep(0, length(x)))
  }
  
  return((x - min(x)) / (max(x) - min(x)))
}

############################################################
# 5. NORMALIZE IMPORTANT VARIABLES
############################################################

data$Risk_Norm <- normalize(data$Risk_Score)
data$Impact_Norm <- normalize(data$Impact)
data$Speed_Norm <- normalize(data$Propagation_Speed)

############################################################
# 6. CREATE PROPAGATION PROBABILITY
############################################################

set.seed(200)

data$Propagation_Probability <- round(
  0.2 +
    (data$Risk_Norm * 0.4) +
    (data$Impact_Norm * 0.2) +
    (data$Speed_Norm * 0.2),
  2
)

# Keep between 0 and 1
data$Propagation_Probability <- pmin(
  pmax(data$Propagation_Probability, 0),
  1
)

############################################################
# 7. CLASSIFY THREAT TYPE (INTERNAL / EXTERNAL)
############################################################

data$Threat_Type <- ifelse(
  data$Threat_Source %in% c("Hacker_AI","Hacker_Human","Virus","Malware","Phishing"),
  "External",
  "Internal"
)

############################################################
# 8. SAVE PREPARED DATA
############################################################

write.csv(
  data,
  "prepared_data.csv",
  row.names = FALSE
)

############################################################
# 9. OUTPUT
############################################################

cat("\n========================================\n")
cat("STEP 2 COMPLETED SUCCESSFULLY\n")
cat("========================================\n")

cat("Final Rows:", nrow(data), "\n")
cat("Final Columns:", ncol(data), "\n")

cat("\nCSV Created: prepared_data.csv\n")

print(head(data))