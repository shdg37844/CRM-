{% extends '../layout.tpl' %}

{% block css %}
    <link rel="stylesheet" href="/stylesheets/style.css">
    <link rel="stylesheet" href="/stylesheets/clue-list.css">
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
        <div class="input-box user">
            <a class="back"  href="/admin/user">返回用户列表>></a>
            <div class="form-title">修改用户信息</div>
            <div class="inner-input">
                <div>用户名：</div>
                <input type="text" id="edit-name" name="name" class="reservation-form-input" placeholder="姓名" value="{{user.name}}">
            </div>
            <div class="inner-input">
                <div>手机号：</div>
                <input type="text" id="edit-phone" name="phone" class="reservation-form-input" placeholder="手机号" value="{{user.phone}}">
            </div>
            <div class="inner-input">
                <div>密码：</div>
                <input type="password" id="edit-password" name="password" class="reservation-form-input" placeholder="密码" value="{{user.password}}">
            </div>
            <div class="last-inner-input">
                <div class="last-title">角色</div>
                <select id="edit-character" class="select" required> 
                  <option value="0">选择角色</option>
                  <option value="1" {% if user.character == 1 %} selected {% endif %}>管理员</option>
                  <option value="2" {% if user.character == 2 %} selected {% endif %}>销售员</option>
                </select>
            </div>
            <input id="id"  type="text" hidden value="{{user.id}}" />
            <button id="edit-submit"  class="reservation-form-btn save">
                <span>确认修改</span>
            </button>
        </div>
   </div>

  <div class="page-footer">
    <span>copyright 极客学院体验技术部出品</span>
  </div>
{% endblock %}

{% block js %}
<script src="https://lib.baomitu.com/jquery/3.3.1/jquery.min.js"></script>
<script type="text/javascript">
  const indexPage = {
    init:function(){
      this.bind();
    },
    bind:function(){
      $('#edit-submit').on('click',this.editUser);
      $('#logout').on('click',this.logoutSubmit);
    },
    logoutSubmit:function(){
      window.location.href = '/admin/logout';
    },
    editUser:function(){
      let id = $('#id').val();
      let name = $('#edit-name').val();
      let phone = $('#edit-phone').val();
      let password = $('#edit-password').val();
      let character = $('#edit-character').val();

      if(!name || !phone || !character || !password){
        alert('缺少参数')
        return
      }

      $.ajax({
          url: '/api/admin/user/' + id,
          data: { name, phone, password, character},
          type: 'PUT',
          success: function(data) {
            if(data.code === 200){
              alert('修改成功！')
              location.reload()
            }else{
              console.log(data)
            }
          },
          error: function(err) {
            console.log(err); 
          }
      })
    }
  }
  $(function(){
    indexPage.init();
  })
</script>
{% endblock %}