<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ListadoCuentas.aspx.cs" Inherits="Banca.ListadoCuentas" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <style>
        table{
            margin-top:30px
        }
    </style>
    <div class="jumbotron">
        <h1>ASP.NET WEB APP </h1>
        <p><a href="http://www.dynamitetechnology.in" class="btn btn-primary btn-lg">Contact us</a></p>
    </div>
    <div class="container">
        <div class="row">
            <div class="col-md-3">
                <label for="">N Cuenta</label>
                <input type="text" class="form-control  rounded-0 mb-3" id="cuenta">
            </div>
            <div class="col-md-3">
                <label for="">Usuarios</label>
                <select class="form-control" id="iduser">
                    <option value="">Seleccione Usuario</option>
                    <asp:Repeater ID="fltusuarios" runat="server">
                        <ItemTemplate>
                            <option value="<%#Eval("user_Id")%>"><%#Eval("user_Nombre")%></option>
                        </ItemTemplate>
                    </asp:Repeater>
                </select>
            </div>
            <div class="col-md-3" style="margin-top:22px">
                <button type="button" class="btn btn-primary rounded-0" id="filter">Filtrar</button>
                <button type="button" class="btn btn-primary rounded-0" id="quit">Quitar Filtro</button>
            </div>
        </div>
        <table class="table" id="tblrusuarios">
            <thead class="thead-dark">
                <tr>
                    <th>#</th>
                    <th>Cedula</th>
                    <th>Usuario</th>
                    <th>Cuenta</th>
                    <th>Tipo</th>
                    <th>Saldo</th>
                </tr>
            </thead>
            <tbody id="accountlistado">
                <asp:Repeater ID="accounts" runat="server">
                    <ItemTemplate>
                        <tr>
                            <th><%#Eval("account_Id")%></th>
                            <td><%#Eval("usuarios.user_Cedula")%></td>
                            <td><%#Eval("usuarios.user_Nombre")%></td>
                            
                            <td><%#Eval("account_Numero")%></td>
                            <td><%#Eval("account_Tipo")%></td>
                            <td><%#Eval("account_Saldo")%></td>
                        </tr>
                    </ItemTemplate>
                </asp:Repeater>
            </tbody>
        </table>
    </div>

    <script>
          $("#filter").click(function () {
              var cuenta = $("#cuenta").val();
            var user_id = $("#iduser").val();

            let sendData = {
                cuenta: cuenta,
                user_id: user_id
            }
            console.log(sendData);
              callApi(apiUrl + "/FilterAccounts", JSON.stringify(sendData), function (result) {
                console.log(result.d);
                  $("#accountlistado").empty();
                var string = '';
                  for (var i = 0; i < result.d.length; i++) {
                      var account_Tipo = result.d[i].account_IdTipo == 1 ? "Ahorros" : "Corriente";
                    string += `<tr>
                            <th>`+ result.d[i].account_Id + `</th>
                            <td>`+ result.d[i].usuarios.user_Cedula+ `</td>
                            <td>`+ result.d[i].usuarios.user_Nombre + `</td>
                            <td>`+ result.d[i].account_Numero + `</td>
                            <td>`+ account_Tipo + `</td>
                            <td>`+ result.d[i].account_Saldo + `</td>
                        </tr>`;
                }

                  $(string).appendTo("#accountlistado");
            });
        });


        $("#quit").click(function () {
            location.reload();
        });
    </script>
</asp:Content>
