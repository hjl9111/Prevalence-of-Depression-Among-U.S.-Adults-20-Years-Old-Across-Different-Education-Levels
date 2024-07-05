*******************************
*Intermediate Epi Spring 2024*
*Author: Helen Liang*
*Analysis Project*
*Updated 05/14/2024*
*******************************

*import and merge datasets
use "/Users/hl0616/Library/Mobile Documents/com~apple~CloudDocs/NYU/Spring 2024/GPH-GU 2450 Intermediate Epidemiology/Analysis Project/Depression_data for ANALYSIS PROJECT.dta"
merge 1:1 seqn using "/Users/hl0616/Library/Mobile Documents/com~apple~CloudDocs/NYU/Spring 2024/GPH-GU 2450 Intermediate Epidemiology/Analysis Project/NHANES_dataset for ANALYSIS PROJECT.dta"

******************************
*Part D Univariable Analysis*
******************************

/* Sociodemographic Characteristics */

*Education Level
gen dmdeduc2_new = dmdeduc2
replace dmdeduc2_new =. if dmdeduc2 == 7 | dmdeduc2 == 9 // Recode "Refused", "Don't Know" as .

label define education 1 "Less than 9th grade" 2 "9-11th grade" 3 "High school graduate/GED or equivalent" 4 "Some college or AA degree" 5 "College graduate or above"
label value dmdeduc2_new education
drop if missing(dmdeduc2_new)

*Gender
label define gender 1 "Male" 2 "Female"
label value riagendr gender

*Age
keep if ridageyr >= 20

gen ridageyr_new =.
replace ridageyr_new = 1 if ridageyr >= 20 & ridageyr <= 29 // Recode "20-29" as 1
replace ridageyr_new = 2 if ridageyr >= 30 & ridageyr <= 39 // Recode "30-39" as 2
replace ridageyr_new = 3 if ridageyr >= 40 & ridageyr <= 49 // Recode "40-49" as 3
replace ridageyr_new = 4 if ridageyr >= 50 & ridageyr <= 59 // Recode "50-59" as 4
replace ridageyr_new = 5 if ridageyr >= 60 & ridageyr <= 69 // Recode "60-69" as 5
replace ridageyr_new = 6 if ridageyr >= 70 & ridageyr <= 79 // Recode "70-79" as 6
replace ridageyr_new = 7 if ridageyr >= 80 					// Recode "≥ 80" as 7

label define age 1 "20-29" 2 "30-39" 3 "40-49" 4 "50-59" 5 "60-69" 6 "70-79" 7 "≥ 80"
label value ridageyr_new age

*Race/Ethnicity
gen ridreth_new = ridreth1
replace ridreth_new = 5 if ridreth3 == 6 // Recode "Non-Hispanic Asian" as 5
replace ridreth_new = 6 if ridreth3 == 7 // Recode "Other Race - Including Multi-Racial" as 6

label define race 1 "Mexican American" 2 "Other Hispanic" 3 "Non-Hispanic White" 4 "Non-Hispanic Black" 5 "Non-Hispanic Asian" 6 "Other Race - Including Multi-Racial"
label value ridreth_new race

*Marital Status
gen dmdmartz_new = dmdmartz
replace dmdmartz_new =. if dmdmartz == 77 | dmdmartz == 99 | dmdmartz ==. // Recode "Refused", "Don't Know", "." as .

label define marital 1 "Married/Living with Partner" 2 "Widowed/Divorced/Separated" 3 "Never Married"
label value dmdmartz_new marital
drop if missing(dmdmartz_new)

*Ratio of Family Income to Poverty
gen indfmpir_new =.
replace indfmpir_new = 1 if indfmpir >= 0 & indfmpir <= 1
replace indfmpir_new = 2 if indfmpir > 1 & indfmpir <= 5

label define income 1 "≤ 1" 2 "> 1"
label value indfmpir_new income
drop if missing(indfmpir_new)

*Health Insurance Coverage
gen hiq011_new = hiq011
replace hiq011_new =. if hiq011 == 7 | hiq011 == 9 // Recode "Refused", "Don't Know" as .

