############################################################
# STEP 2 : DATA MODELING & SIMULATION PREPARATION
############################################################

rm(list = ls())

############################################################
# 1. LOAD DATA
############################################################

data <- read.csv("threat_data.csv")

############################################################
# 2. BASIC CLEANING
############################################################

data$Type <- as.factor(data$Type)
data$Threat <- as.factor(data$Threat)
data$Direction <- as.factor(data$Direction)
data$Vector <- as.factor(data$Vector)

############################################################
# 3. CREATE PROPAGATION SCORE (IMPORTANT LOGIC)
############################################################

# Normalize values
norm <- function(x){
  (x - min(x)) / (max(x) - min(x))
}

data$Speed_N <- norm(data$Speed)
data$Impact_N <- norm(data$Impact)
data$Attack_N <- norm(data$Attack_Strength)

# Propagation Score formula
data$Propagation_Score <- round(
  (0.4 * data$Impact_N +
     0.3 * data$Speed_N +
     0.3 * data$Attack_N), 3
)

############################################################
# 4. CLASSIFY RISK LEVEL
############################################################

data$Risk_Level <- cut(
  data$Propagation_Score,
  breaks = c(0,0.3,0.6,1),
  labels = c("Low","Medium","High")
)

############################################################
# 5. SAVE MODELED DATA
############################################################

write.csv(data, "modeled_threat_data.csv", row.names = FALSE)

############################################################
# 6. CONSOLE SUMMARY
############################################################

cat("\n==============================\n")
cat("STEP 2 COMPLETED\n")
cat("==============================\n")

cat("\nTotal Records:", nrow(data))

cat("\n\nPropagation Score Summary:\n")
print(summary(data$Propagation_Score))

cat("\nRisk Level Distribution:\n")
print(table(data$Risk_Level))

############################################################
# 7. CREATE FOLDER
############################################################

if(!dir.exists("Step2_Plots")){
  dir.create("Step2_Plots")
}

############################################################
# 8. SAVE GRAPHS
############################################################

# Risk Distribution
png("Step2_Plots/risk_bar.png",1200,800)
barplot(table(data$Risk_Level),
        col=c("green","orange","red"),
        main="Risk Level Distribution")
dev.off()

# Propagation Score Histogram
png("Step2_Plots/score_hist.png",1200,800)
hist(data$Propagation_Score,
     col="purple",
     main="Propagation Score Distribution")
dev.off()

# Boxplot
png("Step2_Plots/impact_vs_risk.png",1200,800)
boxplot(Impact ~ Risk_Level,
        data=data,
        col=c("green","orange","red"),
        main="Impact vs Risk Level")
dev.off()

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
text(2,8,"CSV Data",cex=0.9)
text(5,8,"Data Cleaning",cex=0.9)
text(8,8,"Feature Engineering",cex=0.8)
text(5,5,"Propagation Score",cex=0.8)
text(5,2,"Risk Classification",cex=0.8)

# ARROWS
arrows(3,8,4,8,lwd=2)
arrows(6,8,7,8,lwd=2)
arrows(5,7,5,6,lwd=2)
arrows(5,4,5,3,lwd=2)

# TITLE
title("STEP 2 : DATA MODELING ARCHITECTURE",
      col.main="darkblue",cex.main=1.4)

############################################################
# FINAL MESSAGE
############################################################

cat("\nModeled file saved: modeled_threat_data.csv\n")
cat("\nGraphs saved in Step2_Plots folder\n")
cat("\nArchitecture shown in Plots panel\n")