using System;
using DevExpress.Web;

public partial class _Default : System.Web.UI.Page {
    protected void Page_Load(object sender, EventArgs e) {
        if(!IsPostBack)
            CreateMenuItems();
        UpdateMenuState();
    }

    protected void CallbackPanel_Callback(object source, CallbackEventArgsBase e) {
        if(e.Parameter.StartsWith("toggle")) {
			string name = e.Parameter.Substring(7);
			GridViewColumn column = Grid.Columns[name];
            if(column == null)
                return;
            column.Visible = !column.Visible;            
        }        
    }

    void CreateMenuItems() {
        for(int i = 0; i < Grid.Columns.Count; i++) {
            GridViewColumn column = Grid.Columns[i];
            GridViewDataColumn dataColumn = column as GridViewDataColumn;
			PopupMenu.Items.Add(dataColumn != null ? dataColumn.FieldName : "#", dataColumn.FieldName);
        }
    }

    void UpdateMenuState() {
		for (int i = 0; i < Grid.Columns.Count; i++) {
			MenuItem item = PopupMenu.Items[i];
			GridViewDataColumn column = Grid.Columns[i] as GridViewDataColumn;			
			item.GroupName = column.FieldName;
			item.Checked = column.Visible;
		}
    }

}
