# ================================================================
# CO3 PART 1
# STATIC APPLICATION SECURITY TESTING (SAST) SIMULATION
# ================================================================

# ------------------------------------------------
# 1. LOAD REQUIRED LIBRARIES
# ------------------------------------------------

library(ggplot2)
library(dplyr)
library(tidyr)
library(scales)

# ------------------------------------------------
# 2. PROJECT INFORMATION
# ------------------------------------------------

cat("\n")
cat("============================================================\n")
cat("       CO3 PART 1 - SAST SECURITY SIMULATION\n")
cat("============================================================\n")
cat("Subject : DevSecOps Engineering and Application Security\n")
cat("Activity: Static Application Security Testing (SAST)\n")
cat("Language: R Programming\n")
cat("============================================================\n\n")


# ------------------------------------------------
# 3. CREATE SYNTHETIC SOURCE CODE DATA
# ------------------------------------------------
# Simulates files scanned by a SAST tool

source_files <- data.frame(
  File_ID = 1:15,
  
  File_Name = c(
    "login.py",
    "database.py",
    "auth.py",
    "payment.py",
    "user.py",
    "api.py",
    "config.py",
    "admin.py",
    "upload.py",
    "search.py",
    "session.py",
    "report.py",
    "email.py",
    "server.py",
    "utils.py"
  ),
  
  Language = c(
    "Python",
    "Python",
    "Python",
    "Python",
    "Python",
    "Python",
    "Python",
    "Python",
    "Python",
    "Python",
    "Python",
    "Python",
    "Python",
    "Python",
    "Python"
  ),
  
  Lines_of_Code = c(
    245, 380, 310, 425, 190,
    510, 150, 275, 330, 290,
    365, 220, 180, 450, 205
  )
)

cat("SOURCE CODE FILES SCANNED\n")
cat("------------------------------------------------------------\n")
print(source_files)


# ------------------------------------------------
# 4. SAST VULNERABILITY DATABASE
# ------------------------------------------------

vulnerability_types <- data.frame(
  
  Vulnerability_ID = paste0("V", sprintf("%02d", 1:15)),
  
  Vulnerability = c(
    "SQL Injection",
    "Hardcoded Password",
    "Cross-Site Scripting (XSS)",
    "Weak Authentication",
    "Command Injection",
    "Insecure File Upload",
    "Unvalidated Input",
    "Insecure Cryptography",
    "Information Disclosure",
    "Debug Mode Enabled",
    "Path Traversal",
    "Missing Access Control",
    "Weak Session Management",
    "Insecure API Endpoint",
    "Sensitive Data Exposure"
  ),
  
  Severity = c(
    "Critical",
    "High",
    "High",
    "High",
    "Critical",
    "High",
    "Medium",
    "Medium",
    "Medium",
    "Low",
    "High",
    "Critical",
    "High",
    "Medium",
    "High"
  ),
  
  CWE = c(
    "CWE-89",
    "CWE-798",
    "CWE-79",
    "CWE-287",
    "CWE-78",
    "CWE-434",
    "CWE-20",
    "CWE-327",
    "CWE-200",
    "CWE-489",
    "CWE-22",
    "CWE-862",
    "CWE-613",
    "CWE-918",
    "CWE-200"
  ),
  
  Risk_Score = c(
    9.8, 8.5, 8.2, 8.0, 9.1,
    8.1, 6.5, 6.8, 5.9, 3.1,
    7.8, 9.0, 7.5, 6.7, 8.3
  )
)

cat("\n")
cat("SAST VULNERABILITY RULE DATABASE\n")
cat("------------------------------------------------------------\n")
print(vulnerability_types)


# ------------------------------------------------
# 5. SIMULATE SAST SCAN
# ------------------------------------------------

set.seed(58)

# Randomly select files for vulnerability findings
selected_files <- sample(
  source_files$File_Name,
  size = 30,
  replace = TRUE
)

