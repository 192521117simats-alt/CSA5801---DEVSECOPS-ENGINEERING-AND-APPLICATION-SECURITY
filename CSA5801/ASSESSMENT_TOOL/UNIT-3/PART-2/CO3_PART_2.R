# ================================================================
# CO3 PART 2
# DAST & SCA SECURITY VERIFICATION SIMULATION
# ================================================================

# ------------------------------------------------
# 1. INSTALL PACKAGES
# ------------------------------------------------
# Run these only once if packages are not installed

# install.packages("ggplot2")
# install.packages("dplyr")
# install.packages("tidyr")

library(ggplot2)
library(dplyr)
library(tidyr)


# ================================================================
# 2. PROJECT INFORMATION
# ================================================================

cat("\n")
cat("================================================================\n")
cat("        CO3 PART 2 - DAST & SCA SIMULATION\n")
cat("================================================================\n")
cat("Subject : DevSecOps Engineering and Application Security\n")
cat("Activity: DAST & Software Composition Analysis Simulation\n")
cat("Language: R Programming\n")
cat("================================================================\n\n")


# ================================================================
# 3. DAST SIMULATION
# ================================================================

cat("================================================================\n")
cat("                  DAST SIMULATION\n")
cat("================================================================\n\n")

# ------------------------------------------------
# DAST = Dynamic Application Security Testing
# Simulates testing a running web application
# ------------------------------------------------

dast_endpoints <- data.frame(
  
  Endpoint_ID = paste0(
    "API-",
    sprintf("%02d", 1:15)
  ),
  
  Endpoint = c(
    "/login",
    "/register",
    "/users",
    "/profile",
    "/search",
    "/products",
    "/orders",
    "/payment",
    "/upload",
    "/admin",
    "/reports",
    "/api/token",
    "/comments",
    "/feedback",
    "/logout"
  ),
  
  Method = c(
    "POST",
    "POST",
    "GET",
    "GET",
    "GET",
    "GET",
    "POST",
    "POST",
    "POST",
    "GET",
    "GET",
    "POST",
    "POST",
    "POST",
    "POST"
  ),
  
  Authentication = c(
    "Required",
    "No",
    "Required",
    "Required",
    "No",
    "No",
    "Required",
    "Required",
    "Required",
    "Required",
    "Required",
    "Required",
    "No",
    "No",
    "Required"
  )
)

cat("APPLICATION ENDPOINTS\n")
cat("----------------------------------------------------------------\n")

print(dast_endpoints)


# ================================================================
# 4. DAST VULNERABILITY DATABASE
# ================================================================

dast_vulnerabilities <- data.frame(
  
  Vulnerability_ID = paste0(
    "DAST-",
    sprintf("%02d", 1:12)
  ),
  
  Vulnerability = c(
    "SQL Injection",
    "Cross-Site Scripting",
    "Broken Authentication",
    "Insecure Direct Object Reference",
    "Security Misconfiguration",
    "Missing Security Headers",
    "Session Fixation",
    "Open Redirect",
    "Information Disclosure",
    "Command Injection",
    "CSRF",
    "Directory Traversal"
  ),
  
  Severity = c(
    "Critical",
    "High",
    "High",
    "High",
    "Medium",
    "Low",
    "High",
    "Medium",
    "Medium",
    "Critical",
    "High",
    "High"
  ),
  
  OWASP = c(
    "A03: Injection",
    "A03: Injection",
    "A07: Authentication",
    "A01: Access Control",
    "A05: Misconfiguration",
    "A05: Misconfiguration",
    "A07: Authentication",
    "A01: Access Control",
    "A01: Access Control",
    "A03: Injection",
    "A01: Access Control",
    "A01: Access Control"
  ),
  
  Risk_Score = c(
    9.8,
    8.2,
    8.5,
    8.0,
    6.1,
    3.5,
    7.8,
    5.7,
    5.9,
    9.4,
    7.5,
    7.9
  )
)

cat("\n")
cat("DAST VULNERABILITY RULES\n")
cat("----------------------------------------------------------------\n")

print(dast_vulnerabilities)


# ================================================================
# 5. GENERATE DAST FINDINGS
# ================================================================

set.seed(2026)

dast_selected_endpoint <- sample(
  1:nrow(dast_endpoints),
  size = 35,
  replace = TRUE
)

dast_selected_vulnerability <- sample(
  1:nrow(dast_vulnerabilities),
  size = 35,
  replace = TRUE
)

