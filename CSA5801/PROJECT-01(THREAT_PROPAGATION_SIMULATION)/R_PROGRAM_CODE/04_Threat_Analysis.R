############################################################
# STEP 4 : THREAT ANALYSIS (INTERNAL vs EXTERNAL)
############################################################

rm(list = ls())

############################################################
# 1. LOAD DATA
############################################################

data <- read.csv("modeled_threat_data.csv")

############################################################
# 2. BASIC SUMMARY
############################################################

cat("\n==============================\n")
cat("STEP 4 STARTED\n")
cat("==============================\n")

############################################################
# 3. GROUP ANALYSIS
############################################################

# Mean values
analysis <- aggregate(
  cbind(Impact, Attack_Strength, Propagation_Score) ~ Type,
  data = data,
  mean
)

print("\nAverage Values by Threat Type:")
print(analysis)

############################################################
# 4. STATISTICAL TEST (T-TEST)
############################################################

impact_test <- t.test(Impact ~ Type, data = data)
attack_test <- t.test(Attack_Strength ~ Type, data = data)

cat("\nT-Test (Impact):\n")
print(impact_test)

cat("\nT-Test (Attack Strength):\n")
print(attack_test)

############################################################
# 5. SAVE ANALYSIS
############################################################

write.csv(analysis, "threat_analysis.csv", row.names = FALSE)

############################################################
# 6. CREATE FOLDER
############################################################

if(!dir.exists("Step4_Plots")){
  dir.create("Step4_Plots")
}

############################################################
# 7. VISUALIZATIONS
############################################################

# BAR: Impact Comparison
png("Step4_Plots/impact_compare.png",1200,800)

barplot(analysis$Impact,
        names.arg=analysis$Type,
        col=c("red","blue"),
        main="Impact Comparison")

dev.off()

# BAR: Attack Strength
png("Step4_Plots/attack_compare.png",1200,800)

barplot(analysis$Attack_Strength,
        names.arg=analysis$Type,
        col=c("orange","purple"),
        main="Attack Strength Comparison")

dev.off()

# BOXPLOT
png("Step4_Plots/boxplot.png",1200,800)

boxplot(Propagation_Score ~ Type,
        data=data,
        col=c("green","red"),
        main="Propagation Score Distribution")

dev.off()

############################################################
# 8. DECISION LOGIC
############################################################

if(analysis$Impact[analysis$Type=="External"] >
   analysis$Impact[analysis$Type=="Internal"]){
  result <- "External Threats are MORE dangerous"
} else {
  result <- "Internal Threats are MORE dangerous"
}

cat("\nFINAL RESULT:\n", result, "\n")

############################################################
# 9. ARCHITECTURE (PLOTS PANEL)
############################################################

par(mar=c(1,1,2,1))
plot(0,0,type="n",xlim=c(0,10),ylim=c(0,10),
     axes=FALSE,xlab="",ylab="")

# BOXES
rect(1,7,3,9,col="lightblue")
rect(4,7,6,9,col="khaki")
rect(7,7,9,9,col="lightgreen")
rect(4,4,6,6,col="orange")
rect(4,1,6,3,col="lightcoral")

# TEXT
text(2,8,"Modeled Data",cex=0.9)
text(5,8,"Grouping",cex=0.9)
text(8,8,"Statistical Test",cex=0.8)
text(5,5,"Comparison",cex=0.8)
text(5,2,"Final Decision",cex=0.8)

# ARROWS
arrows(3,8,4,8,lwd=2)
arrows(6,8,7,8,lwd=2)
arrows(5,7,5,6,lwd=2)
arrows(5,4,5,3,lwd=2)

# TITLE
title("STEP 4 : THREAT ANALYSIS",
      col.main="darkorange",cex.main=1.4)

############################################################
# FINAL MESSAGE
############################################################

cat("\nAnalysis saved: threat_analysis.csv\n")
cat("\nGraphs saved in Step4_Plots folder\n")
cat("\nArchitecture shown in Plots panel\n")