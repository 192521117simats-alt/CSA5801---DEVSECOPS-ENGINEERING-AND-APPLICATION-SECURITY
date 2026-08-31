rm(list = ls())

# ============================================================

# GATEKEEPERX

# COLOURFUL PROFESSIONAL DEVSECOPS SECURITY ARCHITECTURE

# ============================================================

# ============================================================

# 1. OUTPUT FOLDER

# ============================================================

output_dir <- "GatekeeperX_Colourful_Architecture"

if (!dir.exists(output_dir)) {
  dir.create(output_dir, recursive = TRUE)
}

# ============================================================

# 2. DRAW SYSTEM CONTAINER

# ============================================================

draw_container <- function(
    x1,
    y1,
    x2,
    y2,
    title,
    fill,
    header_colour
) {
  
  # Main container
  
  rect(
    x1,
    y1,
    x2,
    y2,
    col = fill,
    border = header_colour,
    lwd = 3
  )
  
  # Container header
  
  rect(
    x1,
    y2 - 0.9,
    x2,
    y2,
    col = header_colour,
    border = header_colour
  )
  
  # Header text
  
  text(
    (x1 + x2) / 2,
    y2 - 0.45,
    title,
    col = "white",
    cex = 1.25,
    font = 2
  )
}

# ============================================================

# 3. DRAW COMPONENT BOX

# ============================================================

draw_box <- function(
    x,
    y,
    width,
    height,
    title,
    subtitle,
    fill,
    border,
    title_size = 1.05,
    subtitle_size = 0.75
) {
  
  # Shadow
  
  rect(
    x - width / 2 + 0.12,
    y - height / 2 - 0.12,
    x + width / 2 + 0.12,
    y + height / 2 - 0.12,
    col = "gray80",
    border = NA
  )
  
  # Main box
  
  rect(
    x - width / 2,
    y - height / 2,
    x + width / 2,
    y + height / 2,
    col = fill,
    border = border,
    lwd = 3
  )
  
  # Title
  
  text(
    x,
    y + 0.32,
    title,
    cex = title_size,
    font = 2,
    col = "black"
  )
  
  # Subtitle
  
  text(
    x,
    y - 0.35,
    subtitle,
    cex = subtitle_size,
    font = 1,
    col = "gray20"
  )
}

# ============================================================

# 4. DRAW ARROW

# ============================================================

draw_arrow <- function(
    x1,
    y1,
    x2,
    y2,
    arrow_colour = "gray25",
    arrow_width = 3
) {
  
  arrows(
    x0 = x1,
    y0 = y1,
    x1 = x2,
    y1 = y2,
    length = 0.12,
    lwd = arrow_width,
    col = arrow_colour
  )
}

# ============================================================

# 5. CREATE HIGH RESOLUTION IMAGE

# ============================================================

png(
  filename = file.path(
    output_dir,
    "GatekeeperX_Colourful_Professional_Architecture.png"
  ),
  width = 5200,
  height = 3600,
  res = 300
)

# ============================================================

# 6. GRAPH SETTINGS

# ============================================================

par(
  mar = c(0, 0, 0, 0)
)

plot.new()

plot.window(
  xlim = c(0, 30),
  ylim = c(0, 36)
)

# ============================================================

# 7. BACKGROUND

# ============================================================

rect(
  0,
  0,
  30,
  36,
  col = "gray98",
  border = NA
)

# ============================================================

# 8. MAIN HEADER

# ============================================================

rect(
  0,
  32,
  30,
  36,
  col = "navy",
  border = NA
)

text(
  15,
  34.4,
  "GATEKEEPERX",
  col = "white",
  cex = 3.0,
  font = 2
)

text(
  15,
  33.1,
  "INTELLIGENT DEVSECOPS SECURITY GATE",
  col = "white",
  cex = 1.35,
  font = 2
)

# ============================================================

# 9. DEVELOPER ENTRY

# ============================================================

draw_box(
  15,
  30.3,
  6,
  1.7,
  "DEVELOPER",
  "CODE COMMIT",
  "lightcyan",
  "dodgerblue4",
  1.35,
  0.9
)

