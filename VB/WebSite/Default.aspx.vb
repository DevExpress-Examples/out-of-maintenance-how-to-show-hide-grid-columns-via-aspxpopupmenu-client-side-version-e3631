Imports Microsoft.VisualBasic
Imports System
Imports DevExpress.Web

Partial Public Class _Default
	Inherits System.Web.UI.Page
	Protected Sub Page_Load(ByVal sender As Object, ByVal e As EventArgs)
		If (Not IsPostBack) Then
			CreateMenuItems()
		End If
		UpdateMenuState()
	End Sub

	Protected Sub CallbackPanel_Callback(ByVal source As Object, ByVal e As CallbackEventArgsBase)
		If e.Parameter.StartsWith("toggle") Then
			Dim name As String = e.Parameter.Substring(7)
			Dim column As GridViewColumn = Grid.Columns(name)
			If column Is Nothing Then
				Return
			End If
			column.Visible = Not column.Visible
		End If
	End Sub

	Private Sub CreateMenuItems()
		For i As Integer = 0 To Grid.Columns.Count - 1
			Dim column As GridViewColumn = Grid.Columns(i)
			Dim dataColumn As GridViewDataColumn = TryCast(column, GridViewDataColumn)
			Dim itemText As String
			If dataColumn IsNot Nothing Then
				itemText = dataColumn.FieldName
			Else
				itemText = "#"
			End If
			PopupMenu.Items.Add(itemText, dataColumn.FieldName)
		Next i
	End Sub

	Private Sub UpdateMenuState()
		For i As Integer = 0 To Grid.Columns.Count - 1
			Dim item As MenuItem = PopupMenu.Items(i)
			Dim column As GridViewDataColumn = TryCast(Grid.Columns(i), GridViewDataColumn)
			item.GroupName = column.FieldName
			item.Checked = column.Visible
		Next i
	End Sub

End Class