label define insurance 1 "Yes" 2 "No"
label value hiq011_new insurance
drop if missing(hiq011_new)

*run frequencies for all variables above
tab riagendr, missing
tab ridageyr_new, missing
tab ridreth_new, missing
tab dmdeduc2_new, missing
tab dmdmartz_new, missing
tab indfmpir_new, missing
tab hiq011_new, missing

/* PHQ-9 Depression Scale */

*run frequences for the following variables using the TAB command: DPQ010 - DPQ090*
tab1 dpq010-dpq090, missing

/* a. What is the % missing (.), don't know (7s) and refused (9s) for each item DPQ010 – DPQ090?
dpq010 has 0.03% don't knows (7s), 0.04% refused (9s), and 46.61% missing (.)
dpq020 has 0.01% don't knows (7s), 0.03% refused (9s), and 46.62% missing (.)
dpq030 has 0.02% don't knows (7s), 0.03% refused (9s), and 46.62% missing (.)
dpq040 has 0.03% don't knows (7s), 0.03% refused (9s), and 46.63% missing (.)
dpq050 has 0.01% don't knows (7s), 0.03% refused (9s), and 46.63% missing (.)
dpq060 has 0.02% don't knows (7s), 0.04% refused (9s), and 46.63% missing (.)
dpq070 has 0.01% don't knows (7s), 0.02% refused (9s), and 46.63% missing (.)
dpq080 has 0.01% don't knows (7s), 0.03% refused (9s), and 46.63% missing (.)
dpq090 has 0.01% don't knows (7s), 0.03% refused (9s), and 46.65% missing (.)
*/

/* b. What is the overall prevalence of each symptom identified in DPQ010 – DPQ090? (combining responses 0/1 and 2/3) 
dpq010 has 48.45% prevalence for responses 0/1 and 4.88% prevalence for responses 2/3
dpq020 has 49.12% prevalence for responses 0/1 and 4.22% prevalence for responses 2/3
dpq030 has 44.43% prevalence for responses 0/1 and 8.90% prevalence for responses 2/3
dpq040 has 44.00% prevalence for responses 0/1 and 9.33% prevalence for responses 2/3
dpq050 has 47.93% prevalence for responses 0/1 and 5.40% prevalence for responses 2/3
dpq060 has 50.44% prevalence for responses 0/1 and 2.87% prevalence for responses 2/3
dpq070 has 49.83% prevalence for responses 0/1 and 3.50% prevalence for responses 2/3
dpq080 has 51.11% prevalence for responses 0/1 and 2.21% prevalence for responses 2/3
dpq090 has 52.76% prevalence for responses 0/1 and 0.56% prevalence for responses 2/3
*/

/* Create a new variable and examine missingness */

/*operators: 
				& = "and"
				| = "or"
				~ or ! = "not"
*/

*dpq010 - have little interest in doing things
gen dpq010_new = dpq010
replace dpq010_new =. if dpq010 == 7 | dpq010 == 9 | dpq010 ==.

tab dpq010
tab dpq010_new
*crosstab and include missing
tab2 dpq010 dpq010_new, missing

*dpq020 - feeling down, depressed, or hopeless
gen dpq020_new = dpq020
replace dpq020_new =. if dpq020 == 7 | dpq020 == 9 | dpq020 ==.

tab dpq020
tab dpq020_new
*crosstab and include missing
tab2 dpq020 dpq020_new, missing

*dpq030 - trouble sleeping or sleeping too much
gen dpq030_new = dpq030
replace dpq030_new =. if dpq030 == 7 | dpq030 == 9 | dpq030 ==.

tab dpq030
tab dpq030_new
*crosstab and include missing
tab2 dpq030 dpq030_new, missing

*dpq040 - feeling tired or having little energy
gen dpq040_new = dpq040
replace dpq040_new =. if dpq040 == 7 | dpq040 == 9 | dpq040 ==.

tab dpq040
tab dpq040_new
*crosstab and include missing
tab2 dpq040 dpq040_new, missing

