Create Database HRAnalytics
Go
Use HRAnalytics
Go
Create Schema [Security]
Go
Create Schema Employee
Go
Create Schema Department
GO
--Is just for testing purpose
Create Table Employee.[Address]
(
	AddressID int not null Primary Key,
	AddressName Varchar(250) not null,
	City Varchar(50) not null,
	Province varchar(50) not null,
	ZipCode Varchar(6) not null
)
Go
Create Table Employee.Employees
(
	EmployeesID int not null Primary Key,
	[Name] Varchar(50) not null,
	LastName Varchar(50) not null,
	AddressID int not null,
	Gender Varchar(2) not null,
	Dateofbirth date not null,
	PhoneNumber Varchar(15) not null,
	MaritalStatus Varchar(15) not null,
	[Status] Tinyint not null,
	StartDate date not null,
	EndDate date not null,
	VacationDays int not null
)
	ALTER TABLE Employee.Employees  
	WITH CHECK ADD  CONSTRAINT [FK_Employees_Address] FOREIGN KEY([AddressID])
	REFERENCES Employee.[Address] ([AddressID])

Go
Create table [Security].[Roles](	RoleID int NOT NULL Primary KEY,	RoleName Varchar(50) NOT NULL,	[Status] Tinyint NOT NULL)
Go
Create table [Security].[Permissions]
(
	PermissionsID Int NOT NULL PRIMARY KEY,
	PermissionsName Varchar(50)
)
Go
Create table [Security].[RolesPermissions]
(
	RolePermissionsID int NOT NULL PRIMARY KEY,
	RoleID int,
	PermissionsID Int
)
Go
	ALTER TABLE [Security].[RolesPermissions]  
	WITH CHECK ADD  CONSTRAINT [FK_RolesPermissions_Roles] FOREIGN KEY([RoleID])
	REFERENCES [Security].[Roles](RoleID);

	ALTER TABLE [Security].[RolesPermissions]  
	WITH CHECK ADD  CONSTRAINT [FK_RolesPermissions_Permissions] FOREIGN KEY([PermissionsID])
	REFERENCES [Security].[Permissions](PermissionsID);
Go
Create Table [Security].[Login]
(
	UserId int not null Primary Key,
	UserName varchar(50) not null,
	[Password] varchar not null,
	RoleID int not null,
	EmployeesId int not null,
	Email varchar(50) not null,
	[Status] tinyint not null,
	Attemptfails tinyint null
)
	ALTER TABLE [Security].[Login]  
	WITH CHECK ADD  CONSTRAINT [FK_Employees_Login] FOREIGN KEY([EmployeesId])
	REFERENCES Employee.Employees ([EmployeesId])

	ALTER TABLE [Security].[Login]  
	WITH CHECK ADD  CONSTRAINT [FK_Roles_Login] FOREIGN KEY([RoleID])
	REFERENCES [Security].[Roles] ([RoleID])

Go
Create Table Employee.EmployeeSkillset
(
	EmployeeSkillsetID int Not null Primary Key,
	EmployeeSkillsetName Varchar(50) not null,
	EmployeesID int not null
)
	ALTER TABLE Employee.EmployeeSkillset  
	WITH CHECK ADD  CONSTRAINT [FK_Employees_EmployeeSkillset] FOREIGN KEY([EmployeesId])
	REFERENCES Employee.Employees ([EmployeesId])
Go
Create Table Employee.Training
(
	TrainingID int not null Primary Key,
	TrainingName Varchar(50) not null,
	[Description] Varchar(Max) not null
)
Go
Create Table Employee.TrainingHistory
(
	TrainingHistoryID int not null Primary Key,
	TrainingHistoryName Varchar(50) not null,
	TrainingID int not null,
	EmployeesID int not null
)
	ALTER TABLE Employee.TrainingHistory  
	WITH CHECK ADD  CONSTRAINT [FK_TrainingHistory_Employees] FOREIGN KEY([EmployeesId])
	REFERENCES Employee.Employees ([EmployeesId])

	ALTER TABLE Employee.TrainingHistory  
	WITH CHECK ADD  CONSTRAINT [FK_Training_TrainingHistory] FOREIGN KEY([TrainingID])
	REFERENCES Employee.Training ([TrainingID])
