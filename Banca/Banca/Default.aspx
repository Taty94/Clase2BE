<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="Banca._Default" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <div class="jumbotron">
        <h1>ASP.NET WEB APP </h1>
        <p><a href="http://www.dynamitetechnology.in" class="btn btn-primary btn-lg">Contact us</a></p>
    </div>
    <div class="container">
        <%--<div class="row">
            <div class="col-md-3">
                <label for="exampleInputEmail1">Serch</label>
                <input type="text" class="form-control  rounded-0 mb-3" id="serchtext">
            </div>
        </div>--%>
        <table class="table" id="tblrusuarios">
            <caption>
                <button type="button" class="btn btn-success rounded-0" data-toggle="modal" data-target="#AddUsuario">Agregar Usuario</button>
            </caption>
            <thead class="thead-dark">
                <tr>
                    <th>#</th>
                    <th>Cedula</th>
                    <%--<th>Fecha Nacimiento</th>--%>
                    <th>Nombre</th>
                    <th>Direccion</th>
                    <th>Email</th>
                    <th>Accion</th>
                </tr>
            </thead>
            <tbody>
                <asp:Repeater ID="usuarios" runat="server">
                    <ItemTemplate>
                        <tr>
                            <th><%#Eval("user_Id")%></th>
                            <td><%#Eval("user_Cedula")%></td>
                            <%--<td><%#Eval("user_FechaNacimiento")%></td>--%>
                            <td><%#Eval("user_Nombre")%></td>
                            <td><%#Eval("user_Direccion")%></td>
                            <td><%#Eval("user_Email")%></td>
                            <td><a class="editModal" data-edit="<%#Eval("user_Id")%>">Editar</a>
                                <a class="deletedata" data-id="<%#Eval("user_Id")%>">Eliminar</a>
                                <a class="addAccount" href='Cuenta.aspx?id=<%#Eval("user_Id")%>'>Cuenta</a>
                            </td>
                        </tr>
                    </ItemTemplate>
                </asp:Repeater>
            </tbody>
        </table>
    </div>


    <!-- Modal -->
    <div class="modal fade" id="AddUsuario" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title" id="myModalLabel">Nuevo Usuario</h4>
                </div>
                <div class="modal-body">
                    <div class="form-group">
                        <label for="nombre">Nombre</label>
                        <input type="text" class="form-control rounded-0" id="txtnombre">
                    </div>
                    <div class="form-group">
                        <label for="cedula">Cedula</label>
                        <input type="text" class="form-control  rounded-0" id="txtcedula">
                    </div>
                    <div class="form-group">
                        <label for="direccion">Direccion</label>
                        <input type="text" class="form-control  rounded-0" id="txtdireccion">
                    </div>
                    <div class="form-group">
                        <label for="email">Email</label>
                        <input type="email" class="form-control  rounded-0" id="txtemail">
                    </div>
                    <%--<div class="form-group">
                        <label for="fecha">Fecha Nacimiento</label>
                        <input type="date" class="form-control  rounded-0" id="txtfecha" value='<%= DateTime.Now.ToString("yyyy/MM/dd")%>'>
                    </div>--%>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary  rounded-0" data-dismiss="modal">Cerrar</button>
                    <button type="button" class="btn btn-success  rounded-0 AddUsuario">Guardar</button>
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
                    <h4 class="modal-title" id="myModalLabel">Editar Usuario</h4>
                </div>
                <div class="modal-body">
                    <div class="form-group">
                        <input type="hidden" class="form-control rounded-0" id="etxtid">
                        <label for="nombre">Nombre</label>
                        <input type="text" class="form-control rounded-0" id="etxtnombre">
                    </div>
                    <div class="form-group">
                        <label for="cedula">Cedula</label>
                        <input type="text" class="form-control  rounded-0" id="etxtcedula">
                    </div>
                    <div class="form-group">
                        <label for="direccion">Direccion</label>
                        <input type="text" class="form-control  rounded-0" id="etxtdireccion">
                    </div>
                    <div class="form-group">
                        <label for="email">Email</label>
                        <input type="email" class="form-control  rounded-0" id="etxtemail">
                    </div>
                    <%--<div class="form-group">
                        <label for="fecha">Fecha Nacimiento</label>
                        <input type="date" class="form-control  rounded-0" id="etxtfecha">
                    </div>--%>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary  rounded-0" data-dismiss="modal">Cerrar</button>
                    <button type="button" class="btn btn-success  rounded-0 EditUsuario">Guardar</button>
                </div>
            </div>
        </div>
    </div>

    
    <script>        

        $(".AddUsuario").click(function () {
            debugger;
            var nuevo = new Object();
            nuevo.user_Id = 0;
            nuevo.user_Cedula = $("#txtcedula").val();
            nuevo.user_Nombre = $("#txtnombre").val();
            nuevo.user_Direccion = $("#txtdireccion").val();
            //nuevo.user_FechaNacimiento = $("#txtfecha").val();
            nuevo.user_Email = $("#txtemail").val();

            let sendData = {
                objusuario: nuevo
            }
            callApi(apiUrl + "/AddEditUsuario", JSON.stringify(sendData), function (result) {
                console.log(result);
                $("#AddUsuario").modal('hide');
                location.reload()
            });
        });

        

        $(".editModal").click(function () {
            
            var editid = $(this).attr("data-edit");

            let sendData = {
                user_Id: editid
            }
            callApi(apiUrl + "/GetUsuarioById", JSON.stringify(sendData), function (result) {
                
                console.log(result);
                $("#etxtid").val(result.d.user_Id);
                $("#etxtcedula").val(result.d.user_Cedula);
                $("#etxtnombre").val(result.d.user_Nombre);
                $("#etxtdireccion").val(result.d.user_Direccion);
                $("#etxtemail").val(result.d.user_Email);
                //$("#txtfecha").val(result.d.user_FechaNacimiento);


                $("#updateModal").modal('show');
            });
        });


        $(".EditUsuario").click(function () {
            var edit = new Object();
            edit.user_Id = $("#etxtid").val();
            edit.user_Cedula = $("#etxtcedula").val();
            edit.user_Nombre = $("#etxtnombre").val();
            edit.user_Direccion = $("#etxtdireccion").val();
            edit.user_Email = $("#etxtemail").val();
            //edit.user_FechaNacimiento = $("#etxtfecha").val();

            let sendData = {
                objusuario: edit
            }
            callApi(apiUrl + "/AddEditUsuario", JSON.stringify(sendData), function (result) {
                $("#updateModal").modal('hide');
                location.reload();

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
                        user_Id: id
                    }
                    callApi(apiUrl + "/DeleteUsuarioById", JSON.stringify(sendData), function (result) {
                        console.log(result.d);
                        if (result.d) {
                            location.reload();
                        }

                    });
                }
            })

        });

    </script>

</asp:Content>
