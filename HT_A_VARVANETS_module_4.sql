use SalesOrders
go
select Distinct CustCity
from  Orders inner join Customers
on Orders.CustomerID = Customers.CustomerID
Go


Select  EmpFirstName,EmpLastName, EmpPhoneNumber
from dbo.Employees
Order by EmpFirstName ASC
Go


select  Distinct Products.CategoryID, CategoryDescription
from  Products inner join Categories
on Products.CategoryID = Categories.CategoryID
go


select Distinct ProductName,CategoryID,RetailPrice
from  Products inner join Product_Vendors
on Products.ProductNumber = Product_Vendors.ProductNumber
inner join Vendors
on Product_Vendors.VendorID =  Vendors.VendorID
Order by ProductName ASC
go



select VendZipCode, VendName
from  dbo.Vendors 
Order by VendZipCode ASC
go


Select  EmployeeID, EmpLastName,EmpFirstName, EmpPhoneNumber
from dbo.Employees
Order by EmpLastName  ASC, EmpFirstName ASC
GO


Select  VendName
from dbo.Vendors
Order by VendName asc 
GO


select Distinct CustState
from  Orders inner join Customers
on Orders.CustomerID = Customers.CustomerID
Go


Select  Distinct ProductName,RetailPrice
from  Products inner join Order_Details
on Products.ProductNumber = Order_Details.ProductNumber
Order by ProductName ASC
Go


Select  dbo.Employees.EmployeeID, EmpFirstName,  EmpLastName ,   EmpStreetAddress ,  EmpCity ,  EmpState ,  EmpZipCode ,  EmpAreaCode ,  EmpPhoneNumber , Orders.OrderNumber, CustomerID, Products.ProductNumber, products.CategoryID, CategoryDescription, vendors.vendorid
from dbo.Employees inner join dbo.Orders
on Employees.EmployeeID = Orders.EmployeeID
inner join Order_Details 
on orders.OrderNumber = Order_Details.OrderNumber
inner join Products
on Order_Details.ProductNumber = Products.ProductNumber
inner join Product_Vendors
on Products.ProductNumber = Product_Vendors.ProductNumber
inner join Vendors
on Product_Vendors.VendorID =  Vendors.VendorID
inner join Categories
on Products.CategoryID=Categories.CategoryID
Order by EmployeeID ASC
Go


Select Distinct  VendCity, VendName
from dbo.Employees inner join dbo.Orders
on Employees.EmployeeID = Orders.EmployeeID
inner join Order_Details 
on orders.OrderNumber = Order_Details.OrderNumber
inner join Products
on Order_Details.ProductNumber = Products.ProductNumber
inner join Product_Vendors
on Products.ProductNumber = Product_Vendors.ProductNumber
inner join Vendors
on Product_Vendors.VendorID =  Vendors.VendorID
order by VendCity ASC
go


Select   OrderNumber,  Max (DaysToDeliver) as DaysToDeliver
from Order_Details inner join Products
on Order_Details.ProductNumber = Products.ProductNumber
inner join Product_Vendors
on Products.ProductNumber = Product_Vendors.ProductNumber
Group by OrderNumber
Order by OrderNumber asc
Go


Select ProductNumber, ProductName, (RetailPrice*QuantityOnHand)    AS Price
From Products
Go


with OrdersDel
  (OrderNumber, DaysToDeliver)
as
(Select   OrderNumber,  Max (DaysToDeliver) as DaysToDeliver
from Order_Details inner join Products
on Order_Details.ProductNumber = Products.ProductNumber
inner join Product_Vendors
on Products.ProductNumber = Product_Vendors.ProductNumber
Group by OrderNumber

union

SELECT OrderNumber, DATEDIFF(day, OrderDate, ShipDate) AS 'VendorDate'  
FROM dbo.Orders)

Select OrderNumber, SUM (DaysToDeliver) as DaysToDeliver
From OrdersDel
Group by OrderNumber
go




; with  ROWCTE (row_no) AS
(
Select row_no = 1
Union all
Select row_no + 1 From ROWCTE where row_no<10000
)
Select*From ROWCTE 
Option (maxrecursion 10000)
go



; with rs (D, name ) as
(  SELECT cast ('20190101' as date) as D, datename (WEEKDAY, '20190101')
UNION ALL
  SELECT dateadd(day,1,D), datename(WEEKDAY,dateadd(day,1,D)) from rs
  WHERE D<'20191231'
),

rs1 as
(
  SELECT D, name FROM rs
  WHERE name in ('Saturday', 'Sunday')
)

SELECT count(*) as 'DAY OFF' FROM rs1
option (maxrecursion 365)
go   