# Randomly select vulnerabilities
selected_vulnerabilities <- sample(
  1:nrow(vulnerability_types),
  size = 30,
  replace = TRUE
)

# Create findings
sast_findings <- data.frame(
  Finding_ID = paste0(
    "SAST-",
    sprintf("%03d", 1:30)
  ),
  
  File_Name = selected_files,
  
  Vulnerability_ID =
    vulnerability_types$Vulnerability_ID[
      selected_vulnerabilities
    ],
  
  Vulnerability =
    vulnerability_types$Vulnerability[
      selected_vulnerabilities
    ],
  
  Severity =
    vulnerability_types$Severity[
      selected_vulnerabilities
    ],
  
  CWE =
    vulnerability_types$CWE[
      selected_vulnerabilities
    ],
  
  Risk_Score =
    vulnerability_types$Risk_Score[
      selected_vulnerabilities
    ]
)

# Add simulated line numbers
sast_findings$Line_Number <- sample(
  10:450,
  nrow(sast_findings),
  replace = TRUE
)

# Add status
sast_findings$Status <- ifelse(
  sast_findings$Severity %in%
    c("Critical", "High"),
  "Open - Immediate Fix",
  "Open - Review"
)

cat("\n")
cat("============================================================\n")
cat("              SAST SCAN COMPLETED\n")
cat("============================================================\n")

cat("\nTotal Source Files Scanned :", nrow(source_files))
cat("\nTotal Lines of Code       :",
    format(sum(source_files$Lines_of_Code), big.mark = ","))
cat("\nTotal Findings            :", nrow(sast_findings))
cat("\n")


# ------------------------------------------------
# 6. DISPLAY SAST FINDINGS
# ------------------------------------------------

cat("\n")
cat("SAST FINDINGS\n")
cat("------------------------------------------------------------\n")

print(sast_findings)


# ------------------------------------------------
# 7. SEVERITY ANALYSIS
# ------------------------------------------------

severity_summary <- sast_findings %>%
  
  count(Severity) %>%
  
  mutate(
    Percentage =
      round(
        n / sum(n) * 100,
        2
      )
  )

# Maintain correct security order
severity_summary$Severity <- factor(
  severity_summary$Severity,
  levels = c(
    "Critical",
    "High",
    "Medium",
    "Low"
  )
)

severity_summary <- severity_summary %>%
  arrange(Severity)

cat("\n")
cat("============================================================\n")
cat("              SEVERITY SUMMARY\n")
cat("============================================================\n")

print(severity_summary)


# ------------------------------------------------
# 8. VULNERABILITY TYPE SUMMARY
# ------------------------------------------------

vulnerability_summary <- sast_findings %>%
  
  count(Vulnerability, Severity) %>%
  
  arrange(desc(n))

cat("\n")
cat("============================================================\n")
cat("          VULNERABILITY TYPE SUMMARY\n")
cat("============================================================\n")

print(vulnerability_summary)


# ------------------------------------------------
# 9. FILE-WISE VULNERABILITY SUMMARY
# ------------------------------------------------

file_summary <- sast_findings %>%
  
  count(File_Name, name = "Vulnerabilities") %>%
  
  arrange(desc(Vulnerabilities))

cat("\n")
cat("============================================================\n")
cat("             FILE-WISE FINDINGS\n")
cat("============================================================\n")

print(file_summary)


# ------------------------------------------------
# 10. CRITICAL AND HIGH RISK FINDINGS
# ------------------------------------------------

high_risk <- sast_findings %>%
  
  filter(
    Severity %in%
      c("Critical", "High")
  ) %>%
  
  arrange(
    desc(Risk_Score)
  )

cat("\n")
cat("============================================================\n")
cat("       CRITICAL / HIGH RISK VULNERABILITIES\n")
cat("============================================================\n")

print(high_risk)


# ------------------------------------------------
# 11. SECURITY RISK SCORE ANALYSIS
# ------------------------------------------------

average_risk <- mean(
  sast_findings$Risk_Score
)

