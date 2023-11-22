const userModel = require('./../models/user_table.js')
const User = new userModel();

const userController = {
    show: async function(req,res,next){
        // 如果用户没有登录，重定向到登录页面
        if (!res.locals.isLogin) {
            res.redirect('/admin/login')
            return
        }

        try{
            const users = await User.all();
            res.locals.users = users;
            res.render('admin/user.tpl',res.locals)
        }catch(e){
            res.locals.error = e;
            res.render('error',res.locals)
        }
    },
    insert: async function (req, res, next) {
        let name = req.body.name;
        let phone = req.body.phone;
        let password = req.body.password;
        let character = req.body.character;
        console.log(name, phone, password, character);

        if (!name || !phone || !password || !character) {
            res.json({ code: 0, data: 'params empty!' });
            return
        }

        try {
            const users = await User.insert({ name, phone, password, character});
            res.json({ code: 200, data: users })
        } catch (e) {
            res.json({ code: 0, data: e })
        }
    },
    update: async function (req, res, next) {
        let id = req.params.id;
        let name = req.body.name;
        let phone = req.body.phone;
        let password = req.body.password;
        let character = req.body.character;
        console.log(id, name, phone, password, character);

        if (!name || !id || !phone || !password || !character) {
            res.json({ code: 0, data: 'params empty!' });
            return
        }

        try {
            const user = await User.update(id, { name, phone, password, character });
            res.json({ code: 200, data: user })
        } catch (e) {
            res.json({ code: 0, data: e })
        }
    },
    delete: async function (req, res, next) {
        let id = req.body.id;
        if (!id) {
            res.json({ code: 0, data: 'params empty!' });
            return
        }

        try {
            const user = await User.delete(id);
            res.json({ code: 200, data: user })
        } catch (e) {
            res.json({ code: 0, data: e })
        }
    },
    edit: async function(req, res, next) {
        let id = req.params.id;
        try {
            const user = await User.select({id});
            if (user.length === 0) {
                throw new Error('用户不存在');
            }
            res.locals.user = user[0];
            res.render('admin/user_edit.tpl',res.locals);
        }catch(e) {
            res.json({ code: 0, data: e })
        }
    },
    
}

module.exports = userController;