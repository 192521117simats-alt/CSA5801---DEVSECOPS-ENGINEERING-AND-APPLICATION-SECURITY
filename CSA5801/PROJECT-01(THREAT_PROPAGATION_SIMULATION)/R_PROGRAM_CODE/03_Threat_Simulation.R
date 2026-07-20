############################################################
# STEP 3 : THREAT PROPAGATION SIMULATION (ABM STYLE)
############################################################

rm(list = ls())

############################################################
# 1. LOAD MODELED DATA
############################################################

data <- read.csv("modeled_threat_data.csv")

############################################################
# 2. INITIALIZE SIMULATION
############################################################

set.seed(123)

iterations <- 20   # time steps

# Select 50 random starting threats
active_nodes <- sample(1:nrow(data), 50)

spread_count <- numeric(iterations)

############################################################
# 3. SIMULATION LOOP (PROPAGATION LOGIC)
############################################################

for(t in 1:iterations){
  
  new_nodes <- c()
  
  for(node in active_nodes){
    
    prob <- data$Propagation_Score[node]
    
    # Spread probability
    if(runif(1) < prob){
      
      # Spread to 1–3 new nodes
      targets <- sample(1:nrow(data), sample(1:3,1))
      
      new_nodes <- c(new_nodes, targets)
    }
  }
  
  # Update active nodes
  active_nodes <- unique(c(active_nodes, new_nodes))
  
  # Store spread size
  spread_count[t] <- length(active_nodes)
}

############################################################
# 4. SAVE SIMULATION RESULTS
############################################################

sim_data <- data.frame(
  Time = 1:iterations,
  Active_Threats = spread_count
)

write.csv(sim_data, "simulation_results.csv", row.names=FALSE)

############################################################
# 5. CONSOLE OUTPUT
############################################################

cat("\n==============================\n")
cat("STEP 3 COMPLETED\n")
cat("==============================\n")

cat("\nFinal Active Threats:", tail(spread_count,1), "\n")

cat("\nSpread Over Time:\n")
print(sim_data)

############################################################
# 6. CREATE FOLDER
############################################################

if(!dir.exists("Step3_Plots")){
  dir.create("Step3_Plots")
}

############################################################
# 7. SAVE GRAPHS
############################################################

# LINE GRAPH (SPREAD)
png("Step3_Plots/spread_line.png",1200,800)

plot(sim_data$Time,
     sim_data$Active_Threats,
     type="o",
     col="red",
     lwd=3,
     main="Threat Propagation Over Time",
     xlab="Time",
     ylab="Active Threats")

dev.off()

# BAR GRAPH
png("Step3_Plots/spread_bar.png",1200,800)

barplot(sim_data$Active_Threats,
        col="blue",
        main="Threat Spread Per Iteration")

dev.off()

############################################################
# 8. ARCHITECTURE (PLOTS PANEL)
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
text(5,8,"Initial Nodes",cex=0.9)
text(8,8,"Propagation Logic",cex=0.8)
text(5,5,"Simulation Loop",cex=0.8)
text(5,2,"Results Output",cex=0.8)

# ARROWS
arrows(3,8,4,8,lwd=2)
arrows(6,8,7,8,lwd=2)
arrows(5,7,5,6,lwd=2)
arrows(5,4,5,3,lwd=2)

# TITLE
title("STEP 3 : THREAT PROPAGATION SIMULATION",
      col.main="darkgreen",cex.main=1.4)

############################################################
# FINAL MESSAGE
############################################################

cat("\nSimulation file saved: simulation_results.csv\n")
cat("\nGraphs saved in Step3_Plots folder\n")
cat("\nArchitecture shown in Plots panel\n")