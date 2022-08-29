/* 
Exploring Videos Games Sales Data
found on https://www.kaggle.com/datasets/pranavkrishna/vgsales
*/


--Overview

Select *
from PortfolioProject..vgsales


--Overall Global Sales highest to lowest

select *
from PortfolioProject..vgsales
order by Global_Sales desc


--How much each region makes up of the overall sales

select name, year, EU_Sales, global_sales, 
(EU_Sales / Global_Sales) * 100 PercentageEU
from PortfolioProject..vgsales
where EU_Sales != 0
order by 5 desc

select name, year, NA_Sales, global_sales, 
(NA_Sales / Global_Sales) * 100 PercentageNA
from PortfolioProject..vgsales
where NA_Sales != 0
AND name NOT LIKE '%(US sales)' 
order by 5 desc

select name, year, JP_Sales, global_sales, 
(JP_Sales / Global_Sales) * 100 PercentageJP
from PortfolioProject..vgsales
where JP_Sales != 0
order by 5 desc

--"Other" refers to sales outside of NA, EU, and JP

select name, year, Other_Sales, global_sales, 
(Other_Sales / Global_Sales) * 100 PercentageOther
from PortfolioProject..vgsales
where Other_Sales != 0
order by 5 desc


--How many games each publisher has released

select Publisher, count(publisher) PublishedGames
from PortfolioProject..vgsales
group by Publisher
order by 2 desc


--Best selling game for each publisher

select Publisher, Name, Global_sales, Game_Rank
from(
select Publisher, Name, Global_sales,
rank() over (partition by publisher order by global_sales desc) as Game_Rank
--Replace Global_Sales with any region to get their respective best seller
from PortfolioProject..vgsales
) a
where Global_Sales > 500
AND Game_Rank = 1
order by Global_Sales desc