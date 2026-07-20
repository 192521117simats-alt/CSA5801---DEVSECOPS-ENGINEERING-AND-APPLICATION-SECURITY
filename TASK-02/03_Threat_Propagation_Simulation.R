############################################################
# STEP 3 : THREAT PROPAGATION SIMULATION
############################################################

# Clear environment
rm(list = ls())

# Reproducibility
set.seed(300)

############################################################
# 1. LOAD PREPARED DATA
############################################################

data <- read.csv("prepared_data.csv")

n <- nrow(data)

############################################################
# 2. CREATE OUTPUT VARIABLES
############################################################

Spread_Status <- character(n)
Nodes_Infected <- numeric(n)
Final_Impact <- numeric(n)
Propagation_Path <- character(n)

############################################################
# 3. SIMULATION LOOP
############################################################

for(i in 1:n){
  
  base_prob <- data$Propagation_Probability[i]
  
  ##########################################################
  # Direction Factor
  ##########################################################
  
  direction_factor <- switch(as.character(data$Direction[i]),
                             "Forward"=0.8,
                             "Backward"=0.4,
                             "Upward"=0.6,
                             "Downward"=0.7,
                             "Cross"=0.9)
  
  ##########################################################
  # Pattern Factor
  ##########################################################
  
  pattern_factor <- switch(as.character(data$Pattern[i]),
                           "Linear"=0.5,
                           "Circular"=0.7,
                           "Random"=0.9,
                           "Hybrid"=1.0)
  
  ##########################################################
  # Mutation Effect
  ##########################################################
  
  mutation_factor <- ifelse(data$Mutation[i]==1, 1.3, 1)
  
  ##########################################################
  # Final Probability
  ##########################################################
  
  spread_prob <- base_prob *
    direction_factor *
    pattern_factor *
    mutation_factor
  
  spread_prob <- min(spread_prob, 1)
  
  ##########################################################
  # SIMULATION DECISION
  ##########################################################
  
  if(runif(1) < spread_prob){
    
    Spread_Status[i] <- "Spread"
    
    Nodes_Infected[i] <- round(runif(1, 10, 100))
    
    Final_Impact[i] <- round(
      data$Impact[i] + runif(1, 20, 50), 2
    )
    
  } else {
    
    Spread_Status[i] <- "Contained"
    
    Nodes_Infected[i] <- round(runif(1, 1, 10))
    
    Final_Impact[i] <- round(
      data$Impact[i] * runif(1, 0.3, 0.7), 2
    )
  }
  
  ##########################################################
  # PROPAGATION PATH TYPE
  ##########################################################
  
  Propagation_Path[i] <- paste(
    data$Direction[i],
    "→",
    data$Pattern[i]
  )
}

############################################################
# 4. CREATE FINAL DATASET
############################################################

result <- data.frame(
  data,
  Spread_Status,
  Nodes_Infected,
  Final_Impact,
  Propagation_Path
)

############################################################
# 5. SAVE RESULTS
############################################################

write.csv(
  result,
  "propagation_results.csv",
  row.names = FALSE
)

############################################################
# 6. OUTPUT SUMMARY
############################################################

cat("\n========================================\n")
cat("STEP 3 COMPLETED SUCCESSFULLY\n")
cat("========================================\n")

cat("Total Records:", nrow(result), "\n")

cat("\nSpread vs Contained:\n")
print(table(result$Spread_Status))

cat("\nAverage Impact:\n")
print(mean(result$Final_Impact))

cat("\nCSV Created: propagation_results.csv\n")