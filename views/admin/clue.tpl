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
        <a href="/admin/user" class="nav-item">
          <span>人员管理</span>
        </a>
        <a href="/admin/clue" class="nav-item focus">
          <span>线索管理</span>
        </a>
    </div>
    <div class="list">
      <div class="list-title">线索管理</div>
      <div class="list-box">
        <div class="list-block">
          <div class="list-item bd br w135">姓名</div>
          <div class="list-item bd br w250">电话</div>
          <div class="list-item bd br w135"">来源</div>
          <div class="list-item bd br w250"">创建时间</div>
          <div class="list-item bd br w135"">跟踪销售</div>
          <div class="list-item bd br w135"">状态</div>
          <div class="list-item bd w135"">操作</div>
        </div>

        {% for val in customers %}
        <div class="list-block">
          <div class="list-item bd br left w135">{{val.name}}</div>
          <div class="list-item bd br left w250">{{val.phone}}</div>
          <div class="list-item bd br left w135">{{val.utm}}</div>
          <div class="list-item bd br left w250">{{val.time}}</div>

          <div class="list-item bd br left w135">{{val.salesman}}</div>
          
          <div class="list-item bd br left w135">
            {% if val.status == 1 %}
              <div>没有意向</div>
            {% elif val.status == 2 %}
              <div>意向一般</div>
            {% elif val.status == 3 %}
              <div>有意向</div>
            {% else %}
              <div>-</div>
            {% endif %}
          </div>

          <a  href="/admin/clue/edit/{{val.id}}" class="list-item bd left w135">跟踪</a>
        </div>
        {% endfor %}
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
      $('#logout').on('click',this.logoutSubmit);
    },
    logoutSubmit:function(){
      window.location.href = '/admin/logout';
    },
  }

  PAGE.init();

</script>
{% endblock %}