maximum_risk <- max(
  sast_findings$Risk_Score
)

critical_count <- sum(
  sast_findings$Severity == "Critical"
)

high_count <- sum(
  sast_findings$Severity == "High"
)

medium_count <- sum(
  sast_findings$Severity == "Medium"
)

low_count <- sum(
  sast_findings$Severity == "Low"
)

cat("\n")
cat("============================================================\n")
cat("              RISK ANALYSIS\n")
cat("============================================================\n")

cat("\nAverage Risk Score :", round(average_risk, 2))
cat("\nMaximum Risk Score :", round(maximum_risk, 2))
cat("\nCritical Findings  :", critical_count)
cat("\nHigh Findings      :", high_count)
cat("\nMedium Findings    :", medium_count)
cat("\nLow Findings       :", low_count)
cat("\n")


# ------------------------------------------------
# 12. SECURITY GATE DECISION
# ------------------------------------------------
# DevSecOps security gate:
# Critical or High vulnerabilities cause failure.

if (
  critical_count > 0 |
  high_count > 0
) {
  
  security_status <- "FAILED"
  
  security_message <-
    "Critical/High vulnerabilities detected. Fix before deployment."
  
} else {
  
  security_status <- "PASSED"
  
  security_message <-
    "No Critical/High vulnerabilities detected."
}


cat("\n")
cat("============================================================\n")
cat("                 SECURITY GATE\n")
cat("============================================================\n")

cat("\nSecurity Status :", security_status)
cat("\nDecision        :", security_message)
cat("\n")


# ------------------------------------------------
# 13. SAST SUMMARY TABLE
# ------------------------------------------------

summary_table <- data.frame(
  
  Metric = c(
    "Files Scanned",
    "Lines of Code",
    "Total Findings",
    "Critical",
    "High",
    "Medium",
    "Low",
    "Average Risk Score",
    "Maximum Risk Score",
    "Security Gate"
  ),
  
  Result = c(
    nrow(source_files),
    format(
      sum(source_files$Lines_of_Code),
      big.mark = ","
    ),
    nrow(sast_findings),
    critical_count,
    high_count,
    medium_count,
    low_count,
    round(average_risk, 2),
    round(maximum_risk, 2),
    security_status
  )
)

cat("\n")
cat("============================================================\n")
cat("               SAST FINAL SUMMARY TABLE\n")
cat("============================================================\n")

print(summary_table)


# ------------------------------------------------
# 14. GRAPH 1 - SEVERITY DISTRIBUTION
# ------------------------------------------------

p1 <- ggplot(
  severity_summary,
  aes(
    x = Severity,
    y = n,
    fill = Severity
  )
) +
  
  geom_col(
    width = 0.65
  ) +
  
  geom_text(
    aes(
      label = n
    ),
    vjust = -0.4,
    size = 5,
    fontface = "bold"
  ) +
  
  labs(
    title =
      "SAST Vulnerability Severity Distribution",
    
    subtitle =
      "Static Application Security Testing Simulation",
    
    x = "Severity",
    
    y = "Number of Vulnerabilities"
  ) +
  
  theme_minimal(base_size = 14) +
  
  theme(
    plot.title =
      element_text(
        face = "bold",
        size = 18
      ),
    
    plot.subtitle =
      element_text(
        size = 12
      ),
    
    legend.position = "none"
  )

print(p1)


# ------------------------------------------------
# 15. GRAPH 2 - VULNERABILITY TYPES
# ------------------------------------------------

p2 <- sast_findings %>%
  
  count(Vulnerability) %>%
  
  arrange(n) %>%
  
  ggplot(
    aes(
      x = n,
      y = reorder(Vulnerability, n)
    )
  ) +
  
  geom_col(
    fill = "steelblue"
  ) +
  
  geom_text(
    aes(
      label = n
    ),
    hjust = -0.3,
    size = 4
  ) +
  
  labs(
    title =
      "Vulnerabilities Detected by SAST",
    
    x =
      "Number of Findings",
    
    y =
      "Vulnerability Type"
  ) +
  
  theme_minimal(
    base_size = 13
  )

