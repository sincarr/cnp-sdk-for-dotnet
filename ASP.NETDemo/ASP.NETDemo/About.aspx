<%@ Page Title="About" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="About.aspx.cs" Inherits="ASP.NETDemo.About" %>

<asp:Content runat="server" ID="BodyContent" ContentPlaceHolderID="MainContent">
    <hgroup class="title">
        <h1><%: Title %></h1>
    </hgroup>

    <article>
        <p>        
            This is an example web app made with ASP.NET to demonstrate how the Worldpay cnp API .NET SDK can be integrated in a web context.
        </p>
    </article>
</asp:Content>