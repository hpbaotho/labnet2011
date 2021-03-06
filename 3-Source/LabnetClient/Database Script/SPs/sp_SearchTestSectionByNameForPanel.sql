
/****** Object:  StoredProcedure [dbo].[sp_SearchTestSectionByNameForPanel]    Script Date: 03/18/2012 22:34:51 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_SearchTestSectionByNameForPanel]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[sp_SearchTestSectionByNameForPanel]
GO
ALTER  Procedure [dbo].[sp_SearchTestSectionByNameForPanel]
	@FilterText nvarchar(100)=null,
	@SearchType	nvarchar(10)='CONTAINS'
as
Begin
	if(@SearchType ='WORD')
	begin
		select ts.Id, ts.Name, ts.Cost
		from TestSection ts
		where(@FilterText is null or dbo.fuChuyenCoDauThanhKhongDau(ts.Name) like @FilterText+'%')
			AND ts.UseCostForAssociateTest = 1
	end
	else
	begin
		select ts.Id, ts.Name, ts.Cost
		from TestSection ts
		where(@FilterText is null or dbo.fuChuyenCoDauThanhKhongDau(ts.Name) like '%'+@FilterText+'%')
			AND ts.UseCostForAssociateTest = 1
	end
End