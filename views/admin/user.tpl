{% extends '../layout.tpl' %}

{% block css %}
    <link rel="stylesheet" href="/stylesheets/style.css">
    <link rel="stylesheet" href="/stylesheets/clue-list.css">
    <link rel="stylesheet" href="/stylesheets/user-list.css">
{% endblock %}

{% block content %}
    <div class="page-header borderline">
        <div class="logo-box">
            <img class="logo" src="/images/logo.png">
        </div>
        <div class="header-right">
            <div class="name"></div>
            <a id="logout" class="loginout">退出</a>
        </div>
    </div>

    <div class="page-mainer">
        <div class="nav-bar">
            <a href="/admin/user" class="nav-item focus">
                <span>人员管理</span>
            </a>
            <a href="/admin/clue" class="nav-item">
                <span>线索管理</span>
            </a>
        </div>
        <div class="list">
            <div class="list-title">用户列表</div>
            <ul class="user-list">
                <li class="user-items center">
                    <span class="w200">姓名</span>
                    <span class="w300">电话号</span>
                    <span class="w300">密码</span>
                    <span class="w200">角色</span>
                    <span class="w200">操作</span>
                </li>

                {% for val in users  %}
                <li class="user-items">
                    <input id="id"  type="text" hidden value="{{val.id}}" />
                    <span class="w200">{{val.name}}</span>
                    <span class="w300">{{val.phone}}</span>
                    <span class="w300">{{val.password}}</span>
                    <span class="w200" class="edit-salesman">
                        {% if val.character == 1 %}
                            <div>管理员</div>
                        {% elif val.character == 2 %}
                            <div>销售员</div>
                        {% else %}
                            <div>-</div>
                        {% endif %}
                    </span>
                    <div class="operation-box">
                        <a href="/admin/user/edit/{{val.id}}" class="operation">修改</a>
                        <a class="delete-btn" data-id="{{val.id}}">删除</a>
                    </div>
                </li>
                {% endfor %}
                <div class="add">
                    <a href="/admin/user/create" class="add-user">点击新增用户</a>
                </div>
            </ul>
        </div>
   </div>
   <input id="id"  type="text" hidden value="{{users.id}}" />
  <div class="page-footer">
    <span>copyright 极客学院体验技术部出品</span>
  </div>

{% endblock %}

{% block js %}
<script src="https://lib.baomitu.com/jquery/3.3.1/jquery.min.js"></script>
<script type="text/javascript">
    const indexPage = {
        init:function() {
            this.bind();
        },
        bind:function() {
            $('.delete-btn').on('click',this.deleteUser);
            $('#logout').on('click',this.logoutSubmit);
        },
        logoutSubmit:function(){
            window.location.href = '/admin/logout';
        },
        deleteUser:function() {
            let id = $(this).data('id');
            $.ajax({
              url: '/api/admin/user/',
              data: { id },
              type: 'DELETE',
              success: function(data) {
                if(data.code === 200){
                  alert('删除成功！')
                  location.reload()
                }else{
                  console.log(data)
                }
              },
              error: function(err) {
                console.log(err); 
              }
            })
        },
    }
    $(function(){
    indexPage.init();
  })

</script>
{% endblock %}