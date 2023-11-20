{% extends '../layout.tpl' %}

{% block css %}
  <link rel="stylesheet" href="/stylesheets/style.css">
  <link rel="stylesheet" href="/stylesheets/login-form.css">
{% endblock %}

{% block content %}
  <div class="page-header">
    <div class="logo-box">
        <img class="logo" src="/images/logo.png">
    </div>
  </div>

  <div class="page-mainer bg">
    <div class="login-form-container">
        <div class="form-title">MERCEDS-BENZ</div>
        <div class="input-box">
          <div class="inner-input">
            <input type="text" name="phone" id="phone" class="reservation-form-input" placeholder="请输入你的手机">
          </div>
          <div class="inner-input">
            <input type="password" name="password" id="password" class="reservation-form-input" placeholder="请输入你的密码">
          </div>
        </div>
        <div id="submit" class="reservation-form-btn">
          <span>马上登录</span>
        </div>
    </div>
  </div>

  <div class="page-footer">
    <span>copyright 极客学院体验技术部出品</span>
  </div>
{% endblock %}

{% block js %}
<script src="https://lib.baomitu.com/jquery/3.3.1/jquery.min.js"></script>
<script type="text/javascript">
  const PAGE = {
    init:function(){
      this.bind();
    },
    bind:function(){
      $('#submit').on('click',this.handleSubmit);
    },
    handleSubmit:function(){
      let password = $('#password').val();
      let phone = $('#phone').val();

      if(!password || !phone){
        alert('params empty!')
        return
      }
      console.log(phone,password)
      $.ajax({
          url: '/api/admin/login',
          data: { phone, password },
          type: 'POST',
          success: function(data) {
            if(data.code === 200){
              alert('登录成功！'),              
              location.href = '/admin/clue'
            }else{
              console.log(data)
              alert('手机号或密码不正确')
            }
          },
          error: function(err) {
            console.log(err)
          }
      })
    }
  }

  PAGE.init();
</script>
{% endblock %}
