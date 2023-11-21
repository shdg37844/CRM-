{% extends '../layout.tpl' %}

{% block css %}
  <link rel="stylesheet" href="/stylesheets/style.css">
  <link rel="stylesheet" href="/stylesheets/clue-list.css">
  <link rel="stylesheet" href="/stylesheets/clue_edit.css">
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
        <a href="/admin/user" class="nav-item">
          <span>人员管理</span>
        </a>
        <a href="/admin/clue" class="nav-item focus">
          <span>线索管理</span>
        </a>
    </div>

    <div class="list">
      <a href="/admin/clue" class="list-title">返回线索列表>></a>
      <div class="clue">
        <div class="clue-block">
          <div>客户名称：{{customers.name}}</div>
          <div>联系电话：{{customers.phone}}</div>
          <div>线索来源：</div>
          <div>创建时间：{{customers.time}}</div>

          <div class="select-container">
            <div>用户状态：</div>
            <select id="customer-status" class="select" required> 
              <option value="0">选择角色</option>
              <option value="1" {% if customers.status == 1 %} selected {% endif %}>没有意向</option>
              <option value="2" {% if customers.status == 2 %} selected {% endif %}>意向一般</option>
              <option value="3" {% if customers.status == 3 %} selected {% endif %}>有意向</option>
            </select>
          </div>

          <div class="select-container">
            <div>当前分配销售：</div>
            <select id="salesman" class="select">
              <option value="0">请选择分配销售</option>
              {% for val in user  %}
              <option value="{{val.id}}" {% if customer.id == val.id %} selected {% endif %}>{{val.name}}</option>
              {% endfor %}
            </select>
          </div>

          <div>
            <div>备注：</div>
            <textarea class="textarea" placeholder="添加备注"></textarea>
          </div>

          <button id="save-btn" class="clue-btn">保存</button>
        </div>

        <div class="clue-block">
          <div class="record-items">
            {% for val in clue  %}
              <div>{{val.time}}</div>
              <div>{{val.content}}</div>

              {% else %}
        <li class="log-item">
          <p class="log-content">当前没有记录</p>
        </li>
            {% endfor %}
          </div>

          <div class="record-box">
            <div>添加记录：</div>
            <textarea name="content"  id="new-content" class="textarea" placeholder="请输入本次跟踪的记录"></textarea>
          </div>

          <button id="add-btn" class="clue-btn">添加</button>
        </div>

      </div>
    </div>
  </div>
  <input id="id"  type="text" hidden value="{{customers.id}}" />
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
      $('#add-btn').on('click',this.newClue);
      $('#logout').on('click',this.logoutSubmit);
      $('#save-btn').on('click',this.saveSubmit);
    },
    logoutSubmit:function(){
      window.location.href = '/admin/logout';
    },
    newClue:function(){
      let id = $('#id').val();
      let content = $('#new-content').val();

      if(!content){
        alert('内容不能为空')
        return
      }

      $.ajax({
          url: '/api/admin/clue/edit/' + id,
          data: { content},
          type: 'POST',
          success: function(data) {
            if(data.code === 200){
              alert('添加成功！')
              location.reload()
            }else{
              console.log(data.message)
            }
          },
          error: function(err) {
            console.log(err)
          }
      })
    },
    saveSubmit:function() {
      let id = $('#id').val();
      let status = $('#customer-status').val();
      let salesman = $('#salesman').val();
      
      if(!status || !salesman){
        alert('内容不能为空')
        return
      }

      $.ajax({
          url: '/api/admin/clue/' + id,
          data: { status, salesman },
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
            console.log(err)
          }
      })
    },
  } 
  $(function(){
    indexPage.init();
  })
</script>
{% endblock %}