draw_arrow(
  15,
  29.4,
  15,
  28.4,
  "dodgerblue4"
)

# ============================================================

# 10. DEVELOPMENT AND CI/CD LAYER

# ============================================================

draw_container(
  1.5,
  24,
  28.5,
  28.3,
  "DEVELOPMENT AND CI/CD PIPELINE",
  "lightcyan",
  "dodgerblue4"
)

draw_box(
  5,
  26,
  4.5,
  1.7,
  "SOURCE REPOSITORY",
  "VERSION CONTROL",
  "white",
  "dodgerblue4",
  1.05,
  0.7
)

draw_box(
  11.5,
  26,
  4.5,
  1.7,
  "CI PIPELINE",
  "AUTOMATED WORKFLOW",
  "white",
  "dodgerblue4",
  1.15,
  0.7
)

draw_box(
  18,
  26,
  4.5,
  1.7,
  "BUILD AND TEST",
  "COMPILE AND VALIDATE",
  "white",
  "dodgerblue4",
  1.05,
  0.7
)

draw_box(
  24.5,
  26,
  4.5,
  1.7,
  "BUILD ARTIFACT",
  "APPLICATION PACKAGE",
  "white",
  "dodgerblue4",
  1.05,
  0.65
)

draw_arrow(7.25, 26, 9.25, 26, "dodgerblue4")

draw_arrow(13.75, 26, 15.75, 26, "dodgerblue4")

draw_arrow(20.25, 26, 22.25, 26, "dodgerblue4")

# ============================================================

# 11. SECURITY SCANNING LAYER

# ============================================================

draw_container(
  1.5,
  17.5,
  28.5,
  23,
  "MULTI-LAYER SECURITY SCANNING",
  "lavender",
  "purple4"
)

draw_box(
  5,
  20.5,
  4.5,
  1.8,
  "SAST",
  "STATIC CODE ANALYSIS",
  "white",
  "purple4",
  1.4,
  0.7
)

draw_box(
  11.5,
  20.5,
  4.5,
  1.8,
  "SCA",
  "DEPENDENCY ANALYSIS",
  "white",
  "purple4",
  1.4,
  0.7
)

draw_box(
  18,
  20.5,
  4.5,
  1.8,
  "DAST",
  "RUNTIME TESTING",
  "white",
  "purple4",
  1.4,
  0.7
)

draw_box(
  24.5,
  20.5,
  4.5,
  1.8,
  "SECRET SCAN",
  "CREDENTIAL DETECTION",
  "white",
  "purple4",
  1.05,
  0.65
)

# ============================================================

# 12. CONNECT PIPELINE TO SECURITY

# ============================================================

draw_arrow(
  24.5,
  25.15,
  24.5,
  21.5,
  "purple4"
)

# ============================================================

# 13. SECURITY RESULTS HUB

# ============================================================

draw_box(
  15,
  15.5,
  15,
  1.8,
  "SECURITY RESULTS AGGREGATION",
  "NORMALIZE • CORRELATE • DEDUPLICATE • RISK SCORE",
  "lightsteelblue1",
  "blue4",
  1.35,
  0.65
)

# Scanner arrows

draw_arrow(
  5,
  19.6,
  9,
  16.5,
  "purple4"
)

draw_arrow(
  11.5,
  19.6,
  13,
  16.5,
  "purple4"
)

draw_arrow(
  18,
  19.6,
  17,
  16.5,
  "purple4"
)

draw_arrow(
  24.5,
  19.6,
  21,
  16.5,
  "purple4"
)

# ============================================================

# 14. GATEKEEPERX INTELLIGENCE PLATFORM

# ============================================================

draw_container(
  1.5,
  6.5,
  28.5,
  14.3,
  "GATEKEEPERX INTELLIGENCE PLATFORM",
  "honeydew",
  "darkgreen"
)

# Security Data

draw_box(
  4.5,
  11.3,
  4,
  1.8,
  "SECURITY DATA",
  "UNIFIED FINDINGS",
  "white",
  "darkgreen",
  1.05,
  0.7
)

