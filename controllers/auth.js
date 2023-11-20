//require('dotenv').config();
const UserModel = require('./../models/user_table.js');
const User = new UserModel();
const JWT = require("jsonwebtoken");
const JWT_SECRET = process.env.JWT_SECRET;

const authController = {
    login: async function (req, res, next) {
        // 获取手机密码参数
        let phone = req.body.phone;
        let password = req.body.password;
        // 参数判断
        if (!phone || !password) {
            res.json({ code: 0, data: 'params empty!' });
            return
        }

        try {
            // 通过用户模型搜索用户
            const users = await User.select({ phone, password });
            // 看是否有用户存在
            const user = users[0];
            // 如果存在
            if (user) {
                // 将其 id 放到 JWT 中加密
                let token = JWT.sign({ user_id: user.id }, JWT_SECRET, {
                    expiresIn: "30d"
                });
                // 加密放置在 cookie 中
                res.cookie('web_token', token, { maxAge: 30 * 24 * 60 * 60 });
                // 返回登录的信息
                res.json({ code: 200, message: '登录成功！', data: { token: token }});
            } else {
                res.json({ code: 0, data: { msg: '登录失败，没有此用户！' } })
            }
        } catch (e) {
            console.error(e); // 输出错误信息到控制台
            res.json({ code: 0, data: e.toString() }); // 发送错误信息的字符串表示给客户端
        }
    },
    logout: function (req, res, next) {
        res.clearCookie('web_token');
        res.redirect('/admin/login')
    },
    // 渲染登录页面的模版
    renderLogin: async function (req, res, next) {
        // 如果用户已经登录，重定向到线索管理页面
        if (res.locals.isLogin) {
            res.redirect('/admin/clue')
            return
        }
        res.render('admin/login.tpl', res.locals)
    }
}

module.exports = authController;