dast_findings <- data.frame(
  
  Finding_ID = paste0(
    "DAST-F",
    sprintf("%03d", 1:35)
  ),
  
  Endpoint =
    dast_endpoints$Endpoint[
      dast_selected_endpoint
    ],
  
  Method =
    dast_endpoints$Method[
      dast_selected_endpoint
    ],
  
  Vulnerability =
    dast_vulnerabilities$Vulnerability[
      dast_selected_vulnerability
    ],
  
  Severity =
    dast_vulnerabilities$Severity[
      dast_selected_vulnerability
    ],
  
  OWASP =
    dast_vulnerabilities$OWASP[
      dast_selected_vulnerability
    ],
  
  Risk_Score =
    dast_vulnerabilities$Risk_Score[
      dast_selected_vulnerability
    ]
)


# ================================================================
# 6. DAST ANALYSIS
# ================================================================

cat("\n")
cat("================================================================\n")
cat("                  DAST FINDINGS\n")
cat("================================================================\n")

print(dast_findings)


# DAST severity count

dast_severity <- dast_findings %>%
  
  count(Severity) %>%
  
  mutate(
    Percentage =
      round(
        n / sum(n) * 100,
        2
      )
  )

dast_severity$Severity <- factor(
  dast_severity$Severity,
  levels = c(
    "Critical",
    "High",
    "Medium",
    "Low"
  )
)

dast_severity <- dast_severity %>%
  arrange(Severity)


# ================================================================
# 7. DAST SECURITY ANALYSIS
# ================================================================

dast_critical <- sum(
  dast_findings$Severity == "Critical"
)

dast_high <- sum(
  dast_findings$Severity == "High"
)

dast_medium <- sum(
  dast_findings$Severity == "Medium"
)

dast_low <- sum(
  dast_findings$Severity == "Low"
)

dast_average_risk <- mean(
  dast_findings$Risk_Score
)

dast_maximum_risk <- max(
  dast_findings$Risk_Score
)


# ================================================================
# 8. SCA SIMULATION
# ================================================================

cat("\n\n")
cat("================================================================\n")
cat("                  SCA SIMULATION\n")
cat("================================================================\n\n")

# ------------------------------------------------
# SCA = Software Composition Analysis
# Simulates scanning third-party dependencies
# ------------------------------------------------

dependencies <- data.frame(
  
  Package_ID = paste0(
    "PKG-",
    sprintf("%02d", 1:18)
  ),
  
  Package = c(
    "express",
    "lodash",
    "axios",
    "jsonwebtoken",
    "bcrypt",
    "mongoose",
    "react",
    "jquery",
    "bootstrap",
    "moment",
    "log4j",
    "spring-core",
    "jackson",
    "requests",
    "flask",
    "numpy",
    "openssl",
    "sqlite"
  ),
  
  Version = c(
    "4.18.2",
    "4.17.19",
    "1.6.0",
    "8.5.1",
    "5.1.0",
    "6.9.1",
    "18.2.0",
    "3.6.0",
    "5.3.2",
    "2.29.4",
    "2.14.1",
    "5.3.27",
    "2.13.4",
    "2.31.0",
    "2.3.2",
    "1.24.0",
    "3.0",
    "3.40"
  ),
  
  License = c(
    "MIT",
    "MIT",
    "MIT",
    "MIT",
    "MIT",
    "MIT",
    "MIT",
    "MIT",
    "MIT",
    "MIT",
    "Apache-2.0",
    "Apache-2.0",
    "Apache-2.0",
    "Apache-2.0",
    "BSD",
    "BSD",
    "Apache-2.0",
    "Public Domain"
  )
)


cat("THIRD-PARTY DEPENDENCIES\n")
cat("----------------------------------------------------------------\n")

print(dependencies)


# ================================================================
# 9. SCA VULNERABILITY DATABASE
# ================================================================

sca_vulnerabilities <- data.frame(
  
  Vulnerability_ID = paste0(
    "CVE-2026-",
    sprintf("%04d", 101:112)
  ),
  
  Package = c(
    "lodash",
    "axios",
    "jsonwebtoken",
    "jquery",
    "moment",
    "log4j",
    "spring-core",
    "jackson",
    "requests",
    "flask",
    "openssl",
    "sqlite"
  ),
  
  Vulnerability = c(
    "Prototype Pollution",
    "SSRF Vulnerability",
    "Weak Token Validation",
    "Cross-Site Scripting",
    "Path Manipulation",
    "Remote Code Execution",
    "Authentication Bypass",
    "Deserialization Issue",
    "Certificate Validation Issue",
    "Session Security Issue",
    "Memory Corruption",
    "Input Validation Issue"
  ),
  
  Severity = c(
    "High",
    "Critical",
    "High",
    "High",
    "Medium",
    "Critical",
    "Critical",
    "High",
    "Medium",
    "Medium",
    "High",
    "Low"
  ),
  
  CVSS = c(
    8.1,
    9.1,
    7.5,
    8.0,
    6.2,
    9.8,
    9.0,
    8.2,
    5.8,
    6.4,
    7.9,
    3.5
  ),
  
  Fix = c(
    "Upgrade package",
    "Upgrade package",
    "Upgrade package",
    "Upgrade package",
    "Upgrade package",
    "Upgrade package",
    "Upgrade package",
    "Upgrade package",
    "Upgrade package",
    "Upgrade package",
    "Upgrade package",
    "Upgrade package"
  )
)