# Risk Engine

draw_box(
  10,
  11.3,
  4,
  1.8,
  "RISK ENGINE",
  "SEVERITY + IMPACT",
  "white",
  "darkgreen",
  1.15,
  0.7
)

# Priority Engine

draw_box(
  15.5,
  11.3,
  4,
  1.8,
  "PRIORITY ENGINE",
  "RISK-BASED SCORE",
  "white",
  "darkgreen",
  1.0,
  0.7
)

# Intelligent Queue

draw_box(
  21,
  11.3,
  4,
  1.8,
  "INTELLIGENT QUEUE",
  "PRIORITY PROCESSING",
  "white",
  "darkgreen",
  0.9,
  0.65
)

draw_arrow(
  6.5,
  11.3,
  8,
  11.3,
  "darkgreen"
)

draw_arrow(
  12,
  11.3,
  13.5,
  11.3,
  "darkgreen"
)

draw_arrow(
  17.5,
  11.3,
  19,
  11.3,
  "darkgreen"
)

# Aggregation to Engine

draw_arrow(
  15,
  14.6,
  4.5,
  12.2,
  "darkgreen"
)

# ============================================================

# 15. DYNAMIC AGING

# ============================================================

draw_box(
  15,
  8.5,
  8,
  1.8,
  "DYNAMIC AGING MODULE",
  "INCREASE WAITING PRIORITY • PREVENT STARVATION",
  "lightgoldenrod1",
  "darkorange3",
  1.15,
  0.65
)

draw_arrow(
  21,
  10.4,
  15,
  9.4,
  "darkorange3"
)

# ============================================================

# 16. SECURITY POLICY ENGINE

# ============================================================

draw_box(
  15,
  5.7,
  10,
  1.8,
  "SECURITY POLICY ENGINE",
  "RISK THRESHOLDS • COMPLIANCE RULES • GATE POLICIES",
  "moccasin",
  "darkorange3",
  1.15,
  0.62
)

draw_arrow(
  15,
  7.6,
  15,
  6.6,
  "darkorange3"
)

# ============================================================

# 17. FINAL DECISION ENGINE

# ============================================================

draw_box(
  15,
  3.2,
  9,
  1.8,
  "FINAL SECURITY DECISION",
  "AUTOMATED DEPLOYMENT SECURITY GATE",
  "lightcyan",
  "blue4",
  1.25,
  0.7
)

draw_arrow(
  15,
  4.8,
  15,
  4.1,
  "blue4"
)

# ============================================================

# 18. FINAL OUTCOMES

# ============================================================

draw_box(
  5,
  0.9,
  6,
  1.6,
  "PASS",
  "DEPLOYMENT APPROVED",
  "palegreen",
  "darkgreen",
  1.4,
  0.75
)

draw_box(
  15,
  0.9,
  6,
  1.6,
  "WAIT",
  "MANUAL REVIEW",
  "lightgoldenrod1",
  "darkorange3",
  1.4,
  0.75
)

draw_box(
  25,
  0.9,
  6,
  1.6,
  "BLOCK",
  "FIX AND RESCAN",
  "mistyrose",
  "red3",
  1.4,
  0.75
)

draw_arrow(
  12,
  2.3,
  5,
  1.8,
  "darkgreen"
)

draw_arrow(
  15,
  2.3,
  15,
  1.8,
  "darkorange3"
)

draw_arrow(
  18,
  2.3,
  25,
  1.8,
  "red3"
)

# ============================================================

# 19. CLOSE IMAGE

# ============================================================

dev.off()

# ============================================================

# 20. SUCCESS MESSAGE

# ============================================================

cat("\n")
cat("===============================================\n")
cat(" GATEKEEPERX COLOURFUL ARCHITECTURE COMPLETED\n")
cat("===============================================\n\n")

cat("Output folder:\n")
cat(output_dir)
cat("\n\n")

cat("Generated image:\n")
cat("GatekeeperX_Colourful_Professional_Architecture.png\n")
