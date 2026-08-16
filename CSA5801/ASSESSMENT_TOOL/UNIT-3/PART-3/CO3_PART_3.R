# ================================================================
# CO3 - PART 3
# VULNERABILITY ANALYTICS & REPORTING
# DevSecOps Engineering and Application Security
# Bloom's Level: Evaluate - L5
# ================================================================

# -------------------------------
# 1. INSTALL / LOAD PACKAGES
# -------------------------------

packages <- c("ggplot2", "dplyr", "tidyr", "scales")

for (p in packages) {
  if (!require(p, character.only = TRUE)) {
    install.packages(p)
    library(p, character.only = TRUE)
  }
}

# -------------------------------
# 2. SET RANDOM SEED
# -------------------------------

set.seed(58)

# -------------------------------
# 3. GENERATE VULNERABILITY DATA
# -------------------------------

n <- 100

vulnerability_data <- data.frame(
  
  Vulnerability_ID = paste0("VUL-", sprintf("%03d", 1:n)),
  
  Application = sample(
    c("Web Application",
      "Mobile API",
      "Payment Service",
      "Authentication Service",
      "Customer Portal"),
    n,
    replace = TRUE
  ),
  
  Asset = sample(
    c("Production Server",
      "Database Server",
      "API Gateway",
      "Web Server",
      "Cloud Container"),
    n,
    replace = TRUE
  ),
  
  Vulnerability_Type = sample(
    c("SQL Injection",
      "XSS",
      "Broken Authentication",
      "Insecure Configuration",
      "Dependency Vulnerability",
      "Access Control",
      "Sensitive Data Exposure",
      "Command Injection"),
    n,
    replace = TRUE
  ),
  
  CVSS = round(runif(n, 2.0, 10.0), 1),
  
  Exploitability = round(runif(n, 1, 10), 1),
  
  Impact = round(runif(n, 1, 10), 1),
  
  Detection_Source = sample(
    c("SAST",
      "DAST",
      "SCA",
      "Penetration Test",
      "Container Scan"),
    n,
    replace = TRUE
  ),
  
  Status = sample(
    c("Open", "In Progress", "Resolved"),
    n,
    replace = TRUE,
    prob = c(0.45, 0.30, 0.25)
  ),
  
  Remediation_Days = sample(
    1:45,
    n,
    replace = TRUE
  )
)

# -------------------------------
# 4. CALCULATE RISK SCORE
# -------------------------------

vulnerability_data$Risk_Score <-
  round(
    (vulnerability_data$CVSS *
       vulnerability_data$Exploitability *
       vulnerability_data$Impact) / 10,
    2
  )

# -------------------------------
# 5. CLASSIFY SEVERITY
# -------------------------------

vulnerability_data$Severity <- cut(
  vulnerability_data$CVSS,
  breaks = c(-Inf, 4.0, 6.9, 8.9, Inf),
  labels = c(
    "Low",
    "Medium",
    "High",
    "Critical"
  )
)

# -------------------------------
# 6. SLA CLASSIFICATION
# -------------------------------

vulnerability_data$SLA_Limit <- ifelse(
  vulnerability_data$Severity == "Critical", 7,
  ifelse(
    vulnerability_data$Severity == "High", 14,
    ifelse(
      vulnerability_data$Severity == "Medium", 30, 45
    )
  )
)

vulnerability_data$SLA_Status <- ifelse(
  vulnerability_data$Remediation_Days >
    vulnerability_data$SLA_Limit &
    vulnerability_data$Status != "Resolved",
  "SLA Breached",
  "Within SLA"
)

# -------------------------------
# 7. DISPLAY DATA
# -------------------------------

cat("\n====================================================\n")
cat("VULNERABILITY DATASET\n")
cat("====================================================\n")

print(head(vulnerability_data, 10))

# -------------------------------
# 8. SUMMARY BY SEVERITY
# -------------------------------

severity_summary <- vulnerability_data %>%
  group_by(Severity) %>%
  summarise(
    Total = n(),
    Open = sum(Status == "Open"),
    In_Progress = sum(Status == "In Progress"),
    Resolved = sum(Status == "Resolved"),
    Average_CVSS = round(mean(CVSS), 2),
    Average_Risk = round(mean(Risk_Score), 2),
    .groups = "drop"
  )

