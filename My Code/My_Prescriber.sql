Select *
From prescriber

Select *
from prescription

Select *
From cbsa

Select *
from drug

Select *
From fips_county

Select *
from overdoses

Select *
From population

Select *
from zip_fips

-- 1a a. Which prescriber had the highest total number of claims (totaled over all drugs)? Report the npi and the total number of claims. b. Repeat the above, but this time report the nppes_provider_first_name, nppes_provider_last_org_name, specialty_description, and the total number of claims.
--Answer: Npi: 1881634483 with 99707 claims **Edit after walkthrough

Select p1.npi, sum(total_claim_count) as total_claim_count
From prescription as p1
Left Join prescriber as p2
on p1.npi = p2.npi
Group by p1.npi
Order by total_claim_count DESC

--1b Bruce Pendley, Family Practice 99707 claims **edit after walkthrough

Select p1.npi, sum(total_claim_count) as total_claim_count, p2.nppes_provider_first_name, p2.nppes_provider_last_org_name, p2.specialty_description
From prescription as p1
Inner Join prescriber as p2
on p1.npi = p2.npi
Group by p1.npi, p2.nppes_provider_first_name, p2.nppes_provider_last_org_name, p2.specialty_description
Order by total_claim_count DESC


--2a Which specialty had the most total number of claims (totaled over all drugs)?
-- There 9752347 total claims by Family Practice


Select sum(total_claim_count) as total_claim, p2.specialty_description
from prescription as p1
Left Join prescriber as p2
on p1.npi = p2.npi
group by p2.specialty_description
order by total_claim DESC;


--2b. Which specialty had the most total number of claims for opioids?
--Nurse Practitioner has the most opiods with 900845 claims.

Select sum(total_claim_count) as total_claim, p2.specialty_description
from prescription as p1
Left Join prescriber as p2
on p1.npi = p2.npi
Left Join drug as d
on p1.drug_name = d.drug_name
where d.opioid_drug_flag = 'Y'
group by p2.specialty_description
order by total_claim DESC;


--3a.Which drug (generic_name) had the highest total drug cost?
-- Insulin Glargine,Hum.Rec.ANLOG with a total cost of 104264066.35

Select sum(total_drug_cost) as total_cost, d.generic_name
from prescription as p
Left Join drug as d
on p.drug_name = d.drug_name
where total_drug_cost is not NULL
group by d.generic_name
order by total_cost DESC

--3b. b. Which drug (generic_name) has the hightest total cost per day? **Bonus: Round your cost per day column to 2 decimal places. Google ROUND to see how this works.
-- C1 ESTERASE INHIBITOR has the highest total cost per day at 3495 --edit through walkthrough


Select round(sum(total_drug_cost)/sum(total_day_supply)) as per_day, d.generic_name
from prescription as p
Left Join drug as d
on p.drug_name = d.drug_name
group by d.generic_name
order by per_day DESC

--4a. For each drug in the drug table, return the drug name and then a column named 'drug_type' which says 'opioid' for drugs which have opioid_drug_flag = 'Y', says 'antibiotic' for those drugs which have antibiotic_drug_flag = 'Y', and says 'neither' for all other drugs.


Select d.drug_name,
CASE WHEN opioid_drug_flag = 'Y' Then 'opioid'
when antibiotic_drug_flag = 'Y' Then 'antibiotic'
Else 'neither' END as drug_type
from drug as d
Left Join prescription as p
on d.drug_name = p.drug_name
group by d.drug_name, drug_type

-- 4b. Building off of the query you wrote for part a, determine whether more was spent (total_drug_cost) on opioids or on antibiotics. Hint: Format the total costs as MONEY for easier comparision.
--didnt finish
Select d.drug_name, 
CASE when antibiotic_drug_flag = 'Y' Then 'antibiotic'
Else 'neither' END as antibiotic_money,
CASE WHEN opioid_drug_flag = 'Y' Then 'opioid'
Else 'neither' END as opioid_money
from drug as d
Left Join prescription as p
on d.drug_name = p.drug_name
group by d.drug_name

--FInished here, was getting close. all other answers are from walk through


-- 5a.How many CBSAs are in Tennessee? Warning: The cbsa table contains information for all states, not just Tennessee.

















