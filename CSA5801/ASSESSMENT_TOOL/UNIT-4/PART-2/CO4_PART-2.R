devsecops <- grViz("
digraph DevSecOps {

  graph [
    rankdir=TB,
    bgcolor='#F8FAFC',

    margin=0,
    pad=0.01,

    nodesep=0.10,
    ranksep=0.20,

    splines=polyline,

    fontname='Arial',

    compound=true,
    newrank=true
  ]

  node [
    fontname='Arial',
    fontsize=10
  ]

  edge [
    fontname='Arial',
    fontsize=8,
    color='#334155',
    penwidth=1.4,
    arrowsize=0.55
  ]


  TITLE [
    shape=box,
    style='rounded,filled',
    fillcolor='#D1D5DB',
    color='#9CA3AF',
    fontname='Arial',
    fontsize=18,
    fontcolor='#0F172A',
    label='DEVSECOPS WORKFLOW & DEPLOYMENT MODEL'
  ]


  DEV [
    shape=plain,
    label=<
      <TABLE BORDER='2' COLOR='#2563EB'
             CELLBORDER='0' CELLSPACING='0' CELLPADDING='5'>

        <TR>
          <TD COLSPAN='5' BGCOLOR='#DBEAFE'>
            <FONT FACE='Arial' COLOR='#1D4ED8' POINT-SIZE='12'>
              <B>1. DEVELOPMENT</B>
            </FONT>
          </TD>
        </TR>

        <TR>
          <TD BGCOLOR='#2563EB'>
            <FONT FACE='Arial' COLOR='white'>
              <B>DEVELOPER</B>
            </FONT>
          </TD>

          <TD>→</TD>

          <TD BGCOLOR='#3B82F6'>
            <FONT FACE='Arial' COLOR='white'>
              <B>IDE</B>
            </FONT>
          </TD>

          <TD>→</TD>

          <TD BGCOLOR='#7C3AED'>
            <FONT FACE='Arial' COLOR='white'>
              <B>GIT</B>
            </FONT>
          </TD>
        </TR>

        <TR>
          <TD COLSPAN='5' BGCOLOR='#EEF2FF'>
            <FONT FACE='Arial' COLOR='#4338CA' POINT-SIZE='9'>
              <B>CODE REVIEW</B> → <B>BRANCH MANAGEMENT</B>
            </FONT>
          </TD>
        </TR>

      </TABLE>
    >
  ]


  CI [
    shape=plain,
    label=<
      <TABLE BORDER='2' COLOR='#F59E0B'
             CELLBORDER='0' CELLSPACING='0' CELLPADDING='5'>

        <TR>
          <TD COLSPAN='4' BGCOLOR='#FEF3C7'>
            <FONT FACE='Arial' COLOR='#B45309' POINT-SIZE='12'>
              <B>2. CONTINUOUS INTEGRATION PIPELINE</B>
            </FONT>
          </TD>
        </TR>

        <TR>
          <TD BGCOLOR='#F59E0B'>
            <FONT FACE='Arial' COLOR='white'><B>BUILD</B></FONT>
          </TD>

          <TD>→</TD>

          <TD BGCOLOR='#EA580C'>
            <FONT FACE='Arial' COLOR='white'>
              <B>UNIT + INTEGRATION TEST</B>
            </FONT>
          </TD>

          <TD>→</TD>
        </TR>

        <TR>
          <TD BGCOLOR='#D97706'>
            <FONT FACE='Arial' COLOR='white'>
              <B>QUALITY GATE</B>
            </FONT>
          </TD>

          <TD>→</TD>

          <TD BGCOLOR='#DC2626'>
            <FONT FACE='Arial' COLOR='white'>
              <B>SECURITY ANALYSIS</B>
            </FONT>
          </TD>

          <TD></TD>
        </TR>

      </TABLE>
    >
  ]


  SECURITY [
    shape=plain,
    label=<
      <TABLE BORDER='2' COLOR='#DC2626'
             CELLBORDER='0' CELLSPACING='0' CELLPADDING='5'>

        <TR>
          <TD COLSPAN='4' BGCOLOR='#FEE2E2'>
            <FONT FACE='Arial' COLOR='#991B1B' POINT-SIZE='12'>
              <B>3. DEVSECOPS SECURITY VALIDATION</B>
            </FONT>
          </TD>
        </TR>

        <TR>
          <TD BGCOLOR='#DC2626'>
            <FONT FACE='Arial' COLOR='white'>
              <B>SAST</B><BR/>STATIC ANALYSIS
            </FONT>
          </TD>

          <TD>→</TD>

          <TD BGCOLOR='#E11D48'>
            <FONT FACE='Arial' COLOR='white'>
              <B>SCA</B><BR/>DEPENDENCY SCAN
            </FONT>
          </TD>

          <TD>→</TD>
        </TR>

        <TR>
          <TD BGCOLOR='#BE123C'>
            <FONT FACE='Arial' COLOR='white'>
              <B>SECRET SCANNING</B>
            </FONT>
          </TD>

          <TD>→</TD>

          <TD BGCOLOR='#7F1D1D'>
            <FONT FACE='Arial' COLOR='white'>
              <B>SECURITY GATE</B>
            </FONT>
          </TD>

          <TD>
            <FONT FACE='Arial' COLOR='#16A34A'>
              <B>PASS</B>
            </FONT>
          </TD>
        </TR>

        <TR>
          <TD COLSPAN='4' BGCOLOR='#FFF1F2'>
            <FONT FACE='Arial' COLOR='#DC2626' POINT-SIZE='9'>
              <B>FAIL → PIPELINE STOPPED → FIX ISSUE → RE-RUN</B>
            </FONT>
          </TD>
        </TR>

      </TABLE>
    >
  ]


  SUPPLY [
    shape=plain,
    label=<
      <TABLE BORDER='2' COLOR='#0891B2'
             CELLBORDER='0' CELLSPACING='0' CELLPADDING='5'>

        <TR>
          <TD COLSPAN='4' BGCOLOR='#CFFAFE'>
            <FONT FACE='Arial' COLOR='#0E7490' POINT-SIZE='12'>
              <B>4. SOFTWARE SUPPLY CHAIN</B>
            </FONT>
          </TD>
        </TR>

        <TR>
          <TD BGCOLOR='#06B6D4'>
            <FONT FACE='Arial' COLOR='white'>
              <B>PACKAGE</B>
            </FONT>
          </TD>

          <TD>→</TD>

          <TD BGCOLOR='#0891B2'>
            <FONT FACE='Arial' COLOR='white'>
              <B>SBOM</B>
            </FONT>
          </TD>

          <TD>→</TD>
        </TR>

        <TR>
          <TD BGCOLOR='#0E7490'>
            <FONT FACE='Arial' COLOR='white'>
              <B>ARTIFACT REGISTRY</B>
            </FONT>
          </TD>

          <TD>→</TD>

          <TD BGCOLOR='#155E75'>
            <FONT FACE='Arial' COLOR='white'>
              <B>ARTIFACT SIGNING</B>
            </FONT>
          </TD>

          <TD></TD>
        </TR>

      </TABLE>
    >
  ]


  DEPLOY [
    shape=plain,
    label=<
      <TABLE BORDER='2' COLOR='#6366F1'
             CELLBORDER='0' CELLSPACING='0' CELLPADDING='5'>

        <TR>
          <TD COLSPAN='3' BGCOLOR='#E0E7FF'>
            <FONT FACE='Arial' COLOR='#4338CA' POINT-SIZE='12'>
              <B>5. DEPLOYMENT ORCHESTRATION</B>
            </FONT>
          </TD>
        </TR>

        <TR>
          <TD COLSPAN='3' BGCOLOR='#4338CA'>
            <FONT FACE='Arial' COLOR='white'>
              <B>RELEASE GATE</B>
            </FONT>
          </TD>
        </TR>

        <TR>
          <TD COLSPAN='3' BGCOLOR='#4F46E5'>
            <FONT FACE='Arial' COLOR='white'>
              <B>DEPLOYMENT STRATEGY</B>
            </FONT>
          </TD>
        </TR>

        <TR>
          <TD BGCOLOR='#6366F1'>
            <FONT FACE='Arial' COLOR='white'>
              <B>ROLLING</B>
            </FONT>
          </TD>

          <TD BGCOLOR='#7C3AED'>
            <FONT FACE='Arial' COLOR='white'>
              <B>CANARY</B>
            </FONT>
          </TD>

          <TD BGCOLOR='#8B5CF6'>
            <FONT FACE='Arial' COLOR='white'>
              <B>BLUE-GREEN</B>
            </FONT>
          </TD>
        </TR>

      </TABLE>
    >
  ]


  ENV [
    shape=plain,
    label=<
      <TABLE BORDER='2' COLOR='#10B981'
             CELLBORDER='0' CELLSPACING='0' CELLPADDING='5'>

        <TR>
          <TD COLSPAN='3' BGCOLOR='#D1FAE5'>
            <FONT FACE='Arial' COLOR='#047857' POINT-SIZE='12'>
              <B>6. DEPLOYMENT ENVIRONMENTS</B>
            </FONT>
          </TD>
        </TR>

        <TR>

          <TD BGCOLOR='#10B981'>
            <FONT FACE='Arial' COLOR='white'>
              <B>DEV</B><BR/>ENVIRONMENT
            </FONT>
          </TD>

          <TD>→</TD>

          <TD BGCOLOR='#059669'>
            <FONT FACE='Arial' COLOR='white'>
              <B>STAGING</B><BR/>ENVIRONMENT
            </FONT>
          </TD>

        </TR>

        <TR>

          <TD COLSPAN='2' BGCOLOR='#ECFDF5'>
            <FONT FACE='Arial' COLOR='#047857' POINT-SIZE='9'>
              <B>VALIDATE →</B>
            </FONT>
          </TD>

          <TD BGCOLOR='#047857'>
            <FONT FACE='Arial' COLOR='white'>
              <B>PRODUCTION</B><BR/>ENVIRONMENT
            </FONT>
          </TD>

        </TR>

      </TABLE>
    >
  ]


  CLOUD [
    shape=plain,
    label=<
      <TABLE BORDER='2' COLOR='#2563EB'
             CELLBORDER='0' CELLSPACING='0' CELLPADDING='5'>

        <TR>
          <TD COLSPAN='3' BGCOLOR='#DBEAFE'>
            <FONT FACE='Arial' COLOR='#1E3A8A' POINT-SIZE='12'>
              <B>7. CLOUD / RUNTIME INFRASTRUCTURE</B>
            </FONT>
          </TD>
        </TR>

        <TR>

          <TD BGCOLOR='#2563EB'>
            <FONT FACE='Arial' COLOR='white'>
              <B>KUBERNETES</B><BR/>
              CONTAINER PLATFORM
            </FONT>
          </TD>

          <TD BGCOLOR='#1D4ED8'>
            <FONT FACE='Arial' COLOR='white'>
              <B>APPLICATION SERVICES</B><BR/>
              APIs / MICROSERVICES
            </FONT>
          </TD>

          <TD BGCOLOR='#1E40AF'>
            <FONT FACE='Arial' COLOR='white'>
              <B>DATABASE</B>
            </FONT>
          </TD>

        </TR>

      </TABLE>
    >
  ]


  OBS [
    shape=plain,
    label=<
      <TABLE BORDER='2' COLOR='#64748B'
             CELLBORDER='0' CELLSPACING='0' CELLPADDING='5'>

        <TR>
          <TD COLSPAN='4' BGCOLOR='#E2E8F0'>
            <FONT FACE='Arial' COLOR='#334155' POINT-SIZE='12'>
              <B>8. OBSERVABILITY &amp; FEEDBACK</B>
            </FONT>
          </TD>
        </TR>

        <TR>

          <TD BGCOLOR='#475569'>
            <FONT FACE='Arial' COLOR='white'>
              <B>LOGS</B>
            </FONT>
          </TD>

          <TD BGCOLOR='#64748B'>
            <FONT FACE='Arial' COLOR='white'>
              <B>METRICS</B>
            </FONT>
          </TD>

          <TD BGCOLOR='#0F172A'>
            <FONT FACE='Arial' COLOR='white'>
              <B>OBSERVABILITY</B><BR/>DASHBOARD
            </FONT>
          </TD>

          <TD BGCOLOR='#334155'>
            <FONT FACE='Arial' COLOR='white'>
              <B>ALERTS</B>
            </FONT>
          </TD>

        </TR>

        <TR>

          <TD COLSPAN='2' BGCOLOR='#F1F5F9'>
            <FONT FACE='Arial' COLOR='#475569'>
              <B>LOGS + METRICS</B>
            </FONT>
          </TD>

          <TD BGCOLOR='#475569'>
            <FONT FACE='Arial' COLOR='white'>
              <B>CONTINUOUS FEEDBACK</B>
            </FONT>
          </TD>

          <TD BGCOLOR='#991B1B'>
            <FONT FACE='Arial' COLOR='white'>
              <B>AUTOMATED ROLLBACK</B>
            </FONT>
          </TD>

        </TR>

        <TR>

          <TD COLSPAN='4' BGCOLOR='#FFF1F2'>
            <FONT FACE='Arial' COLOR='#DC2626' POINT-SIZE='9'>
              <B>CRITICAL FAILURE → PREVIOUS STABLE VERSION → RESTORE PRODUCTION</B>
            </FONT>
          </TD>

        </TR>

      </TABLE>
    >
  ]


  FAIL [

    shape=box,

    style='rounded,filled',

    fillcolor='#7F1D1D',

    color='#450A0A',

    fontcolor='white',

    fontname='Arial',

    fontsize=9,

    label='PIPELINE STOPPED\\nFIX ISSUE → RE-RUN'
  ]


  # ==========================================================
  # MAIN FLOW
  # ==========================================================

  TITLE -> DEV [
    style=invis
  ]

  DEV -> CI [
    label='TRIGGER',
    color='#2563EB',
    fontcolor='#2563EB',
    penwidth=1.5
  ]

  CI -> SECURITY [
    color='#DC2626',
    penwidth=1.5
  ]

  SECURITY -> SUPPLY [
    label='PASS',
    color='#16A34A',
    fontcolor='#16A34A',
    penwidth=1.5
  ]

  SUPPLY -> DEPLOY [
    label='SIGNED ARTIFACT',
    color='#0891B2',
    fontcolor='#0891B2',
    penwidth=1.5
  ]

  DEPLOY -> ENV [
    label='DEPLOY',
    color='#6366F1',
    fontcolor='#4338CA',
    penwidth=1.5
  ]

  ENV -> CLOUD [
    label='PROVISION',
    color='#2563EB',
    fontcolor='#1E3A8A',
    penwidth=1.5
  ]

  CLOUD -> OBS [
    label='MONITOR',
    color='#475569',
    fontcolor='#334155',
    penwidth=1.5
  ]


  # ==========================================================
  # FAILURE
  # ==========================================================

  SECURITY -> FAIL [
    label='FAIL',
    color='#DC2626',
    fontcolor='#DC2626',
    style=dashed,
    constraint=false
  ]


  # ==========================================================
  # FEEDBACK
  # ==========================================================

  OBS -> CI [
    label='RE-TRIGGER CI',
    color='#64748B',
    fontcolor='#475569',
    style=dashed,
    constraint=false
  ]


  # ==========================================================
  # ROLLBACK
  # ==========================================================

  OBS -> ENV [
    label='RESTORE',
    color='#DC2626',
    fontcolor='#DC2626',
    style=dashed,
    constraint=false
  ]

}
",
engine = "dot"
)


# ================================================================
# DISPLAY
# ================================================================

devsecops


# ================================================================
# SAVE HTML
# ================================================================

saveWidget(
  devsecops,
  "CO4_PART2_DevSecOps_Workflow.html",
  selfcontained = TRUE
)


# ================================================================
# COMPLETION MESSAGE
# ================================================================

cat("
========================================================
CO4 PART 2 COMPLETED SUCCESSFULLY
========================================================

Assessment:
CO4 - Part 2

Topic:
Workflow & Deployment Modelling

Model:
DEVSECOPS WORKFLOW & DEPLOYMENT MODEL

Sections:
1. Development
2. Continuous Integration Pipeline
3. DevSecOps Security Validation
4. Software Supply Chain
5. Deployment Orchestration
6. Deployment Environments
7. Cloud / Runtime Infrastructure
8. Observability & Feedback
9. Failure Handling
10. Automated Rollback

File:
CO4_PART2_DevSecOps_Workflow.html

========================================================
")