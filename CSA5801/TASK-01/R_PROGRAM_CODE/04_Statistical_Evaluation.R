############################################################
# STEP 4 : STATISTICAL EVALUATION
# DEVSECOPS SIMULATION
############################################################

# Clear workspace
rm(list = ls())

############################################################
# Load simulation results
############################################################

data <- read.csv("simulation_results.csv")

############################################################
# Summary Statistics
############################################################

cat("========================================\n")
cat("STEP 4 : STATISTICAL EVALUATION\n")
cat("========================================\n\n")

cat("Summary Statistics\n")
summary(data)

cat("\nMean CVSS Score : ", mean(data$CVSS_Score))
cat("\nMean Risk Score : ", mean(data$Risk_Score))
cat("\nMean Damage Level : ", mean(data$Damage_Level))

cat("\n\nStandard Deviation (Risk Score): ",
    sd(data$Risk_Score))

cat("\nStandard Deviation (Damage Level): ",
    sd(data$Damage_Level))

############################################################
# Frequency Tables
############################################################

cat("\n\nThreat Distribution\n")
print(table(data$Threat))

cat("\nAttack Type Distribution\n")
print(table(data$Attack_Type))

cat("\nSimulation Results\n")
print(table(data$Simulation_Result))

############################################################
# Chi-Square Test
############################################################

cat("\n========================================\n")
cat("CHI-SQUARE TEST\n")
cat("========================================\n")

chi <- chisq.test(
  table(data$Threat,
        data$Attack_Success)
)

print(chi)

############################################################
# ANOVA
############################################################

cat("\n========================================\n")
cat("ANOVA TEST\n")
cat("========================================\n")

anova_result <-
  aov(
    Risk_Score ~ Threat,
    data=data
  )

print(summary(anova_result))

############################################################
# Correlation
############################################################

cat("\n========================================\n")
cat("CORRELATION\n")
cat("========================================\n")

correlation <-
  cor(
    data$CVSS_Score,
    data$Risk_Score
  )

print(correlation)

############################################################
# T-Test
############################################################

cat("\n========================================\n")
cat("T-TEST\n")
cat("========================================\n")

ttest <-
  t.test(
    Damage_Level ~ Attack_Success,
    data=data
  )

print(ttest)

############################################################
# Create Graph Folder
############################################################

if(!dir.exists("Graphs")){
  
  dir.create("Graphs")
  
}

############################################################
# Bar Chart
############################################################

png(
  "Graphs/01_Threat_Distribution.png",
  width=1200,
  height=800
)

barplot(
  table(data$Threat),
  col=c("red","blue","green","orange"),
  main="Threat Distribution",
  ylab="Count"
)

dev.off()

############################################################
# Pie Chart
############################################################

png(
  "Graphs/02_Attack_Type.png",
  width=1200,
  height=800
)

pie(
  table(data$Attack_Type),
  col=rainbow(3),
  main="Attack Type Distribution"
)

dev.off()

############################################################
# Histogram
############################################################

png(
  "Graphs/03_Risk_Score.png",
  width=1200,
  height=800
)

hist(
  data$Risk_Score,
  col="skyblue",
  main="Risk Score Distribution",
  xlab="Risk Score"
)

dev.off()

############################################################
# Boxplot
############################################################

png(
  "Graphs/04_Risk_by_Threat.png",
  width=1200,
  height=800
)

boxplot(
  Risk_Score~Threat,
  data=data,
  col=rainbow(4),
  main="Risk Score by Threat"
)

dev.off()

############################################################
# Completion
############################################################

cat("\n========================================\n")
cat("STEP 4 COMPLETED SUCCESSFULLY\n")
cat("========================================\n")

cat("\nGraphs saved inside Graphs folder\n")
cat("\nEvaluation completed successfully.\n")