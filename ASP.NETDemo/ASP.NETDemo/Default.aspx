<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="ASP.NETDemo._Default" %>
<asp:Content runat="server" ID="BodyContent" ContentPlaceHolderID="MainContent">
	<h3>Configuration</h3>
	URL:<br />
	<asp:TextBox ID="url" runat="server" TextMode="Url" style="width:240px">
	</asp:TextBox>
	<asp:RequiredFieldValidator runat="server" id="reqName" controltovalidate="url" errormessage="Required!" />
	<br />Proxy Host:<br />
	<asp:TextBox ID="proxyHost" runat="server" style="width:240px">
	</asp:TextBox>
	<asp:RequiredFieldValidator runat="server" id="RequiredFieldValidator1" controltovalidate="proxyHost" errormessage="Required!" />
	<br />Proxy Port:<br />
	<asp:TextBox ID="proxyPort" runat="server" style="width:240px">
	</asp:TextBox>
	<asp:RequiredFieldValidator runat="server" id="RequiredFieldValidator2" controltovalidate="proxyPort" errormessage="Required!" />
	<br />User:<br />
	<asp:TextBox ID="user" runat="server" style="width:240px">
	</asp:TextBox>
	<asp:RequiredFieldValidator runat="server" id="RequiredFieldValidator3" controltovalidate="user" errormessage="Required!" />
	<br />Password:<br />
	<asp:TextBox ID="password" runat="server" style="width:240px">
	</asp:TextBox>
	<asp:RequiredFieldValidator runat="server" id="RequiredFieldValidator4" controltovalidate="password" errormessage="Required!" />
	<br />Merchant ID:<br />
	<asp:TextBox ID="merchant_id" runat="server" style="width:240px">
	</asp:TextBox>
	<asp:RequiredFieldValidator runat="server" id="RequiredFieldValidator5" controltovalidate="merchant_id" errormessage="Required!" />
	<br />
	<div>
		<style type="text/css">
			td {
			vertical-align: top;
			}
		</style>
		<table>
			<tr>
				<td>
					<h3>
						Simple Auth 
						<asp:CheckBox ID="auth_checkbox" runat="server"/>
					</h3>
					Report Group:<br />
					<asp:TextBox ID="auth_report_group" runat="server" style="width:240px">
					</asp:TextBox>
					<br />Order ID:<br />
					<asp:TextBox ID="order_id" runat="server" style="width:240px">
					</asp:TextBox>
					<br />Amount:<br />
					<asp:TextBox ID="auth_amount" runat="server" TextMode="Number" style="width:240px">
					</asp:TextBox>
					<br />Order Source:<br />
					<div>
						<asp:DropDownList ID="auth_order_source_list" runat="server" >
							<asp:ListItem Value="">Please Select</asp:ListItem>
							<asp:ListItem>AndroidPay</asp:ListItem>
							<asp:ListItem>ApplePay</asp:ListItem>
							<asp:ListItem>Ecommerce</asp:ListItem>
							<asp:ListItem>Echeckppd</asp:ListItem>
						</asp:DropDownList>
					</div>
					<br />ID:<br />
					<asp:TextBox ID="auth_id" runat="server" TextMode="Number" style="width:240px">
					</asp:TextBox>
					<br /><br />
					<br />Card Number:<br />
					<asp:TextBox ID="card_number" runat="server" TextMode="Number" style="width:240px">
					</asp:TextBox>
					<br />Expiration Date:<br />
					<asp:TextBox ID="exp_date" runat="server" TextMode="Number" style="width:240px">
					</asp:TextBox>
					<br />Card Type:<br />
					<div>
						<asp:DropDownList ID="card_type_list" runat="server" >
							<asp:ListItem Value="">Please Select</asp:ListItem>
							<asp:ListItem>VI</asp:ListItem>
							<asp:ListItem>MC</asp:ListItem>
							<asp:ListItem>AX</asp:ListItem>
							<asp:ListItem>DC</asp:ListItem>
							<asp:ListItem>DI</asp:ListItem>
						</asp:DropDownList>
					</div>
				</td>
				<td>
					<h3>
						Simple Capture 
						<asp:CheckBox ID="capture_checkbox" runat="server"/>
					</h3>
					Report Group:<br />
					<asp:TextBox ID="capture_report_group" runat="server" style="width:240px">
					</asp:TextBox>
					<br />CNP Txn ID:<br />
					<asp:TextBox ID="cnp_txn_id" runat="server" TextMode="Number" style="width:240px">
					</asp:TextBox>
					<br />Amount:<br />
					<asp:TextBox ID="capture_amount" runat="server" TextMode="Number" style="width:240px">
					</asp:TextBox>
					<br />Paypal Notes:<br />
					<asp:TextBox ID="paypal_notes" runat="server" style="width:240px">
					</asp:TextBox>
					<br />Pin:<br />
					<asp:TextBox ID="pin" runat="server" TextMode="Number" style="width:240px">
					</asp:TextBox>
					<br />ID:<br />
					<asp:TextBox ID="capture_id" runat="server" TextMode="Number" style="width:240px">
					</asp:TextBox>
					<br />
				</td>
				<td>
					<h3></h3>
					<asp:Button ID="submit" runat="server" Text="Submit" style="width:85px" onclick="Submit_Click" />
					<br />
					<asp:CustomValidator ID="cv1" runat="server"
						ErrorMessage="Fill out all required fields for the checked transactions!"
						ValidateEmptyText="True" 
						ClientValidationFunction="validate"/>
				</td>
			</tr>
			<tr>
				<td>
					<span runat="server" id="auth_response" />
				</td>
				<td>
					<span runat="server" id="capture_response" />
				</td>
			</tr>
		</table>
	</div>
	<script type="text/javascript">
	    function validate(s, args) {
	        var capturedChecked = document.getElementById('<%=capture_checkbox.ClientID%>').checked;
		    var authChecked = document.getElementById('<%=auth_checkbox.ClientID%>').checked;
		    args.IsValid = true;
		    if (capturedChecked) {
		        var capture_report_group = document.getElementById('<%=capture_report_group.ClientID%>').value;
		        var capture_amount = document.getElementById('<%=capture_amount.ClientID%>').value;
		        var paypal_notes = document.getElementById('<%=paypal_notes.ClientID%>').value;
		        var pin = document.getElementById('<%=pin.ClientID%>').value;
		        var capture_id = document.getElementById('<%=capture_id.ClientID%>').value;
		        var cnp_txn_id = document.getElementById('<%=cnp_txn_id.ClientID%>').value;

		        if (capture_report_group == '' || capture_amount == '' || paypal_notes == ''
		            || pin == '' || capture_id == '' || cnp_txn_id == '') {
		            args.IsValid = false;  // field is empty
		        }
		    }
            if (authChecked) {
                var auth_report_group = document.getElementById('<%=auth_report_group.ClientID%>').value;
		        var auth_amount = document.getElementById('<%=auth_amount.ClientID%>').value;
		        var order_id = document.getElementById('<%=order_id.ClientID%>').value;
		        var auth_id = document.getElementById('<%=auth_id.ClientID%>').value;
		        var card_number = document.getElementById('<%=card_number.ClientID%>').value;
		        var exp_date = document.getElementById('<%=exp_date.ClientID%>').value;

		        var card_type_list = document.getElementById('<%=card_type_list.ClientID%>');
		        var card_type = card_type_list.options[card_type_list.selectedIndex].text;

		        var auth_order_source_list = document.getElementById('<%=auth_order_source_list.ClientID%>');
		        var auth_order_source = auth_order_source_list.options[auth_order_source_list.selectedIndex].text;

		        if (auth_report_group == '' || auth_amount == '' || order_id == '' || auth_id == ''
		            || card_number == '' || exp_date == '' || card_type == 'Please Select' || auth_order_source == 'Please Select') {
		            args.IsValid = false;
		        }
            }
        }
	</script>
</asp:Content>