*dpq050 - poor appetite or overeating
gen dpq050_new = dpq050
replace dpq050_new =. if dpq050 == 7 | dpq050 == 9 | dpq050 ==.

tab dpq050
tab dpq050_new
*crosstab and include missing
tab2 dpq050 dpq050_new, missing

*dpq060 - feeling bad about yourself
gen dpq060_new = dpq060
replace dpq060_new =. if dpq060 == 7 | dpq060 == 9 | dpq060 ==.

tab dpq060
tab dpq060_new
*crosstab and include missing
tab2 dpq060 dpq060_new, missing

*dpq070 - trouble concentrating on things
gen dpq070_new = dpq070
replace dpq070_new =. if dpq070 == 7 | dpq070 == 9 | dpq070 ==.

tab dpq070
tab dpq070_new
*crosstab and include missing
tab2 dpq070 dpq070_new, missing

*dpq080 - moving or speaking slowly or too fast
gen dpq080_new = dpq080
replace dpq080_new =. if dpq080 == 7 | dpq080 == 9 | dpq080 ==.

tab dpq080
tab dpq080_new
*crosstab and include missing
tab2 dpq080 dpq080_new, missing

*dpq090 - thoughts you would be better off dead
gen dpq090_new = dpq090
replace dpq090_new =. if dpq090 == 7 | dpq090 == 9 | dpq090 ==.
tab dpq090
tab dpq090_new
*crosstab and include missing
tab2 dpq090 dpq090_new, missing

tab1 dpq010_new-dpq090_new
tab1 dpq010_new-dpq090_new, missing

/* Create dichotomous variables */

*dpq010 - have little interest in doing things
gen dpq010_new = dpq010_new
replace dpq010_cat2 = 0 if dpq010_new == 0 | dpq010_new == 1
replace dpq010_cat2 = 1 if dpq010_new == 2 | dpq010_new == 3
*crosstab of the old and new variable to check the recode
tab dpq010_new dpq010_cat2
*one-way tables for each of the variables
tab dpq010_new dpq010_cat2

*dpq020 - feeling down, depressed, or hopeless
gen dpq020_new = dpq020_new
replace dpq020_cat2 = 0 if dpq020_new == 0 | dpq020_new == 1
replace dpq020_cat2 = 1 if dpq020_new == 2 | dpq020_new == 3
*crosstab of the old and new variable to check the recode
tab dpq020_new dpq020_cat2
*one-way tables for each of the variables
tab dpq020_new dpq020_cat2

*dpq030 - trouble sleeping or sleeping too much
gen dpq030_new = dpq030_new
replace dpq030_cat2 = 0 if dpq030_new == 0 | dpq030_new == 1
replace dpq030_cat2 = 1 if dpq030_new == 2 | dpq030_new == 3
*crosstab of the old and new variable to check the recode
tab dpq030_new dpq030_cat2
*one-way tables for each of the variables
tab dpq030_new dpq030_cat2

*dpq040 - feeling tired or having little energy
gen dpq040_new = dpq040_new
replace dpq040_cat2 = 0 if dpq040_new == 0 | dpq040_new == 1
replace dpq040_cat2 = 1 if dpq040_new == 2 | dpq040_new == 3
*crosstab of the old and new variable to check the recode
tab dpq040_new dpq040_cat2
*one-way tables for each of the variables
tab dpq040_new dpq040_cat2

*dpq050 - poor appetite or overeating
gen dpq050_new = dpq050_new
replace dpq050_cat2 = 0  if dpq050_new == 0 | dpq050_new == 1
replace dpq050_cat2 = 1 if dpq050_new == 2 | dpq050_new == 3
*crosstab of the old and new variable to check the recode
tab dpq050_new dpq050_cat2
*one-way tables for each of the variables
tab dpq050_new dpq050_cat2

*dpq060 - feeling bad about yourself
gen dpq060_new = dpq060_new
replace dpq060_cat2 = 0 if dpq060_new == 0 | dpq060_new == 1
replace dpq060_cat2 = 1 if dpq060_new == 2 | dpq060_new == 3
*crosstab of the old and new variable to check the recode
tab dpq060_new dpq060_cat2
*one-way tables for each of the variables
tab dpq060_new dpq060_cat2