print(p2)


# ------------------------------------------------
# 16. GRAPH 3 - FILE-WISE FINDINGS
# ------------------------------------------------

p3 <- file_summary %>%
  
  ggplot(
    aes(
      x = reorder(
        File_Name,
        Vulnerabilities
      ),
      
      y = Vulnerabilities
    )
  ) +
  
  geom_col(
    fill = "darkorange"
  ) +
  
  geom_text(
    aes(
      label = Vulnerabilities
    ),
    vjust = -0.3,
    size = 3.5
  ) +
  
  labs(
    title =
      "File-Wise SAST Findings",
    
    x =
      "Source File",
    
    y =
      "Number of Findings"
  ) +
  
  theme_minimal(
    base_size = 13
  ) +
  
  theme(
    axis.text.x =
      element_text(
        angle = 45,
        hjust = 1
      )
  )

print(p3)


# ------------------------------------------------
# 17. GRAPH 4 - RISK SCORE DISTRIBUTION
# ------------------------------------------------

p4 <- ggplot(
  sast_findings,
  aes(
    x = Risk_Score
  )
) +
  
  geom_histogram(
    bins = 10,
    fill = "firebrick",
    color = "white"
  ) +
  
  labs(
    title =
      "SAST Risk Score Distribution",
    
    x =
      "Risk Score",
    
    y =
      "Number of Findings"
  ) +
  
  theme_minimal(
    base_size = 14
  )

print(p4)


# ------------------------------------------------
# 18. EXPORT DATA TO CSV
# ------------------------------------------------

write.csv(
  sast_findings,
  "CO3_PART1_SAST_Findings.csv",
  row.names = FALSE
)

write.csv(
  summary_table,
  "CO3_PART1_SAST_Summary.csv",
  row.names = FALSE
)

write.csv(
  severity_summary,
  "CO3_PART1_Severity_Summary.csv",
  row.names = FALSE
)


# ------------------------------------------------
# 19. SAVE GRAPHS
# ------------------------------------------------

ggsave(
  "CO3_PART1_Severity_Distribution.png",
  p1,
  width = 10,
  height = 6,
  dpi = 300
)

ggsave(
  "CO3_PART1_Vulnerability_Types.png",
  p2,
  width = 11,
  height = 7,
  dpi = 300
)

ggsave(
  "CO3_PART1_File_Wise_Findings.png",
  p3,
  width = 11,
  height = 7,
  dpi = 300
)

ggsave(
  "CO3_PART1_Risk_Distribution.png",
  p4,
  width = 10,
  height = 6,
  dpi = 300
)


# ------------------------------------------------
# 20. FINAL REPORT
# ------------------------------------------------

cat("\n\n")
cat("============================================================\n")
cat("             FINAL SAST SECURITY REPORT\n")
cat("============================================================\n")

cat("\nApplication Scan       : COMPLETED")
cat("\nSource Files Scanned   :", nrow(source_files))

cat(
  "\nTotal Lines Scanned    :",
  format(
    sum(source_files$Lines_of_Code),
    big.mark = ","
  )
)

cat("\nTotal Vulnerabilities  :", nrow(sast_findings))

cat("\n\nSeverity Distribution:")
cat("\n  Critical :", critical_count)
cat("\n  High     :", high_count)
cat("\n  Medium   :", medium_count)
cat("\n  Low      :", low_count)

cat(
  "\n\nAverage Risk Score     :",
  round(average_risk, 2)
)

cat(
  "\nMaximum Risk Score     :",
  round(maximum_risk, 2)
)

cat("\n\nSECURITY GATE          :", security_status)

cat("\n\nRecommendation:")
cat(
  "\n",
  security_message
)

cat("\n\n============================================================\n")
cat("              CO3 PART 1 COMPLETED\n")
cat("============================================================\n")