cat("\n====================================================\n")
cat("SEVERITY SUMMARY\n")
cat("====================================================\n")

print(severity_summary)

# -------------------------------
# 9. STATUS ANALYSIS
# -------------------------------

status_summary <- vulnerability_data %>%
  group_by(Status) %>%
  summarise(
    Vulnerabilities = n(),
    Average_Risk = round(mean(Risk_Score), 2),
    .groups = "drop"
  )

cat("\n====================================================\n")
cat("STATUS SUMMARY\n")
cat("====================================================\n")

print(status_summary)

# -------------------------------
# 10. VULNERABILITY TYPE ANALYSIS
# -------------------------------

type_summary <- vulnerability_data %>%
  group_by(Vulnerability_Type) %>%
  summarise(
    Count = n(),
    Average_CVSS = round(mean(CVSS), 2),
    Average_Risk = round(mean(Risk_Score), 2),
    Critical_Count = sum(Severity == "Critical"),
    .groups = "drop"
  ) %>%
  arrange(desc(Average_Risk))

cat("\n====================================================\n")
cat("VULNERABILITY TYPE ANALYSIS\n")
cat("====================================================\n")

print(type_summary)

# -------------------------------
# 11. ASSET RISK ANALYSIS
# -------------------------------

asset_summary <- vulnerability_data %>%
  group_by(Asset) %>%
  summarise(
    Vulnerabilities = n(),
    Critical = sum(Severity == "Critical"),
    High = sum(Severity == "High"),
    Average_Risk = round(mean(Risk_Score), 2),
    .groups = "drop"
  ) %>%
  arrange(desc(Average_Risk))

cat("\n====================================================\n")
cat("ASSET RISK ANALYSIS\n")
cat("====================================================\n")

print(asset_summary)

# -------------------------------
# 12. SLA ANALYSIS
# -------------------------------

sla_summary <- vulnerability_data %>%
  group_by(SLA_Status) %>%
  summarise(
    Count = n(),
    .groups = "drop"
  )

cat("\n====================================================\n")
cat("SLA ANALYSIS\n")
cat("====================================================\n")

print(sla_summary)

# -------------------------------
# 13. TOP 10 HIGH-RISK VULNERABILITIES
# -------------------------------

top_risk <- vulnerability_data %>%
  arrange(desc(Risk_Score)) %>%
  select(
    Vulnerability_ID,
    Application,
    Asset,
    Vulnerability_Type,
    CVSS,
    Severity,
    Exploitability,
    Impact,
    Risk_Score,
    Status,
    SLA_Status
  ) %>%
  head(10)

cat("\n====================================================\n")
cat("TOP 10 HIGH-RISK VULNERABILITIES\n")
cat("====================================================\n")

print(top_risk)

# -------------------------------
# 14. CRITICAL VULNERABILITIES
# -------------------------------

critical_vulnerabilities <- vulnerability_data %>%
  filter(Severity == "Critical") %>%
  arrange(desc(Risk_Score))

cat("\n====================================================\n")
cat("CRITICAL VULNERABILITIES\n")
cat("====================================================\n")

print(critical_vulnerabilities)

# -------------------------------
# 15. SLA BREACH ANALYSIS
# -------------------------------

sla_breaches <- vulnerability_data %>%
  filter(SLA_Status == "SLA Breached") %>%
  arrange(desc(Risk_Score))

cat("\n====================================================\n")
cat("SLA BREACHES\n")
cat("====================================================\n")

print(sla_breaches)

# ================================================================
# 16. GRAPH 1 - VULNERABILITIES BY SEVERITY
# ================================================================

p1 <- ggplot(
  vulnerability_data,
  aes(x = Severity)
) +
  geom_bar() +
  labs(
    title = "Vulnerability Distribution by Severity",
    x = "Severity",
    y = "Number of Vulnerabilities"
  ) +
  theme_minimal() +
  theme(
    plot.title = element_text(
      face = "bold",
      size = 16
    )
  )

print(p1)

# -------------------------------
# SAVE GRAPH
# -------------------------------