*dpq070 - trouble concentrating on things
gen dpq070_new = dpq070_new
replace dpq070_cat2 = 0 if dpq070_new == 0 | dpq070_new == 1
replace dpq070_cat2 = 1 if dpq070_new == 2 | dpq070_new == 3
*crosstab of the old and new variable to check the recode
tab dpq070_new dpq070_cat2
*one-way tables for each of the variables
tab dpq070_new dpq070_cat2

*dpq080 - moving or speaking slowly or too fast
gen dpq080_new = dpq080_new
replace dpq080_cat2 = 0 if dpq080_new == 0 | dpq080_new == 1
replace dpq080_cat2 = 1 if dpq080_new == 2 | dpq080_new == 3
*crosstab of the old and new variable to check the recode
tab dpq080_new dpq080_cat2
*one-way tables for each of the variables
tab dpq080_new dpq080_cat2

*dpq090 - thourhgts you would be better off dead
gen dpq090_new = dpq090_new
replace dpq090_cat2 = 0 if dpq090_new == 0 | dpq090_new == 1
replace dpq090_cat2 = 1 if dpq090_new == 2 | dpq090_new == 3
*crosstab of the old and new variable to check the recode
tab dpq090_new dpq090_cat2
*one-way tables for each of the variables
tab dpq090_new dpq090_cat2

/* Create a PHQ-9 score */

*this method of summation will give a total score regardless of whether any of the depression items are missing responses
egen depression_score = rowtotal (dpq010_new dpq020_new dpq030_new dpq040_new dpq050_new dpq060_new dpq070_new dpq080_new dpq090_new)

*this method will yield a missing total if any of the items being summed are missing. this may be the better approach, depending on the measure, etc
gen sumvar2 = dpq010_new + dpq020_new + dpq030_new + dpq040_new + dpq050_new + dpq060_new + dpq070_new + dpq080_new + dpq090_new

tab depression_score sumvar2, missing

/* c. Create a histogram and boxplot of the depression sum score. 
*/
histogram depression_score, title("") xtitle("Depression Score") ytitle("Density")

/* d. What is the mean, standard deviation, median, and interquartile range for depression sum score?
The mean is 2.88, standard deviation is 4.12, median is 1, and IQR is 0-4. 
*/

*compute mean (SD) and median (IQR) of depression score (continuous)
tab depression_score, missing
summarize depression_score, detail

*create a new variable for dicotomized depressioon score with 0-9 = 0 (no depression) and >= 10 = 1 (depression)
gen depression_binary =.
replace depression_binary = 0 if depression_score >= 0 & depression_score <= 9
replace depression_binary = 1 if depression_score >= 10 & depression_score <= 27

*run a crosstab of this dichotomous variable against the sum score to double check that all coding is done correctly

*label the variables
label define depress 0 "No Depression" 1 "Depression"
label value depression_binary depress
tab2 depression_score depression_binary

*run frequencies for depression for total sample size
tab depression_binary, missing

/* e. What is the prevalence of depressive symptoms using the dichotomous variable?
The prevalence of depressive symptoms is 621/7812 (7.95%). 
*/

*****************************
*Part E Bivariable Analysis*
***************************** 

/* Table 2 */

*run frequencies between edcuation level and outcome/covariates/sociodemographic variables
tab dmdeduc2_new riagendr, all row col
tab dmdeduc2_new ridageyr_new, all row col
tab dmdeduc2_new ridreth_new, all row col
tab dmdeduc2_new dmdmartz_new, all row col
tab dmdeduc2_new indfmpir_new, all row col
tab dmdeduc2_new hiq011_new, all row col

*run chi-squared test and p-values between edcuation level and outcome/covariates/sociodemographic variables
tab dmdeduc2_new riagendr, chi2
tab dmdeduc2_new ridageyr_new, chi2
tab dmdeduc2_new ridreth_new, chi2
tab dmdeduc2_new dmdmartz_new, chi2
tab dmdeduc2_new indfmpir_new, chi2
tab dmdeduc2_new hiq011_new, chi2

