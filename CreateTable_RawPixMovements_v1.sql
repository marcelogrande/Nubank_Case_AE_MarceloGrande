CREATE TABLE [dbo].[raw_pix_movements](
	[id] [varchar](256) NOT NULL,
	[account_id] [varchar](256) NOT NULL,
	[pix_amount] [varchar](50) NOT NULL,
	[pix_requested_at] [varchar](256) NOT NULL,
	[pix_completed_at] [varchar](256) NULL,
	[status] [varchar](20) NOT NULL,
	[in_or_out] [varchar](50) NOT NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
ALTER TABLE [dbo].[raw_pix_movements] ADD  CONSTRAINT [PK_raw_pix_movements] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
