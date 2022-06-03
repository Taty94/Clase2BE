<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Cuenta.aspx.cs" Inherits="Banca.Cuenta" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="jumbotron">
        <h1>ASP.NET WEB APP </h1>
        <p><a href="http://www.dynamitetechnology.in" class="btn btn-primary btn-lg">Contact us</a></p>
    </div>
    <div class="container">
        
        <table class="table" id="tblrusuarios">
           <caption>
                <button type="button" class="btn btn-success rounded-0" data-toggle="modal" data-target="#AddAccount">Agregar Cuenta</button>
            </caption>
            <thead class="thead-dark">
                <tr>
                    <th>#</th>
                    <th>Cuenta</th>
                    <th>Tipo</th>
                    <th>Saldo</th>
                    <th>Accion</th>
                </tr>
            </thead>
            <tbody id="accountlistado">
                <asp:Repeater ID="accounts" runat="server">
                    <ItemTemplate>
                        <tr>
                            <th><%#Eval("account_Id")%></th>
                            <td><%#Eval("account_Numero")%></td>
                            <td><%#Eval("account_Tipo")%></td>
                            <td><%#Eval("account_Saldo")%></td>
                            <td><a class="editModal" data-edit="<%#Eval("account_Id")%>">Editar</a>
                                <a class="deletedata" data-id="<%#Eval("account_Id")%>">Eliminar</a>
                            </td>
                        </tr>
                    </ItemTemplate>
                </asp:Repeater>
            </tbody>
        </table>
    </div>
    

    <!-- Modal -->
    <div class="modal fade" id="AddAccount" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title" id="">Nueva Cuenta</h4>
                </div>
                <div class="modal-body">
                    <div class="row">
                        <div class="col-md-4">
                            <div class="form-group">
                                <label for="cuenta">Cuenta</label>
                                <input type="text" class="form-control rounded-0" id="txtcuenta" readonly>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div class="form-group">
                                <label for="tipoCuenta">Tipo de Cuenta</label>
                                <select class="form-control" id="txtipo">
                                    <option value="1">Ahorro</option>
                                    <option value="2">Corriente</option>
                                </select>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div class="form-group">
                                <label for="saldo">Deposito Inicial</label>
                                <input type="text" class="form-control  rounded-0" id="txtsaldo">
                            </div>
                        </div>