*compute mean (SD), median (IQR), p-values between depression and education level
sort dmdeduc2_new
by dmdeduc2_new: summarize depression_score, detail
anova dmdeduc2_new depression_score

*run freqeuncies between depression and education level
tab dmdeduc2_new depression_binary, all row col

/* Table 3a */

*run frequencies between depression and exposure/covariates/sociodemographic variables
tab depression_binary riagendr, all row col
tab depression_binary ridageyr_new, all row col
tab depression_binary ridreth_new, all row col
tab depression_binary dmdeduc2_new, all row col
tab depression_binary dmdmartz_new, all row col
tab depression_binary indfmpir_new, all row col
tab depression_binary hiq011_new, all row col

*run chi-squared test and p-values between depression and exposure/covariates/sociodemographic variables
tab depression_binary riagendr, chi2
tab depression_binary ridageyr_new, chi2
tab depression_binary ridreth_new, chi2
tab depression_binary dmdeduc2_new, chi2
tab depression_binary dmdmartz_new, chi2
tab depression_binary indfmpir_new, chi2
tab depression_binary hiq011_new, chi2

/* Table 3b */

*compute mean (SD) & p-values between depression and gender
sort riagendr
by riagendr: summarize depression_score, detail
anova riagendr sumvar

*compute mean (SD) & p-values between depression and age
sort ridageyr_new
by ridageyr_new: summarize depression_score, detail
anova ridageyr_new sumvar

*compute mean (SD) & p-values between depression and race/ethnicity
sort ridreth_new
by ridreth_new: summarize depression_score, detail
anova ridreth_new sumvar

*compute mean (SD) & p-values between depression and education level
sort dmdeduc2_new
by dmdeduc2_new: summarize depression_score, detail
anova dmdeduc2_new sumvar

*compute mean (SD) & p-values between depression and marital status
sort dmdmartz_new
by dmdmartz_new: summarize depression_score, detail
anova dmdmartz_new sumvar

*compute mean (SD) & p-values between depression and ratio of family income to poverty
sort indfmpir_new
by indfmpir_new: summarize depression_score, detail
anova indfmpir_new sumvar

*compute mean (SD) & p-values between depression and health insurance coverage
sort hiq011_new
by hiq011_new: summarize depression_score, detail
anova hiq011_new sumvar

********************************
*Part G Multivariable Analysis*
******************************** 

/* Table 4a */

*calculate crude OR (95% CI)
logistic depression_binary i.riagendr
logistic depression_binary i.ridageyr_new
logistic depression_binary i.ridreth_new
logistic depression_binary i.dmdeduc2_new
logistic depression_binary i.dmdmartz_new
logistic depression_binary i.indfmpir_new
logistic depression_binary i.hiq011_new

*calculate adjusted OR for full model 1 (95% CI)
logistic depression_binary i.dmdeduc2_new ib3.ridageyr_new i.ridreth_new i.hiq011_new i. riagendr i.indfmpir_new i.dmdmartz_new

*calculate adjusted OR for full model 2 (95% CI)
logistic depression_binary i.ridageyr_new i.ridreth_new i.hiq011_new i.indfmpir_new i.dmdmartz_new i.dmdeduc2_new##i.riagendr

/* Table 4b */

*calculate beta (SE) and p-value for unjusted model
regress depression_score i.riagendr
regress depression_score i.ridageyr_new
regress depression_score i.ridreth_new
regress depression_score i.dmdeduc2_new
regress depression_score i.dmdmartz_new
regress depression_score i.indfmpir_new
regress depression_score i.hiq011_new

*calculuate beta (SE) and p-value for full model 1
regress depression_score i.dmdeduc2_new ib3.ridageyr_new i.ridreth_new i.hiq011_new i. riagendr i.indfmpir_new i.dmdmartz_new

*calculuate beta (SE) and p-value for full model 2
regress depression_score i.ridageyr_new i.ridreth_new i.hiq011_new i.indfmpir_new i.dmdmartz_new i.dmdeduc2_new##i.riagendr
