select * from bank_loan_data;


SELECT COUNT(id) AS Total_Applications FROM bank_loan_data;

SELECT COUNT(id) AS Curr_Total_Applications FROM bank_loan_data
WHERE MONTH(issue_date) = 12;

SELECT COUNT(id) AS Previous_Total_Applications FROM bank_loan_data
WHERE MONTH(issue_date) = 11;

SELECT 
    ROUND(
        ((SELECT COUNT(id) FROM bank_loan_data 
          WHERE MONTH(issue_date) = 12) -
         (SELECT COUNT(id) FROM bank_loan_data 
          WHERE MONTH(issue_date) = 11))/
        CAST((SELECT COUNT(id) FROM bank_loan_data 
              WHERE MONTH(issue_date) = 11) AS DECIMAL), 4 
    )*100 AS MoM;



SELECT SUM(loan_amount) as Total_Funded_Amount FROM bank_loan_data;

SELECT SUM(loan_amount) AS MTD_Total_Funded_Amount FROM bank_loan_data
WHERE MONTH(issue_date) = 12;

SELECT SUM(loan_amount) AS PMTD_Total_Funded_Amount FROM bank_loan_data
WHERE MONTH(issue_date) = 11;



SELECT SUM(total_payment) AS Total_Amount_Collected FROM bank_loan_data;

SELECT SUM(total_payment) AS Total_Amount_Collected FROM bank_loan_data
WHERE MONTH(issue_date) = 12;

SELECT SUM(total_payment) AS Total_Amount_Collected FROM bank_loan_data
WHERE MONTH(issue_date) = 11;



SELECT ROUND(AVG(int_rate),4)*100 AS Avg_Interest_Rate FROM bank_loan_data;

SELECT ROUND(AVG(int_rate),4)*100 AS MTD_Avg_Int_Rate FROM bank_loan_data
WHERE MONTH(issue_date) = 12;

SELECT ROUND(AVG(int_rate),4)*100 AS PMTD_Avg_Int_Rate FROM bank_loan_data
WHERE MONTH(issue_date) = 11;



SELECT ROUND(AVG(dti),4)*100 AS Avg_DTI FROM bank_loan_data;
 
SELECT ROUND(AVG(dti),4)*100 AS MTD_Avg_DTI FROM bank_loan_data
WHERE MONTH(issue_date) = 12;

SELECT ROUND(AVG(dti),4)*100 AS PMTD_Avg_DTI FROM bank_loan_data
WHERE MONTH(issue_date) = 11;



SELECT
(COUNT(CASE WHEN loan_status ='Fully Paid' or loan_status ='current' THEN id END)*100.0)/
COUNT(id) as Good_loan_percentage
FROM bank_loan_data;

SELECT COUNT(id) AS Good_Loan_Applications FROM bank_loan_data
WHERE loan_status = 'Fully Paid' OR loan_status = 'Current';

SELECT SUM(loan_amount) AS Good_Loan_Funded_amount FROM bank_loan_data
WHERE loan_status = 'Fully Paid' OR loan_status = 'Current';

SELECT SUM(total_payment) AS Good_Loan_amount_received FROM bank_loan_data
WHERE loan_status = 'Fully Paid' OR loan_status = 'Current';



SELECT
    (COUNT(CASE WHEN loan_status = 'Charged Off' THEN id END) * 100.0) / 
	COUNT(id) AS Bad_Loan_Percentage
FROM bank_loan_data;

SELECT COUNT(id) AS Bad_Loan_Applications FROM bank_loan_data
WHERE loan_status = 'Charged Off'

SELECT SUM(loan_amount) AS Bad_Loan_Funded_amount FROM bank_loan_data
WHERE loan_status = 'Charged Off'

SELECT SUM(total_payment) AS Bad_Loan_amount_received FROM bank_loan_data
WHERE loan_status = 'Charged Off'



