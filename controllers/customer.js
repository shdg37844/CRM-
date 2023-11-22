const customerModel = require('./../models/customer_table.js');
const Customer = new customerModel();


const customerController = {
    show: async function (req, res, next) {
        try {

            const character = res.locals.userInfo.character;
            const user_id = res.locals.userInfo.user_id;

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
        let utm = req.body.utm;
        
        if (!name || !phone) {
            res.json({ code: 0, data: 'params empty!' });
            return
        }

        try {
            const customers = await Customer.insert({ name, phone, time, utm });
            res.json({ code: 200, data: customers })
        } catch (e) {
            res.json({ code: 0, data: e })
        }
    },
    update: async function (req, res, next) {
        let id = req.params.id;
        let status = req.body.status;
        let remark = req.body.remark;
        let salesman = req.body.salesman;

        if (!status || !remark || !salesman) {
            res.json({ code: 0, data: 'params empty!' });
            return
        }

        try {
            const customers = await Customer.update(id, { status, remark, salesman });
            res.json({ code: 200, data: customers })
        } catch (e) {
            console.log(e); // 输出错误信息到控制台
            res.json({ code: 0, data: e.message }); // 发送错误信息的字符串表示给客户端
        }

    },


}

module.exports = customerController;