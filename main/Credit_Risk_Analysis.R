# -----------------------------------------------------------------------------
# CREDIT RISK EXPLORATORY DATA ANALYSIS (EDA)
# Purpose: Load, clean, transform, and analyze credit risk data using R.
# -----------------------------------------------------------------------------

# 1. SETUP AND DATA IMPORT
# Load required libraries
library(ggplot2)
library(dplyr)
library(tidyr)

# >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
# Get the data Path:
data_path <- "D:\\\\Worksheet\\\\R_25CAP-632\\\\Mini Project\\\\Credit_Risk_Anlysis\\\\Data\\\\credit_risk_dataset.csv"
# >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

# Check if the file exists before reading
if (!file.exists(data_path)) {
  # This error message is now much clearer about the file path issue
  stop(paste("ERROR: Data file not found. Please ensure the path is correct and uses double backslashes (\\\\) or forward slashes (/). Current path:", data_path))
}

data <- read.csv(data_path)

# Display initial structure and first few rows
print("--- 1. Initial Data Structure (str) ---")
str(data)
print("--- First 6 Rows (head) ---")
head(data)
print("--- Actual Column Names ---")
print(names(data))

# -----------------------------------------------------------------------------
# 2. DATA CLEANING AND PREPROCESSING
# -----------------------------------------------------------------------------

# 2.1 Missing Value and Duplicate Handling
print(paste("Total missing values before cleaning:", sum(is.na(data))))

# Use pipe operator to clean and transform data in one robust sequence:
data_clean <- data %>%
  # Handle Missing Values: Drop all rows with any NA
  drop_na() %>%
  # Remove Duplicate Rows
  distinct() %>%
  # Type Conversion: Ensure key variables are correctly typed
  mutate(
    # Loan_Status is the target variable
    Loan_Status = as.factor(Loan_Status),
    # Credit_History is a key categorical variable for risk
    Credit_History = as.factor(Credit_History)
  )

print(paste("Total rows removed during cleaning:", nrow(data) - nrow(data_clean)))
print(paste("Total rows remaining:", nrow(data_clean)))

# Remove unused factor levels after cleaning
data_clean$Loan_Status <- droplevels(data_clean$Loan_Status)
data_clean$Credit_History <- droplevels(data_clean$Credit_History)

# 2.2 Advanced Outlier Treatment (Capping using IQR method)
cap_outliers_iqr <- function(x) {
  Q1 <- quantile(x, 0.25, na.rm = TRUE)
  Q3 <- quantile(x, 0.75, na.rm = TRUE)
  IQR_val <- Q3 - Q1
  lower_bound <- Q1 - 1.5 * IQR_val
  upper_bound <- Q3 + 1.5 * IQR_val
  
  # Cap the values
  x[x < lower_bound] <- lower_bound
  x[x > upper_bound] <- upper_bound
  return(x)
}

# Apply outlier capping to Income and LoanAmount
data_clean$Income_Capped <- cap_outliers_iqr(data_clean$Income)
data_clean$LoanAmount_Capped <- cap_outliers_iqr(data_clean$LoanAmount)

# -----------------------------------------------------------------------------
# 3. DESCRIPTIVE STATISTICS AND DISTRIBUTION
# -----------------------------------------------------------------------------

# Summary Statistics on Capped Data
print("--- 3. Summary Statistics on Cleaned & Capped Data ---")
summary(data_clean)

# Histogram of Income (Capped)
ggplot(data_clean, aes(x = Income_Capped)) +
  geom_histogram(bins = 30, fill = "#0077b6", color = "white") +
  theme_minimal() +
  labs(title = "Distribution of Applicant Income (Capped)",
       x = "Applicant Income (Capped)", y = "Frequency")

# Histogram of Loan Amount (Capped)
ggplot(data_clean, aes(x = LoanAmount_Capped)) +
  geom_histogram(bins = 30, fill = "#ffc300", color = "white") +
  theme_minimal() +
  labs(title = "Distribution of Loan Amount (Capped)",
       x = "Loan Amount (Capped)", y = "Count")

# Side-by-Side Boxplots for Outlier Comparison (Income)
par(mfrow = c(1, 2))
boxplot(data_clean$Income, main = "Original Income Distribution", col = "#e76f51")
boxplot(data_clean$Income_Capped, main = "Capped Income Distribution", col = "#83c5be")
par(mfrow = c(1, 1))

# -----------------------------------------------------------------------------
# 4. RELATIONSHIP ANALYSIS: Credit History vs. Loan Status
# -----------------------------------------------------------------------------

print("--- 4. Relationship Analysis: Credit History vs. Loan Status ---")

# 4.1 Categorical Relationship (Contingency Table)
credit_loan_status_table <- table(data_clean$Credit_History, data_clean$Loan_Status)
print("Contingency Table: Credit History vs. Loan Status")
print(credit_loan_status_table)

# Calculate proportions for risk assessment (rows sum to 100%)
prop_table <- prop.table(credit_loan_status_table, 1) * 100
print("Proportions (% within Credit History) of Loan Status")
print(prop_table)

# 4.2 Numerical Relationship (Grouped Boxplots)
# Visualize Loan Amount distribution grouped by Credit History
ggplot(data_clean, aes(x = Credit_History, y = LoanAmount_Capped, fill = Credit_History)) +
  geom_boxplot() +
  theme_classic() +
  labs(title = "Loan Amount Distribution by Credit History",
       x = "Credit History Status", y = "Loan Amount (Capped)")

# -----------------------------------------------------------------------------
# 5. FINAL CLEANUP
# Print final cleaned data structure for reporting
print("--- 5. Final Data Structure ---")
str(data_clean)
# -----------------------------------------------------------------------------



















