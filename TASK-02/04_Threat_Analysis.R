############################################################
# STEP 4 : THREAT PROPAGATION ANALYSIS
############################################################

# Clear environment
rm(list = ls())

############################################################
# 1. LOAD DATA
############################################################

data <- read.csv("propagation_results.csv")

############################################################
# 2. BASIC SUMMARY
############################################################

cat("========================================\n")
cat("STEP 4 : ANALYSIS\n")
cat("========================================\n\n")

summary(data)

cat("\nMean Final Impact:", mean(data$Final_Impact))
cat("\nMean Nodes Infected:", mean(data$Nodes_Infected))

############################################################
# 3. INTERNAL vs EXTERNAL ANALYSIS
############################################################

cat("\n\nThreat Type Distribution:\n")
print(table(data$Threat_Type))

cat("\nSpread by Threat Type:\n")
print(table(data$Threat_Type, data$Spread_Status))

############################################################
# 4. CHI-SQUARE TEST
############################################################

cat("\n========================================\n")
cat("CHI-SQUARE TEST\n")
cat("========================================\n")

chi <- chisq.test(
  table(data$Spread_Status, data$Pattern)
)

print(chi)

############################################################
# 5. ANOVA TEST
############################################################

cat("\n========================================\n")
cat("ANOVA TEST\n")
cat("========================================\n")

anova_result <- aov(
  Final_Impact ~ Direction,
  data = data
)

print(summary(anova_result))

############################################################
# 6. CORRELATION
############################################################

cat("\n========================================\n")
cat("CORRELATION\n")
cat("========================================\n")

correlation <- cor(
  data$Nodes_Infected,
  data$Final_Impact
)

print(correlation)

############################################################
# 7. CREATE GRAPH FOLDER
############################################################

if(!dir.exists("Graphs")){
  dir.create("Graphs")
}

############################################################
# 8. BAR CHART (Spread vs Contained)
############################################################

png("Graphs/01_Spread_Status.png", width=1200, height=800)

barplot(
  table(data$Spread_Status),
  col=c("red","green"),
  main="Threat Spread vs Contained",
  ylab="Count"
)

dev.off()

############################################################
# 9. THREAT TYPE COMPARISON
############################################################

png("Graphs/02_Threat_Type.png", width=1200, height=800)

barplot(
  table(data$Threat_Type),
  col=c("blue","orange"),
  main="Internal vs External Threats"
)

dev.off()

############################################################
# 10. HISTOGRAM (Impact)
############################################################

png("Graphs/03_Impact.png", width=1200, height=800)

hist(
  data$Final_Impact,
  col="purple",
  main="Final Impact Distribution",
  xlab="Impact"
)

dev.off()

############################################################
# 11. BOXPLOT (Direction vs Impact)
############################################################

png("Graphs/04_Direction_Impact.png", width=1200, height=800)

boxplot(
  Final_Impact ~ Direction,
  data=data,
  col=rainbow(5),
  main="Impact by Direction"
)

dev.off()

############################################################
# 12. OUTPUT
############################################################

cat("\n========================================\n")
cat("STEP 4 COMPLETED SUCCESSFULLY\n")
cat("========================================\n")

cat("\nGraphs saved in 'Graphs' folder\n")
cat("\nProject Completed Successfully 🎉\n")