<%--                        <div class="col-md-2">
                            <div class="form-group">
                                <a href="#" id="add">Agregar</a>
                            </div>
                        </div>--%>
                    </div>
                    <table class="table" id="tblcuenta">
                        <thead class="thead-dark">
                            <tr>
                                <th>#</th>
                                <th>Cuenta</th>
                                <th>Tipo</th>
                                <th>Saldo</th>
                                <th>Accion</th>
                            </tr>
                        </thead>
                        <tbody id="accountnew">
                        </tbody>
                    </table>
                </div>

                <div class="modal-footer">
                    <button type="button" class="btn btn-success  rounded-0 AddAccount">PreGuardar</button>
                    <button type="button" class="btn btn-primary  rounded-0 AddClose">Guardar y Cerrar</button>
                </div>
            </div>
        </div>
    </div>
    <!-- Modal -->
    <div class="modal fade" id="updateModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title" id="">Editar Account</h4>
                </div>
                <div class="modal-body">
                    <div class="row">
                        <div class="col-md-4">
                            <div class="form-group">
                                <input type="hidden" class="form-control rounded-0" id="txtidaccount" >
                                <input type="hidden" class="form-control rounded-0" id="txtidusuario" >
                                <label for="account">Cuenta</label>
                                <input type="text" class="form-control rounded-0" id="etxtaccount" readonly>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <label for="tipoCuenta">Tipo de Cuenta</label>
                                <select class="form-control" id="etxtipo" disabled>
                                    <option value="1">Ahorro</option>
                                    <option value="2">Corriente</option>
                                </select>
                        </div>
                        <div class="col-md-4">
                            <div class="form-group">
                                <label for="saldo">Deposito</label>
                                <input type="text" class="form-control  rounded-0" id="etxtsaldo">
                            </div>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary  rounded-0" data-dismiss="modal">Cerrar</button>
                    <button type="button" class="btn btn-success  rounded-0 EditAccount">Guardar</button>
                </div>
            </div>
        </div>
    </div>

    <script >
       
        var cont = 1;
        var listacc = [];

        getRandomNumber();
        function getRandomNumber() {
            $("#txtcuenta").val("1721795"+Math.floor(Math.random() * (99999 - 0)) + 0);
        }

        $(".AddAccount").click(function () {
            var nueva = new Object();
            nueva.account_Id = cont;
            nueva.account_user_Id = '<%= user_Id%>';
            nueva.account_Numero = $("#txtcuenta").val();
            nueva.account_IdTipo = $("#txtipo").val();
            nueva.account_Saldo = $("#txtsaldo").val();
            var account_Tipo = nueva.account_IdTipo == 1 ? "Ahorros" : "Corriente";
            listacc.push(nueva);
            var string = `<tr id="` + cont +`" >
                            <th >` + cont +`</th>
                            <td >`+ nueva.account_Numero +`</td>
                            <td>`+ account_Tipo  +`</td>
                            <td>`+ nueva.account_Saldo +`</td>
                            <td>
                                <a onclick="remove(`+ cont +`)">Eliminar</a>
                            </td></tr>`
                

                $(string).appendTo("#accountnew");
                cont++;
        });

        function remove(id) {
            listacc = $.grep(listacc, function (e) {
                return e.account_Id != id;
            });
            $("#" + id).remove();
            
        }

        $(".AddClose").click(function () {
            if (listacc.length != 0) {
                listacc.forEach(element => element.account_Id = 0);
                let sendData = {
                    lstaccounts: listacc
                }
                console.log(sendData);
                callApi(apiUrl + "/AddEditAccount", JSON.stringify(sendData), function (result) {
                    $("#AddVenta").modal('hide');
                    if (result.d) {
                        location.reload();
                    } else {
                        Swal.fire({
                            position: 'top-end',
                            icon: 'warning',
                            title: 'Algo sucedio durante el proceso , intentelo mas tarde',
                            showConfirmButton: false,
                            timer: 1500
                        })
                    }

                    
                });
            } else {
                Swal.fire({
                    position: 'top-end',
                    icon: 'warning',
                    title: 'Es necesario pre-guardar antes de guardar',
                    showConfirmButton: false,
                    timer: 1500
                })
            }
        });

        $(".editModal").click(function () {
            debugger;
            var editid = $(this).attr("data-edit");

            let sendData = {
                account_id: editid
            }
            callApi(apiUrl + "/GetAccountById", JSON.stringify(sendData), function (result) {
                $("#etxtaccount").val(result.d.account_Numero);
                $("#etxtipo").val(result.d.account_IdTipo);
                $("#txtidaccount").val(result.d.account_Id);
                $("#txtidusuario").val(result.d.usuarios.user_Id);

                $("#updateModal").modal('show');
            });
        });

        $(".EditAccount").click(function () {
            var lsteditaccount = [];
            var edit = new Object();
            edit.account_Id = $("#txtidaccount").val();
            edit.account_user_Id = $("#txtidusuario").val();
            edit.account_Numero = $("#etxtaccount").val();
            edit.account_IdTipo = $("#etxtipo").val();
            edit._account_deposito = $("#etxtsaldo").val();
            lsteditaccount.push(edit);
            let sendData = {
                lstaccounts: lsteditaccount
            }
            callApi(apiUrl + "/AddEditAccount", JSON.stringify(sendData), function (result) {
                $("#updateModal").modal('hide');
                if (result.d) {
                    location.reload();
                } else {
                    Swal.fire({
                        position: 'top-end',
                        icon: 'warning',
                        title: 'Algo sucedio durante el proceso , intentelo mas tarde',
                        showConfirmButton: false,
                        timer: 1500
                    })
                }
            });
        });


        $(".deletedata").click(function () {
            Swal.fire({
                title: 'Estas seguro?',
                text: "No podras revertirlo :/!",
                icon: 'warning',
                showCancelButton: true,
                confirmButtonColor: '#3085d6',
                cancelButtonColor: '#d33',
                confirmButtonText: 'Si, borrar!'
            }).then((result) => {
                if (result.isConfirmed) {
                    var id = $(this).attr("data-id");

                    let sendData = {
                        account_id: id
                    }
                    callApi(apiUrl + "/DeleteAccountById", JSON.stringify(sendData), function (result) {
                        console.log(result.d);
                        if (result.d) {
                            location.reload();
                        }

                    });
                }
                
            });
        });

    </script>
</asp:Content>