ggsave(
  "01_Vulnerability_Severity.png",
  p1,
  width = 8,
  height = 5,
  dpi = 300
)

# ================================================================
# 17. GRAPH 2 - RISK SCORE DISTRIBUTION
# ================================================================

p2 <- ggplot(
  vulnerability_data,
  aes(x = Risk_Score)
) +
  geom_histogram(
    bins = 20
  ) +
  labs(
    title = "Risk Score Distribution",
    x = "Risk Score",
    y = "Frequency"
  ) +
  theme_minimal()

print(p2)

ggsave(
  "02_Risk_Score_Distribution.png",
  p2,
  width = 8,
  height = 5,
  dpi = 300
)

# ================================================================
# 18. GRAPH 3 - VULNERABILITY TYPE
# ================================================================

p3 <- ggplot(
  type_summary,
  aes(
    x = reorder(Vulnerability_Type, Count),
    y = Count
  )
) +
  geom_col() +
  coord_flip() +
  labs(
    title = "Vulnerabilities by Type",
    x = "Vulnerability Type",
    y = "Count"
  ) +
  theme_minimal()

print(p3)

ggsave(
  "03_Vulnerability_Type.png",
  p3,
  width = 9,
  height = 6,
  dpi = 300
)

# ================================================================
# 19. GRAPH 4 - ASSET RISK
# ================================================================

p4 <- ggplot(
  asset_summary,
  aes(
    x = reorder(Asset, Average_Risk),
    y = Average_Risk
  )
) +
  geom_col() +
  coord_flip() +
  labs(
    title = "Average Risk by Asset",
    x = "Asset",
    y = "Average Risk Score"
  ) +
  theme_minimal()

print(p4)

ggsave(
  "04_Asset_Risk.png",
  p4,
  width = 8,
  height = 5,
  dpi = 300
)

# ================================================================
# 20. GRAPH 5 - OPEN / RESOLVED STATUS
# ================================================================

p5 <- ggplot(
  status_summary,
  aes(
    x = Status,
    y = Vulnerabilities
  )
) +
  geom_col() +
  labs(
    title = "Vulnerability Remediation Status",
    x = "Status",
    y = "Number of Vulnerabilities"
  ) +
  theme_minimal()

print(p5)

ggsave(
  "05_Remediation_Status.png",
  p5,
  width = 8,
  height = 5,
  dpi = 300
)

# ================================================================
# 21. GRAPH 6 - CVSS VS RISK
# ================================================================

p6 <- ggplot(
  vulnerability_data,
  aes(
    x = CVSS,
    y = Risk_Score
  )
) +
  geom_point(
    size = 3
  ) +
  geom_smooth(
    method = "lm",
    se = FALSE
  ) +
  labs(
    title = "CVSS Score vs Risk Score",
    x = "CVSS Score",
    y = "Risk Score"
  ) +
  theme_minimal()

print(p6)

ggsave(
  "06_CVSS_vs_Risk.png",
  p6,
  width = 8,
  height = 5,
  dpi = 300
)

# ================================================================
# 22. SECURITY KPIs
# ================================================================

total_vulnerabilities <- nrow(vulnerability_data)

critical_count <- sum(
  vulnerability_data$Severity == "Critical"
)

high_count <- sum(
  vulnerability_data$Severity == "High"
)

open_count <- sum(
  vulnerability_data$Status == "Open"
)

resolved_count <- sum(
  vulnerability_data$Status == "Resolved"
)

sla_breach_count <- sum(
  vulnerability_data$SLA_Status == "SLA Breached"
)

average_risk <- mean(
  vulnerability_data$Risk_Score
)

resolution_rate <- (
  resolved_count /
    total_vulnerabilities
) * 100

sla_compliance <- (
  1 -
    sla_breach_count /
    total_vulnerabilities
) * 100

# -------------------------------
# DISPLAY KPIs
# -------------------------------

cat("\n====================================================\n")
cat("DEVSECOPS VULNERABILITY SECURITY KPIs\n")
cat("====================================================\n")

