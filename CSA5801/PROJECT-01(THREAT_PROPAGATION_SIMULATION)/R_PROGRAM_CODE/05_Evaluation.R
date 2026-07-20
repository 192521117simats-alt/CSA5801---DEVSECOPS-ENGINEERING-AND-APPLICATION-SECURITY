############################################################
# STEP 5 : MODEL EVALUATION & FINAL RESULT
############################################################

rm(list = ls())

############################################################
# 1. LOAD DATA
############################################################

data <- read.csv("modeled_threat_data.csv")

############################################################
# 2. CONVERT FACTORS
############################################################

data$Risk_Level <- as.factor(data$Risk_Level)

############################################################
# 3. ANOVA TEST
############################################################

anova_model <- aov(Propagation_Score ~ Risk_Level, data=data)

cat("\n==============================\n")
cat("STEP 5 COMPLETED\n")
cat("==============================\n")

cat("\nANOVA RESULT:\n")
print(summary(anova_model))

############################################################
# 4. MEAN COMPARISON
############################################################

means <- aggregate(Propagation_Score ~ Risk_Level, data, mean)

cat("\nMean Propagation Score by Risk Level:\n")
print(means)

############################################################
# 5. SAVE RESULTS
############################################################

write.csv(means, "final_evaluation.csv", row.names=FALSE)

############################################################
# 6. CREATE FOLDER
############################################################

if(!dir.exists("Step5_Plots")){
  dir.create("Step5_Plots")
}

############################################################
# 7. VISUALIZATION
############################################################

# BAR GRAPH
png("Step5_Plots/risk_mean.png",1200,800)

barplot(means$Propagation_Score,
        names.arg=means$Risk_Level,
        col=c("green","orange","red"),
        main="Mean Propagation Score by Risk Level")

dev.off()

# BOXPLOT
png("Step5_Plots/final_boxplot.png",1200,800)

boxplot(Propagation_Score ~ Risk_Level,
        data=data,
        col=c("green","orange","red"),
        main="Final Risk Analysis")

dev.off()

############################################################
# 8. FINAL DECISION
############################################################

highest <- means$Risk_Level[which.max(means$Propagation_Score)]

cat("\nFINAL INSIGHT:\n")
cat("Highest Risk Level is:", highest, "\n")

############################################################
# 9. MASTER ARCHITECTURE (FULL SYSTEM DESIGN)
############################################################

par(mar=c(1,1,3,1))
plot(0,0,type="n",xlim=c(0,12),ylim=c(0,12),
     axes=FALSE,xlab="",ylab="")

############################################
# LAYER 1 — DATA INPUT
############################################
rect(1,10,4,11.5,col="lightblue")
text(2.5,10.7,"Raw Threat Data\n(CSV Input)",cex=0.8)

############################################
# LAYER 2 — DATA PROCESSING
############################################
rect(5,10,8,11.5,col="khaki")
text(6.5,10.7,"Preprocessing\nCleaning + Labeling",cex=0.8)

############################################
# LAYER 3 — MODELING
############################################
rect(9,10,11.5,11.5,col="lightgreen")
text(10.2,10.7,"Threat Modeling\n(Score Generation)",cex=0.7)

############################################
# LAYER 4 — SIMULATION ENGINE
############################################
rect(3,7,6,9,col="orange")
text(4.5,8,"Propagation Simulation\n(Iteration Based)",cex=0.8)

############################################
# LAYER 5 — ANALYSIS
############################################
rect(7,7,10,9,col="plum")
text(8.5,8,"Threat Analysis\nInternal vs External",cex=0.8)

############################################
# LAYER 6 — STATISTICS
############################################
rect(2,4,5,6,col="lightcoral")
text(3.5,5,"Statistical Testing\nT-test / ANOVA",cex=0.8)

############################################
# LAYER 7 — VISUALIZATION
############################################
rect(6,4,9,6,col="lightyellow")
text(7.5,5,"Graphs & Plots\n(Bar, Boxplot)",cex=0.8)

############################################
# LAYER 8 — FINAL DECISION
############################################
rect(4,1.5,8,3.5,col="lightpink")
text(6,2.5,"Final Risk Decision\n(High Risk Detection)",cex=0.9)

############################################
# CONNECTION ARROWS
############################################

# Top Flow
arrows(4,10.7,5,10.7,lwd=2)
arrows(8,10.7,9,10.7,lwd=2)

# Down Flow
arrows(6.5,10,5,9,lwd=2)
arrows(10.2,10,9,9,lwd=2)

# Simulation to Analysis
arrows(6,8,7,8,lwd=2)

# Down to Stats & Viz
arrows(4.5,7,3.5,6,lwd=2)
arrows(8.5,7,7.5,6,lwd=2)

# Final Merge
arrows(5,4,5.5,3.5,lwd=2)
arrows(7,4,6.5,3.5,lwd=2)

############################################
# TITLE
############################################

title("FULL DEVSECOPS THREAT PROPAGATION ARCHITECTURE",
      col.main="darkred",cex.main=1.3)
############################################################
# FINAL MESSAGE
############################################################

cat("\nEvaluation saved: final_evaluation.csv\n")
cat("\nGraphs saved in Step5_Plots folder\n")
cat("\nFinal Architecture shown in Plots panel\n")