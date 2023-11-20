var express = require('express');
var router = express.Router();
var userController = require('./../controllers/user.js');
var authController = require('./../controllers/auth.js');
var customerController = require('./../controllers/customer.js');
var authMiddleware = require('./../middlewares/auth.js');

//落地页
router.get('/', function (req, res, next) {
  res.render('index');
});

// 登录页
router.get('/admin/login', authController.renderLogin);

// 线索列表页
router.get('/admin/clue', authMiddleware.mustLogin, customerController.show);  //中间件位置放置顺序不能错

// 线索编辑页
router.get('/admin/clue/edit/:id', authMiddleware.mustLogin, customerController.edit);

// 新建用户页
router.get('/admin/user/create', authMiddleware.mustLogin,  (req, res, next) => {
  res.render('admin/user_create.tpl');
});

// 用户编辑页
router.get('/admin/user/edit/:id', authMiddleware.mustLogin,  userController.edit);


// 用户列表页
router.get('/admin/user', authMiddleware.mustLogin, userController.show);

//退出登录
router.get('/admin/logout', authController.logout);


module.exports = router;
