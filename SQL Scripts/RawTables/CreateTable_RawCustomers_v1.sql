CREATE TABLE [dbo].[raw_customers](
	[customer_id] [varchar](100) NOT NULL,
	[first_name] [varchar](100) NULL,
	[last_name] [varchar](100) NULL,
	[customer_city] [varchar](100) NULL,
	[cpf] [varchar](100) NULL,
	[country_name] [varchar](100) NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
ALTER TABLE [dbo].[raw_customers] ADD  CONSTRAINT [PK_raw_customers] PRIMARY KEY CLUSTERED 
(
	[customer_id] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
