# Amstrad Mobile – SQL-Powered Upsell Email Campaign

## Project Overview

A SQL-driven upsell email campaign developed in Salesforce Marketing Cloud for Amstrad Mobile, a fictional telecommunications brand.

The "Upgrade & Save" campaign identifies eligible customers, compares their current mobile plans against two available upgrade options, and generates personalized recommendations based on recent data usage.

The solution prepares all required personalization fields within a single Sending Data Extension, minimizing the need for complex AMPscript during email development.

## Business Objective

Encourage existing customers to upgrade to higher-value mobile plans by presenting relevant offers, additional data allowances, monthly price differences, and personalized upgrade links.

## Campaign Type

- Ad-hoc single-send email campaign
- SQL-based audience segmentation
- Personalized mobile plan recommendations
- Automation Studio audience preparation

## Target Audience

The campaign targets customers who:

- Have an active lifecycle status
- Have opted into marketing emails
- Have available upgrade options
- Have an Average Revenue Per User (ARPU) of at least 10
- Are not currently subscribed to plans P120, P145, P098, or P119
- Are not linked to blocked upgrade plans P120 or P200

## Technical Skills Demonstrated

- SQL Query Activities
- Multiple INNER JOINs
- Table Aliases
- CASE Statements
- CONCAT Function
- Calculated Fields
- WHERE Conditions
- NOT IN Operator
- Audience Segmentation
- Data Extension Management
- Automation Studio

## Data Extensions

| Data Extension | Purpose |
|---|---|
| CustomerBase | Stores customer profiles, current plan IDs, email consent, average data usage, and ARPU. |
| PlanMatrix | Stores mobile plan details, pricing, data allowances, upgrade paths, and deep links. |
| Upsell_Sending | Stores the qualified campaign audience and personalized upgrade information. |

## Project Walkthrough

### Step 1: Data Extension Setup

The CustomerBase and PlanMatrix Data Extensions provide the source data required for customer qualification and mobile plan comparisons.

The Upsell_Sending Data Extension is configured to store the final campaign audience and all required personalization fields.

### Step 2: Audience Qualification

SQL filtering conditions identify eligible customers based on lifecycle status, email consent, ARPU, current plan restrictions, and available upgrade paths.

Customers who do not meet the campaign requirements are excluded from the final audience.

### Step 3: Mobile Plan Mapping

Multiple INNER JOINs are used to reference the PlanMatrix Data Extension and retrieve:

- The customer's current mobile plan
- Upgrade Plan A
- Upgrade Plan B

Each plan is referenced using a separate table alias.

### Step 4: Data and Price Calculations

Calculated fields determine the differences between the customer's current plan and each available upgrade.

The calculations include:

- Additional data allowance for Upgrade A
- Monthly price difference for Upgrade A
- Additional data allowance for Upgrade B
- Monthly price difference for Upgrade B

### Step 5: Personalized Upgrade Links

The CONCAT function combines each upgrade plan's DeepLinkBase with the customer's ContactKey to generate personalized upgrade URLs.

These URLs support customer-specific calls to action within the email.

### Step 6: Recommended Plan Logic

A CASE statement determines the recommended upgrade based on the customer's average data usage over the previous 90 days.

| Condition | Recommended Plan |
|---|---|
| Average data usage exceeds Upgrade A's data allowance | Upgrade B |
| Average data usage is within Upgrade A's data allowance | Upgrade A |

### Step 7: Automation Studio

A SQL Query Activity combines audience qualification, plan mapping, calculated fields, personalized URLs, and recommendation logic into a single query.

The resulting records are populated into the Upsell_Sending Data Extension.

## SQL Query

| SQL File | Purpose |
|---|---|
| Upsell_Sending.sql | Qualifies customers, retrieves upgrade options, calculates data and price differences, generates personalized URLs, and determines the recommended plan. |

## Project Outcome

The solution consolidates customer eligibility, mobile plan comparisons, personalized upgrade recommendations, and dynamic links into a campaign-ready Sending Data Extension.

By preparing personalization fields through SQL, the solution reduces the complexity of email development and supports consistent campaign targeting.

## Tools and Technologies

- Salesforce Marketing Cloud
- SQL
- Email Studio
- Automation Studio
- Data Extensions
- GitHub

## Project Context

This project was completed as part of the AMPscript Academy SQL Capstone program using a fictional business scenario and sample data.