cat("\n")
cat("SCA VULNERABILITY DATABASE\n")
cat("----------------------------------------------------------------\n")

print(sca_vulnerabilities)


# ================================================================
# 10. SCA ANALYSIS
# ================================================================

cat("\n")
cat("================================================================\n")
cat("                  SCA FINDINGS\n")
cat("================================================================\n")

print(sca_vulnerabilities)


sca_critical <- sum(
  sca_vulnerabilities$Severity == "Critical"
)

sca_high <- sum(
  sca_vulnerabilities$Severity == "High"
)

sca_medium <- sum(
  sca_vulnerabilities$Severity == "Medium"
)

sca_low <- sum(
  sca_vulnerabilities$Severity == "Low"
)

sca_average_cvss <- mean(
  sca_vulnerabilities$CVSS
)

sca_maximum_cvss <- max(
  sca_vulnerabilities$CVSS
)


# ================================================================
# 11. COMBINED SECURITY ANALYSIS
# ================================================================

total_critical <-
  dast_critical + sca_critical

total_high <-
  dast_high + sca_high

total_medium <-
  dast_medium + sca_medium

total_low <-
  dast_low + sca_low

total_findings <-
  nrow(dast_findings) +
  nrow(sca_vulnerabilities)


# ================================================================
# 12. SECURITY GATE
# ================================================================

if (
  total_critical > 0 |
  total_high > 0
) {
  
  security_status <- "FAILED"
  
  security_decision <-
    "Critical/High vulnerabilities require remediation."
  
} else {
  
  security_status <- "PASSED"
  
  security_decision <-
    "No Critical/High vulnerabilities detected."
}


# ================================================================
# 13. FINAL SUMMARY TABLE
# ================================================================

final_summary <- data.frame(
  
  Category = c(
    "DAST Findings",
    "SCA Findings",
    "Total Findings",
    "Critical",
    "High",
    "Medium",
    "Low",
    "DAST Average Risk",
    "DAST Maximum Risk",
    "SCA Average CVSS",
    "SCA Maximum CVSS",
    "Security Gate"
  ),
  
  Result = c(
    
    nrow(dast_findings),
    
    nrow(sca_vulnerabilities),
    
    total_findings,
    
    total_critical,
    
    total_high,
    
    total_medium,
    
    total_low,
    
    round(
      dast_average_risk,
      2
    ),
    
    round(
      dast_maximum_risk,
      2
    ),
    
    round(
      sca_average_cvss,
      2
    ),
    
    round(
      sca_maximum_cvss,
      2
    ),
    
    security_status
  )
)


cat("\n")
cat("================================================================\n")
cat("             DAST & SCA FINAL SUMMARY\n")
cat("================================================================\n")

print(final_summary)


# ================================================================
# 14. DAST SEVERITY GRAPH
# ================================================================

p1 <- ggplot(
  dast_severity,
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
      "DAST Vulnerability Severity Analysis",
    
    subtitle =
      "Dynamic Application Security Testing",
    
    x = "Severity",
    
    y = "Number of Findings"
  ) +
  
  theme_minimal(
    base_size = 14
  ) +
  
  theme(
    plot.title =
      element_text(
        face = "bold",
        size = 18
      ),
    
    legend.position = "none"
  )

print(p1)


# ================================================================
# 15. SCA SEVERITY GRAPH
# ================================================================

sca_severity <- sca_vulnerabilities %>%
  
  count(Severity)

sca_severity$Severity <- factor(
  sca_severity$Severity,
  levels = c(
    "Critical",
    "High",
    "Medium",
    "Low"
  )
)

p2 <- ggplot(
  sca_severity,
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
      "SCA Dependency Vulnerability Analysis",
    
    subtitle =
      "Software Composition Analysis",
    
    x = "Severity",
    
    y = "Vulnerable Dependencies"
  ) +
  
  theme_minimal(
    base_size = 14
  ) +
  
  theme(
    plot.title =
      element_text(
        face = "bold",
        size = 18
      ),
    
    legend.position = "none"
  )

print(p2)


# ================================================================
# 16. DAST vs SCA COMPARISON
# ================================================================

comparison_data <- data.frame(
  
  Testing_Method = c(
    "DAST",
    "SCA"
  ),
  
  Findings = c(
    nrow(dast_findings),
    nrow(sca_vulnerabilities)
  ),
  
  Critical = c(
    dast_critical,
    sca_critical
  ),
  
  High = c(
    dast_high,
    sca_high
  ),
  
  Medium = c(
    dast_medium,
    sca_medium
  ),
  
  Low = c(
    dast_low,
    sca_low
  )
)

