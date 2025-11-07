# 🏦 Credit Risk Exploratory Data Analysis (EDA)

This project performs an **exploratory data analysis (EDA)** on a credit risk dataset using **R**.  
The primary goal is to understand the structure of the data, clean it effectively, and analyze key relationships — particularly focusing on how factors like **Credit History** and **Applicant Income** relate to the final **Loan Status**.

The analysis serves as a foundation for building predictive models to assess **loan approval risk**.

---

## 🗂️ Project Structure

The R script **`Credit_Risk_Analysis.R`** contains the full workflow, including:

1. **Setup and Data Import:** Loading libraries and reading the data.  
2. **Data Cleaning and Preprocessing:** Handling missing values, duplicates, and data type conversions.  
3. **Advanced Outlier Treatment:** Applying the Interquartile Range (IQR) capping method for key numerical features.  
4. **Descriptive Statistics and Distribution:** Summarizing and visualizing the cleaned dataset.  
5. **Relationship Analysis:** Exploring the relationship between Credit History and Loan Status.  
6. **Final Cleanup:** Presenting the final, ready-to-use data structure.

---

## 🛠️ Prerequisites

To run this analysis, you will need:

- **R** (version 4.0 or higher recommended)  
- **RStudio** (recommended IDE)  
- The following R packages:
  - `ggplot2`
  - `dplyr`
  - `tidyr`

You can install all required packages using:

```R
install.packages(c("ggplot2", "dplyr", "tidyr"))
```

---

## ⚙️ How to Run the Analysis

### 1. Clone the Repository
```bash
git clone https://github.com/YourUsername/Credit-Risk-Analysis-R.git
cd Credit-Risk-Analysis-R
```

### 2. Obtain the Data
Ensure your dataset is named **`credit_risk_dataset.csv`** and is accessible on your system.

### 3. Update the Data Path
Modify the `data_path` variable in the **`Credit_Risk_Analysis.R`** script to match your local path.

**Current path in script:**
```R
data_path <- "D:\Worksheet\R_25CAP-632\Mini Project\Credit_Risk_Anlysis\Data\credit_risk_dataset.csv"
```

**Change this to match your system’s file location.**

### 4. Execute the Script
Open the `Credit_Risk_Analysis.R` file in RStudio and run the entire script:
```R
source("Credit_Risk_Analysis.R")
```

The script will:
- Print descriptive statistics, contingency tables, and proportions in the console.
- Generate plots and charts in R’s graphical output window.

---

## 📝 Key Analysis Highlights

### 1. Data Cleaning and Transformation
A robust data cleaning sequence is implemented:
- **Missing Data & Duplicates:** All rows with `NA` values and duplicates are removed (`drop_na()` and `distinct()`).  
- **Feature Engineering & Outlier Treatment:**  
  A custom **Interquartile Range (IQR)** capping function is applied to numerical features `Income` and `LoanAmount`.  
  This mitigates the influence of extreme outliers while preserving valid data.

The capped features are stored in new columns:
- `Income_Capped`
- `LoanAmount_Capped`

---

### 2. Income and Loan Amount Distribution
- **Histograms** visualize the distribution of capped numerical variables.  
- **Boxplots** show before-and-after effects of IQR capping for `Income`.  

Example visualization comparison:
| Original Income Distribution | Capped Income Distribution |
|-------------------------------|-----------------------------|
| (Boxplot 1) | (Boxplot 2) |

---

### 3. Credit History vs. Loan Status Relationship
This is a core focus area of credit risk assessment.

#### Contingency Table & Proportions
| Credit History | Loan Approved | Loan Rejected |
|----------------|----------------|----------------|
| 0 (No) | ... | ... |
| 1 (Yes) | ... | ... |

The **proportion table** calculates approval/rejection percentages within each Credit History group.

**Insight:**  
Applicants with a “Yes” Credit History typically have a loan approval rate of **80%+**, making Credit History the strongest single predictor of Loan Status.

#### Loan Amount Distribution by Credit History
A **grouped boxplot** compares the loan amounts requested by applicants with different Credit History statuses, helping identify whether credit history influences requested loan sizes.

---

## 🎯 Next Steps

1. **Feature Importance:**  
   Use models such as Random Forest to formally rank predictor importance.  
2. **Modeling:**  
   Build a binary classification model (e.g., Logistic Regression, Decision Tree) to predict `Loan_Status`.  
3. **Model Evaluation:**  
   Evaluate model performance using **Accuracy**, **Precision**, **Recall**, and **ROC Curve**.

---

## 🧾 Author
**Akash Singh Negi**  
_Data Science & Analytics Enthusiast_  

📧 akashsinghnegi07012005@gmail.com  
🔗 https://www.linkedin.com/in/akash-singh-negi/

---


