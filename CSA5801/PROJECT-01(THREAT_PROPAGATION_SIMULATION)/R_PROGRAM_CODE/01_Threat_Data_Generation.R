############################################################
# STEP 1 : THREAT PROPAGATION DATA GENERATION (FINAL)
############################################################

rm(list = ls())
set.seed(123)

############################################################
# 1. DEFINE THREATS
############################################################

external_threats <- c(
  "Hacker_Active",
  "Hacker_Passive",
  "AI_Attack",
  "Virus",
  "Supply_Chain"
)

internal_threats <- c(
  "Weak_Password",
  "No_Encryption",
  "Rogue_Employee",
  "Data_Leak",
  "Insider_Malware"
)

all_threats <- c(external_threats, internal_threats)

############################################################
# 2. PROPAGATION FACTORS
############################################################

direction <- c("Upward","Downward","Forward","Backward","Cross")
vector <- c("Network","Email","USB","Cloud","API")
pattern <- c("Linear","Circular","Random")
medium <- c("Wireless","Wired","Hybrid")

############################################################
# 3. GENERATE DATA (1000 RECORDS)
############################################################

n <- 1000

data <- data.frame(
  Threat = sample(all_threats, n, replace=TRUE),
  Type = sample(c("External","Internal"), n, replace=TRUE),
  Direction = sample(direction, n, replace=TRUE),
  Vector = sample(vector, n, replace=TRUE),
  Pattern = sample(pattern, n, replace=TRUE),
  Medium = sample(medium, n, replace=TRUE),
  Speed = round(rnorm(n,50,15),2),
  Impact = round(rnorm(n,70,20),2),
  Mutation = round(runif(n,0,1),2),
  Attack_Strength = round(rnorm(n,60,15),2)
)

# Fix negative values
data$Speed[data$Speed < 0] <- 10
data$Impact[data$Impact < 0] <- 10

############################################################
# 4. SAVE CSV
############################################################

write.csv(data, "threat_data.csv", row.names = FALSE)

############################################################
# 5. CONSOLE OUTPUT
############################################################

cat("\n==============================\n")
cat("STEP 1 COMPLETED\n")
cat("==============================\n")

cat("\nTotal Records:", nrow(data))
cat("\nTotal Columns:", ncol(data), "\n")

cat("\nSample Data:\n")
print(head(data))

cat("\nThreat Distribution:\n")
print(table(data$Threat))

cat("\nType Distribution:\n")
print(table(data$Type))

############################################################
# 6. CREATE PLOTS FOLDER
############################################################

if(!dir.exists("Step1_Plots")){
  dir.create("Step1_Plots")
}

############################################################
# 7. SAVE GRAPHS
############################################################

# BAR GRAPH
png("Step1_Plots/threat_bar.png",1200,800)
barplot(table(data$Threat),
        col=rainbow(10),
        main="Threat Distribution",
        las=2)
dev.off()

# PIE CHART
png("Step1_Plots/type_pie.png",1200,800)
pie(table(data$Type),
    col=c("red","blue"),
    main="Internal vs External")
dev.off()

# HISTOGRAM
png("Step1_Plots/impact_hist.png",1200,800)
hist(data$Impact,
     col="orange",
     main="Impact Distribution")
dev.off()

############################################################
# 8. ARCHITECTURE (SHOWS IN PLOTS PANEL ✅)
############################################################

par(mar=c(1,1,2,1))
plot(0,0,type="n",xlim=c(0,10),ylim=c(0,10),
     axes=FALSE,xlab="",ylab="")

# BOXES
rect(1,7,3,9,col="lightcoral")   # External
rect(1,4,3,6,col="lightblue")    # Internal
rect(4,6,6,8,col="khaki")        # Factors
rect(7,6,9,8,col="lightgreen")   # Data
rect(4,2,6,4,col="lightcyan")    # CSV

# TEXT
text(2,8,"External\nThreats",cex=0.8)
text(2,5,"Internal\nThreats",cex=0.8)
text(5,7,"Propagation\nFactors",cex=0.8)
text(8,7,"Synthetic\nData",cex=0.8)
text(5,3,"CSV File",cex=0.9)

# ARROWS
arrows(3,8,4,7,col="red",lwd=2)
arrows(3,5,4,7,col="blue",lwd=2)
arrows(6,7,7,7,col="orange",lwd=2)
arrows(5,6,5,4,col="black",lwd=2)

# TITLE
title("STEP 1 : THREAT PROPAGATION ARCHITECTURE",
      col.main="darkred",cex.main=1.4)

############################################################
# FINAL MESSAGE
############################################################

cat("\nCSV file created: threat_data.csv\n")
cat("\nGraphs saved in Step1_Plots folder\n")
cat("\nArchitecture displayed in Plots panel\n")