Go
Create Table Employee.Salary
(
	SalaryID int not null Primary Key,
	Salary numeric(18,2) not null
)
Go
Create Table Employee.SalaryHistory
(
	SalaryHistoryID int not null Primary Key,
	SalaryID int not null,
	[Status] tinyint not null,
	DateStart Date not null,
	EmployeesId int not null
)
	ALTER TABLE Employee.SalaryHistory  
	WITH CHECK ADD  CONSTRAINT [FK_SalaryHistory_Employees] FOREIGN KEY([EmployeesId])
	REFERENCES Employee.Employees ([EmployeesId])

	ALTER TABLE Employee.SalaryHistory  
	WITH CHECK ADD  CONSTRAINT [FK_SalaryHistory_Salary] FOREIGN KEY([SalaryID])
	REFERENCES Employee.Salary ([SalaryID])
Go
Create table [Employee].[Absenteeism] 
(
	AbsenteeismID Int PRIMARY KEY,
	EmployeesID Int,
	StartDate date,
	EndDate date,
	RelatedDocuments Bit,
	Reasons Varchar(max)
)

	Alter Table Employee.Absenteeism
	WITH CHECK ADD CONSTRAINT [FK_Absenteeism_Employees] FOREIGN KEY([EmployeesID])
	REFERENCES Employee.Employees([EmployeesID])

Create table [Employee].[VacationRequest]
(
	VacationRequestID Int PRIMARY KEY,
	EmployeesID Int,
	[Status] Tinyint,
	StartDate Date,
	EndDtae Date
)

	Alter Table Employee.VacationRequest
	WITH CHECK ADD CONSTRAINT [FK_VacationRequest_Employees] FOREIGN KEY([EmployeesID])
	REFERENCES Employee.Employees([EmployeesID])

Create table [Employee].[Overtime]
(
	OvertimeID Int PRIMARY KEY,
	EmployeesID Int,
	StartDate Date,
	EndDate Date,
	Reasons Varchar(max),
	[Status] Bit
)
	Alter Table Employee.Overtime
	WITH CHECK ADD CONSTRAINT [FK_Overtime_Employees] FOREIGN KEY([EmployeesID])
	REFERENCES Employee.Employees([EmployeesID])
Go
Create table [Department].[Department]
(
	DepartmentID int NOT NULL Primary KEY,
	Departmentname Varchar(100) NOT NULL
)
Go
Create table [Department].[Position]
(
	PositionID int NOT NULL Primary KEY,
	[Name] Varchar(50) NOT NULL,
	EmployeesID int NOT NULL,
	DepartmentID int NOT NULL
)
	ALTER TABLE [Department].[Position]  
	WITH CHECK ADD  CONSTRAINT [FK_Department_Position] FOREIGN KEY([DepartmentID])
	REFERENCES [Department].[Department] ([DepartmentID])

	ALTER TABLE [Department].[Position]  
	WITH CHECK ADD  CONSTRAINT [FK_Position_Employees] FOREIGN KEY([EmployeesID])
	REFERENCES [Employee].[Employees] ([EmployeesID])
Go
Create table [Department].[PositionSkillset]
(
	PositionSkillsetID int NOT NULL Primary KEY,
	PositionSkillsetName Varchar(50) NOT NULL,
	PositionID int NOT NULL,
)
	ALTER TABLE [Department].[PositionSkillset]
	WITH CHECK ADD  CONSTRAINT [FK_PositionSkillset_Position] FOREIGN KEY([PositionID])
	REFERENCES [Department].[Position] ([PositionID])