print(comparison_data)


# Convert to long format

comparison_long <- comparison_data %>%
  
  pivot_longer(
    cols =
      c(
        Critical,
        High,
        Medium,
        Low
      ),
    
    names_to = "Severity",
    
    values_to = "Count"
  )


p3 <- ggplot(
  comparison_long,
  aes(
    x = Testing_Method,
    y = Count,
    fill = Severity
  )
) +
  
  geom_col(
    position = "dodge"
  ) +
  
  geom_text(
    aes(
      label = Count
    ),
    
    position =
      position_dodge(
        width = 0.9
      ),
    
    vjust = -0.3,
    
    size = 4
  ) +
  
  labs(
    title =
      "DAST vs SCA Security Comparison",
    
    x =
      "Security Testing Method",
    
    y =
      "Number of Findings"
  ) +
  
  theme_minimal(
    base_size = 14
  )

print(p3)


# ================================================================
# 17. CVSS SCORE GRAPH
# ================================================================

p4 <- ggplot(
  sca_vulnerabilities,
  aes(
    x = reorder(
      Package,
      CVSS
    ),
    
    y = CVSS
  )
) +
  
  geom_col(
    fill = "steelblue"
  ) +
  
  geom_text(
    aes(
      label =
        round(
          CVSS,
          1
        )
    ),
    
    vjust = -0.3,
    
    size = 4
  ) +
  
  labs(
    title =
      "SCA Package Risk – CVSS Score",
    
    x =
      "Dependency",
    
    y =
      "CVSS Score"
  ) +
  
  ylim(
    0,
    10
  ) +
  
  theme_minimal(
    base_size = 14
  ) +
  
  theme(
    axis.text.x =
      element_text(
        angle = 45,
        hjust = 1
      )
  )

print(p4)


# ================================================================
# 18. EXPORT RESULTS
# ================================================================

write.csv(
  dast_findings,
  "CO3_PART2_DAST_Findings.csv",
  row.names = FALSE
)

write.csv(
  sca_vulnerabilities,
  "CO3_PART2_SCA_Findings.csv",
  row.names = FALSE
)

write.csv(
  final_summary,
  "CO3_PART2_DAST_SCA_Summary.csv",
  row.names = FALSE
)

write.csv(
  comparison_data,
  "CO3_PART2_DAST_SCA_Comparison.csv",
  row.names = FALSE
)


# ================================================================
# 19. SAVE GRAPHS
# ================================================================

ggsave(
  "CO3_PART2_DAST_Severity.png",
  p1,
  width = 10,
  height = 6,
  dpi = 300
)

ggsave(
  "CO3_PART2_SCA_Severity.png",
  p2,
  width = 10,
  height = 6,
  dpi = 300
)

ggsave(
  "CO3_PART2_DAST_vs_SCA.png",
  p3,
  width = 10,
  height = 6,
  dpi = 300
)

ggsave(
  "CO3_PART2_SCA_CVSS.png",
  p4,
  width = 11,
  height = 7,
  dpi = 300
)


# ================================================================
# 20. FINAL REPORT
# ================================================================

cat("\n\n")
cat("================================================================\n")
cat("              FINAL CO3 PART 2 REPORT\n")
cat("================================================================\n")

cat("\nDAST Testing")
cat("\n-------------")
cat("\nEndpoints Tested :", nrow(dast_endpoints))
cat("\nDAST Findings    :", nrow(dast_findings))
cat("\nCritical         :", dast_critical)
cat("\nHigh             :", dast_high)
cat("\nMedium           :", dast_medium)
cat("\nLow              :", dast_low)
cat("\nAverage Risk     :", round(dast_average_risk, 2))

cat("\n\nSCA Testing")
cat("\n-----------")
cat("\nDependencies Scanned :", nrow(dependencies))
cat("\nVulnerable Packages  :", nrow(sca_vulnerabilities))
cat("\nCritical             :", sca_critical)
cat("\nHigh                 :", sca_high)
cat("\nMedium               :", sca_medium)
cat("\nLow                  :", sca_low)
cat("\nAverage CVSS         :", round(sca_average_cvss, 2))

cat("\n\nCombined Security Analysis")
cat("\n--------------------------")
cat("\nTotal Findings :", total_findings)
cat("\nCritical       :", total_critical)
cat("\nHigh           :", total_high)
cat("\nMedium         :", total_medium)
cat("\nLow            :", total_low)

cat("\n\nSECURITY GATE :", security_status)

cat("\n\nRecommendation:")
cat("\n", security_decision)

cat("\n\n================================================================\n")
cat("            CO3 PART 2 COMPLETED SUCCESSFULLY\n")
cat("================================================================\n")