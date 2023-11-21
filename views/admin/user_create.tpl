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
            <div class="form-title">新增用户信息</div>
            <div class="inner-input">
                <input type="text" id="new-name" name="name" class="reservation-form-input" placeholder="姓名">
            </div>
            <div class="inner-input">
                <input type="text" id="new-phone" name="phone" class="reservation-form-input" placeholder="手机号">
            </div>
            <div class="inner-input">
                <input type="password" id="new-password" name="password" class="reservation-form-input" placeholder="密码">
            </div>
            <div class="last-inner-input">
                <div class="last-title">角色</div>
                <select id="new-character" class="select" required> 
                  <option value="0">选择角色</option>
                  <option value="1" {% if user.character == 1 %} selected {% endif %}>管理员</option>
                  <option value="2" {% if user.character == 2 %} selected {% endif %}>销售员</option>
                </select>
            </div>
            <button id="new-submit"  class="reservation-form-btn save">
                <span>保存</span>
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
      $('#new-submit').on('click',this.newUser);
      $('#logout').on('click',this.logoutSubmit);
    },
    logoutSubmit:function(){
      window.location.href = '/admin/logout';
    },
    newUser:function(){
      let name = $('#new-name').val();
      let phone = $('#new-phone').val();
      let password = $('#new-password').val();
      let character = $('#new-character').val();

      if(!name || !phone || !password || !character){
        alert('缺少参数')
        return
      }

      $.ajax({
          url: '/api/admin/user',
          data: { name, phone, password, character},
          type: 'POST',
          success: function(data) {
            if(data.code === 200){
              alert('新增成功！')
              location.reload()
            }else{
              console.log(data)
            }
          },
          error: function(err) {
            console.log(err)
          }
      })
    }
  }
  $(function(){
    indexPage.init();
  })
</script>
{% endblock %}