SELECT
        loan_status,
        COUNT(id) AS LoanCount,
        SUM(total_payment) AS Total_Amount_Received,
        SUM(loan_amount) AS Total_Funded_Amount,
        AVG(int_rate * 100) AS Interest_Rate,
        AVG(dti * 100) AS DTI
    FROM
        bank_loan_data
    GROUP BY
        loan_status;



SELECT 
    loan_status,
    SUM(CASE WHEN MONTH(issue_date)=12
             THEN total_payment ELSE 0 END) AS MTD_Total_Amount_Received,
    SUM(CASE WHEN MONTH(issue_date) = 11
             THEN total_payment ELSE 0 END) AS PMTD_Total_Amount_Received,
    SUM(CASE WHEN MONTH(issue_date)=12
             THEN loan_amount ELSE 0 END) AS MTD_Total_Funded_Amount,
    SUM(CASE WHEN MONTH(issue_date) = 11
             THEN loan_amount ELSE 0 END) AS PMTD_Total_Funded_Amount,
    (SUM(CASE WHEN MONTH(issue_date) = 12
              THEN total_payment ELSE 0 END) -
     SUM(CASE WHEN MONTH(issue_date) = 11
              THEN total_payment ELSE 0 END))*1.0 / 
     NULLIF(SUM(CASE WHEN MONTH(issue_date) = 11
              THEN total_payment ELSE 0 END),0) * 100 AS MoM_Change_Percentage_Amount_Received,
    (SUM(CASE WHEN MONTH(issue_date) =12
              THEN loan_amount ELSE 0 END) -
     SUM(CASE WHEN MONTH(issue_date) = 11
              THEN loan_amount ELSE 0 END))*1.0 / 
     NULLIF(SUM(CASE WHEN MONTH(issue_date) =11
              THEN loan_amount ELSE 0 END),0) * 100 AS MoM_Change_Percentage_Funded_Amount
FROM 
    bank_loan_data
GROUP BY 
    loan_status;



SELECT 
	MONTH(issue_date) AS Month_Munber, 
	DATENAME(MONTH, issue_date) AS Month_name, 
	COUNT(id) AS Total_Loan_Applications,
	SUM(loan_amount) AS Total_Funded_Amount,
	SUM(total_payment) AS Total_Amount_Received
FROM bank_loan_data
GROUP BY MONTH(issue_date), DATENAME(MONTH, issue_date)
ORDER BY MONTH(issue_date)



SELECT 
	address_state AS State, 
	COUNT(id) AS Total_Loan_Applications,
	SUM(loan_amount) AS Total_Funded_Amount,
	SUM(total_payment) AS Total_Amount_Received
FROM bank_loan_data
GROUP BY address_state
ORDER BY address_state



SELECT 
	term AS Term, 
	COUNT(id) AS Total_Loan_Applications,
	SUM(loan_amount) AS Total_Funded_Amount,
	SUM(total_payment) AS Total_Amount_Received
FROM bank_loan_data
GROUP BY term
ORDER BY term



SELECT 
	emp_length AS Employee_Length, 
	COUNT(id) AS Total_Loan_Applications,
	SUM(loan_amount) AS Total_Funded_Amount,
	SUM(total_payment) AS Total_Amount_Received
FROM bank_loan_data
GROUP BY emp_length
ORDER BY emp_length



SELECT 
	purpose, 
	COUNT(id) AS Total_Loan_Applications,
	SUM(loan_amount) AS Total_Funded_Amount,
	SUM(total_payment) AS Total_Amount_Received
FROM bank_loan_data
GROUP BY purpose
ORDER BY purpose



SELECT 
	home_ownership AS Home_Ownership, 
	COUNT(id) AS Total_Loan_Applications,
	SUM(loan_amount) AS Total_Funded_Amount,
	SUM(total_payment) AS Total_Amount_Received
FROM bank_loan_data
GROUP BY home_ownership
ORDER BY home_ownership

