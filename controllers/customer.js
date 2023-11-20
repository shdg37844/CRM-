const customerModel = require('./../models/customer_table.js');
const clueModel = require('./../models/clue_table.js');
const Customer = new customerModel();
const Clue = new clueModel();

const customerController = {
    show: async function (req, res, next) {
        try {
            const customers = await Customer.all();
            res.locals.customers = customers;
            res.render('admin/clue.tpl', res.locals)
        } catch (e) {
            res.locals.error = e;
            res.render('error', res.locals)
        }
    },
    insert: async function (req, res, next) {
        let name = req.body.name;
        let phone = req.body.phone;
        let time = new Date();
        console.log(name, phone, time);

        if (!name || !phone) {
            res.json({ code: 0, data: 'params empty!' });
            return
        }

        try {
            const customers = await Customer.insert({ name, phone, time });
            res.json({ code: 200, data: customers })
        } catch (e) {
            res.json({ code: 0, data: e })
        }
    },
    edit: async function (req, res, next) {
        let id = req.params.id;
        try {
            const customers = await Customer.select({ id });
            if (customers.length === 0) {
                throw new Error('用户不存在');
            }
            res.locals.customers = customers[0];
            res.render('admin/clue_edit.tpl', res.locals);
        } catch (e) {
            res.json({ code: 0, data: e })
        }
    },
    update: async function (req, res, next) {
        let id = req.params.id;
        let status = req.body.status;

        if (!status) {
            res.json({ code: 0, data: 'params empty!' });
            return
        }

        try {
            const customers = await Customer.update(id, { status });
            res.json({ code: 200, data: customers })
        } catch (e) {
            console.log(e); // 输出错误信息到控制台
            res.json({ code: 0, data: e.message }); // 发送错误信息的字符串表示给客户端
            //res.json({ code: 0, data: e })
        }

    },
    insertClue: async function (req, res, next) {
        let userId = req.params.id;  //用户id
        let content = req.body.content;
        let time = new Date();

        if (!content) {
            res.json({ code: 0, data: '内容不能为空' });
            return;
        }

        try {
            const clue = await Clue.insert({ userId, content, time });
            res.json({ code: 200, data: clue });

        } catch (e) {
            console.error(e);
            res.json({ code: 0, data: e.message });
        }
    }

}

module.exports = customerController;