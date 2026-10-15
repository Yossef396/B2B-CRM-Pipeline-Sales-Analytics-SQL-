-- ==========================================================
-- B2B CRM Pipeline & Sales Analytics
-- Combined Execution Script
-- ==========================================================

-- ----------------------------------------------------------
-- STEP 1: CREATE TABLES (Database Schema)
-- ----------------------------------------------------------

CREATE TABLE accounts (
    account_id INT PRIMARY KEY,
    company_name VARCHAR(100),
    industry VARCHAR(50),
    annual_revenue DECIMAL(12,2)
);

CREATE TABLE contacts (
    contact_id INT PRIMARY KEY,
    account_id INT,
    contact_name VARCHAR(50),
    email VARCHAR(100),
    FOREIGN KEY (account_id) REFERENCES accounts(account_id)
);

CREATE TABLE deals (
    deal_id INT PRIMARY KEY,
    account_id INT,
    deal_name VARCHAR(100),
    deal_stage VARCHAR(30),
    deal_value DECIMAL(10,2),
    close_date DATE,
    FOREIGN KEY (account_id) REFERENCES accounts(account_id)
);

-- ----------------------------------------------------------
-- STEP 2: INSERT SAMPLE DATA
-- ----------------------------------------------------------

INSERT INTO accounts VALUES 
(1, 'Apex Global', 'Technology', 5000000.00),
(2, 'BlueSky Logistics', 'Transportation', 1200000.00),
(3, 'Nexus Health', 'Healthcare', 8500000.00),
(4, 'Vanguard Media', 'Marketing', 900000.00);

INSERT INTO contacts VALUES 
(101, 1, 'Sarah Miller', 'sarah@apex.com'),
(102, 2, 'James Wilson', 'jwilson@bluesky.com'),
(103, 3, 'Dr. Marcus Vance', 'mvance@nexus.com'),
(104, 4, 'Chloe Davis', 'chloe@vanguard.com');

INSERT INTO deals VALUES 
(501, 1, 'Apex Cloud Migration', 'Closed Won', 45000.00, '2026-01-15'),
(502, 2, 'BlueSky Fleet SaaS', 'Closed Lost', 12000.00, '2026-02-01'),
(503, 3, 'Nexus EHR Integration', 'Proposal', 120000.00, '2026-03-10'),
(504, 4, 'Vanguard Analytics Suite', 'Closed Won', 28000.00, '2026-03-20'),
(505, 1, 'Apex Security Add-on', 'Prospecting', 15000.00, '2026-04-05');

-- ----------------------------------------------------------
-- STEP 3: YOUR ANALYTICAL QUERIES
-- ----------------------------------------------------------

-- Query 1: Pipeline Value by Stage
select deal_stage,
count(deal_stage) as total_deals,
sum(deal_value)as total_potential
from deals
group by deal_stage
order by total_potential
DESC;

-- Query 2: Won Revenue by Industry
select industry, 
sum(annual_revenue) as total_won
from deals d
inner join accounts a
on a.account_id=d.account_id
where deal_stage='Closed Won'
group by industry
order by total_won
DESC;

-- Query 3: Account 360 View (3-Table Join)
select 
company_name, contact_name, deal_name, deal_stage,deal_value
from accounts a 
inner join deals d 
on d.account_id=a.account_id
inner join contacts c
on c.account_id=a.account_id;