cat("Total Vulnerabilities :", total_vulnerabilities, "\n")
cat("Critical Vulnerabilities :", critical_count, "\n")
cat("High Vulnerabilities :", high_count, "\n")
cat("Open Vulnerabilities :", open_count, "\n")
cat("Resolved Vulnerabilities :", resolved_count, "\n")
cat("SLA Breaches :", sla_breach_count, "\n")
cat("Average Risk Score :", round(average_risk, 2), "\n")
cat("Resolution Rate :", round(resolution_rate, 2), "%\n")
cat("SLA Compliance :", round(sla_compliance, 2), "%\n")

# ================================================================
# 23. EVALUATION
# ================================================================

cat("\n====================================================\n")
cat("SECURITY EVALUATION\n")
cat("====================================================\n")

if (critical_count > 0) {
  
  cat(
    "WARNING: Critical vulnerabilities detected.\n"
  )
  
  cat(
    "Immediate remediation is required.\n"
  )
  
} else {
  
  cat(
    "No critical vulnerabilities detected.\n"
  )
  
}

if (sla_breach_count > 0) {
  
  cat(
    "SLA evaluation: Remediation SLA breaches detected.\n"
  )
  
} else {
  
  cat(
    "SLA evaluation: All vulnerabilities are within SLA.\n"
  )
  
}

if (resolution_rate < 50) {
  
  cat(
    "Remediation evaluation: Resolution rate is below 50%.\n"
  )
  
} else {
  
  cat(
    "Remediation evaluation: Resolution rate is acceptable.\n"
  )
  
}

# ================================================================
# 24. EXPORT DATA
# ================================================================

write.csv(
  vulnerability_data,
  "Vulnerability_Dataset.csv",
  row.names = FALSE
)

write.csv(
  severity_summary,
  "Severity_Summary.csv",
  row.names = FALSE
)

write.csv(
  type_summary,
  "Vulnerability_Type_Analysis.csv",
  row.names = FALSE
)

write.csv(
  asset_summary,
  "Asset_Risk_Analysis.csv",
  row.names = FALSE
)

write.csv(
  top_risk,
  "Top_10_High_Risk_Vulnerabilities.csv",
  row.names = FALSE
)

write.csv(
  sla_breaches,
  "SLA_Breaches.csv",
  row.names = FALSE
)

# ================================================================
# 25. CREATE FINAL REPORT
# ================================================================

report <- data.frame(
  Metric = c(
    "Total Vulnerabilities",
    "Critical Vulnerabilities",
    "High Vulnerabilities",
    "Open Vulnerabilities",
    "Resolved Vulnerabilities",
    "SLA Breaches",
    "Average Risk Score",
    "Resolution Rate (%)",
    "SLA Compliance (%)"
  ),
  
  Value = c(
    total_vulnerabilities,
    critical_count,
    high_count,
    open_count,
    resolved_count,
    sla_breach_count,
    round(average_risk, 2),
    round(resolution_rate, 2),
    round(sla_compliance, 2)
  )
)

write.csv(
  report,
  "DevSecOps_Vulnerability_Analytics_Report.csv",
  row.names = FALSE
)

# ================================================================
# 26. FINAL MESSAGE
# ================================================================

cat("\n")
cat("====================================================\n")
cat("CO3 PART 3 COMPLETED SUCCESSFULLY\n")
cat("====================================================\n")
cat("Vulnerability Analytics & Reporting\n")
cat("Bloom Level: Evaluate - L5\n")
cat("\nGenerated Files:\n")
cat("1. Vulnerability_Dataset.csv\n")
cat("2. Severity_Summary.csv\n")
cat("3. Vulnerability_Type_Analysis.csv\n")
cat("4. Asset_Risk_Analysis.csv\n")
cat("5. Top_10_High_Risk_Vulnerabilities.csv\n")
cat("6. SLA_Breaches.csv\n")
cat("7. DevSecOps_Vulnerability_Analytics_Report.csv\n")
cat("\nGenerated Graphs:\n")
cat("1. 01_Vulnerability_Severity.png\n")
cat("2. 02_Risk_Score_Distribution.png\n")
cat("3. 03_Vulnerability_Type.png\n")
cat("4. 04_Asset_Risk.png\n")
cat("5. 05_Remediation_Status.png\n")
cat("6. 06_CVSS_vs_Risk.png\n")
cat("\n====================================================\n")