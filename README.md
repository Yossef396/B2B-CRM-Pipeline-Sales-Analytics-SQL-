
# B2B CRM Pipeline & Sales Analytics (SQL)

## 📌 Project Overview
This project models a relational **B2B CRM (Customer Relationship Management) Database** to analyze sales pipelines, deal stages, and revenue generation. Built with a Business Development and Sales Operations focus, it demonstrates core data analytics skills—including relational table design, multi-table inner joins, and conditional grouping.

---

## 🗄️ Database Schema
The database consists of three normalized relational tables linked via Primary and Foreign Keys:
1. **`accounts`**: Stores company profiles, target industries, and annual revenues.
2. **`contacts`**: Stores key decision-maker contact details linked to accounts.
3. **`deals`**: Tracks sales opportunities, pipeline stages, deal values, and close dates.

---

## 💻 SQL Queries & Code Implementation

Below are the analytical queries built to evaluate sales performance and pipeline health:

### 1. Pipeline Value by Stage
*Evaluates total potential revenue and deal count across each phase of the sales funnel.*
```sql
select deal_stage,
count(deal_stage) as total_deals,
sum(deal_value)as total_potential
from deals
group by deal_stage
order by total_potential
DESC;

2. Won Revenue by Industry
Calculates closed-won revenue generated across different market sectors.

SQL
select industry, 
sum(annual_revenue) as total_won
from deals d
inner join accounts a
on a.account_id=d.account_id
where deal_stage='Closed Won'
group by industry
order by total_won
DESC;

3. Account 360 View (3-Table Join)
Combines account profiles, contact persons, and deal statuses into a comprehensive audit report using multi-table inner joins.

SQL
select 
company_name, contact_name, deal_name, deal_stage,deal_value
from accounts a 
inner join deals d 
on d.account_id=a.account_id
inner join contacts c
on c.account_id=a.account_id;

📈 Key Business Insights
Pipeline Visibility: Query 1 provides a clear breakdown of where deals sit in the funnel, sorting potential revenue to highlight high-value stages.

Vertical Performance: Query 2 filters strictly for successful sales (Closed Won) to isolate which industry sectors drive the most return.

Relational Integrity: Query 3 successfully bridges disconnected CRM entities (accounts, contacts, and deals) into a single 360-degree reporting view.

🚀 How to Run
Clone this repository or open your SQL workspace (such as MySQL Workbench).

Execute the setup script in crm_pipeline_analysis.sql to create the tables, insert sample data, and run the analytical queries.
