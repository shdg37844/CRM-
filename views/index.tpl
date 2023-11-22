{% extends './layout.tpl' %}

{% block css %}
  <link rel="stylesheet" href="/stylesheets/style.css">
{% endblock %}

{% block content %}
  <div class="page-header">
    <div class="logo-box">
        <img class="logo" src="/images/logo.png">
    </div>
  </div>

  <div class="page-mainer flexcolumn">
    <div class="reservation">
      <span>预约试驾</span>
    </div>
    <div class="reservation-content">
      <div class="reservation-form">
        <div  class="reservation-form-title">欢迎在线预约试驾。只需填写姓名及手机号，我们会第一时间与您联系，安排试驾事宜</div>
        <div class="input-box">
          <div class="inner-input">
            <input type="text"  id="new-name" name="name"  class="reservation-form-input" placeholder="你的姓名">
          </div>
          <div class="inner-input">
            <input type="text" id="new-phone" name="phone" class="reservation-form-input" placeholder="你的电话">
          </div>
        </div>
        <div id="new-submit" class="reservation-form-btn">
          <span>马上抢占名额</span>
        </div>
      </div>
      <img class="drive-img" src="/images/testdrivebg.jpg">
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
    init:function() {
      this.bind();
    },
    bind:function() {
      $('#new-submit').on('click',this.newCustomer);
    },
    newCustomer:function() {
      let name = $('#new-name').val();
      let phone = $('#new-phone').val();
      let utm = indexPage.getQuery('utm');

      if (!name || !phone) {
        alert('缺少参数')
        return
      }

      $.ajax({
        url: '/api/admin/clue',
          data: { name, phone, utm},
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
    },
    getQuery:function(name) {
    var result = location.search.match(new RegExp("[\?\&]" + name+ "=([^\&]+)","i"));
    if(result == null || result.length < 1){
        return "";
    }
    return result[1];
  },
  }
  $(function(){
    indexPage.init();
  })
</script>
{% endblock %}