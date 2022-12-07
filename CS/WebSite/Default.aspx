<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="_Default" %>

<%@ Register Assembly="DevExpress.Web.v15.1" Namespace="DevExpress.Web"
	TagPrefix="dx" %>






<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
	<title></title>
	<script type="text/javascript">
		function Grid_ContextMenu(s, e) {
			if (e.objectType == "header") {
				var x = ASPxClientUtils.GetEventX(e.htmlEvent);
				var y = ASPxClientUtils.GetEventY(e.htmlEvent);
				PopupMenu.ShowAtPos(x, y);
			}
		}

		function OnEndCallback(s, e) {
			RefreshMenu();
		}
		function RefreshMenu(s, e) {
			for (var i = 0; i < PopupMenu.GetItemCount(); i++) {
				var item = PopupMenu.GetItem(i);

				var column = Grid.GetColumnByField(item.name);
				if (!!column) {		
					item.SetChecked(column.visible);
				}				
			}
		}	

	</script>
</head>
<body>
	<form id="form1" runat="server">
	<br />
	<br />
	<dx:ASPxCallbackPanel runat="server" ID="CallbackPanel" ClientInstanceName="CallbackPanel"
		Width="100%" OnCallback="CallbackPanel_Callback">
		<ClientsideEvents endcallback="OnEndCallback" />
		<panelcollection><dx:PanelContent runat="server">
                <dx:ASPxGridView ID="Grid" runat="server" Width="80%" AutoGenerateColumns="False" DataSourceID="AccessDataSource1" KeyFieldName="ProductID" ClientInstanceName="Grid">
<ClientSideEvents ContextMenu="Grid_ContextMenu"></ClientSideEvents>
                    <Columns>
                        <dx:GridViewDataTextColumn FieldName="ProductID" VisibleIndex="0" />
                        <dx:GridViewDataTextColumn FieldName="ProductName" VisibleIndex="1" />
                        <dx:GridViewDataTextColumn FieldName="SupplierID" VisibleIndex="2" />
                        <dx:GridViewDataTextColumn FieldName="CategoryID" VisibleIndex="3" />
                        <dx:GridViewDataTextColumn FieldName="UnitPrice" VisibleIndex="4" />
                        <dx:GridViewDataTextColumn FieldName="UnitsInStock" VisibleIndex="5" />
                        <dx:GridViewDataTextColumn FieldName="UnitsOnOrder" VisibleIndex="6" />
                        <dx:GridViewDataTextColumn FieldName="ReorderLevel" VisibleIndex="7" />
                        <dx:GridViewDataCheckColumn FieldName="Discontinued" VisibleIndex="8" />
                    </Columns>
                    <ClientSideEvents ContextMenu="Grid_ContextMenu" />
                </dx:ASPxGridView>
                <%--Other panel content. If you do not need to update an additional content, you do not need to use ASPxCallbackPanel--%>
            </dx:PanelContent></panelcollection>
	</dx:ASPxCallbackPanel>
	<dx:ASPxPopupMenu ID="PopupMenu" runat="server" ClientInstanceName="PopupMenu"  
		SyncSelectionMode="None" CloseAction="MouseOut">
		<clientsideevents itemclick="function(s, e){ CallbackPanel.PerformCallback('toggle ' + e.item.name); }" />
	</dx:ASPxPopupMenu>
	<asp:AccessDataSource ID="AccessDataSource1" runat="server" DataFile="~/App_Data/nwind.mdb"
		SelectCommand="SELECT * FROM [Products]" />	
	</form>
</body>
</html>
