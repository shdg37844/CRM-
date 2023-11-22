const customerModel = require('./../models/customer_table.js');
const Customer = new customerModel();

const userModel = require('./../models/user_table.js')
const User = new userModel();

const clueModel = require('./../models/clue_table.js');
const Clue = new clueModel();


const unitController = {
    edit: async function (req, res, next) {
        let id = req.params.id;
        try {
            const clues = await Clue.all();
            res.locals.clues = clues;

            // 如果 'id' 存在，则执行 'edit' 的逻辑
            if (id) {
                const customers = await Customer.select({ id });
                const salesman = await User.select({ character: 2 });
                if (customers.length === 0) {
                    throw new Error('用户不存在');
                }
                res.locals.customers = customers[0];
                res.locals.salesman = salesman;
            }

            res.render('admin/clue_edit.tpl', res.locals);
        } catch (e) {
            res.locals.error = e;
            res.render('error', res.locals);
        }
    }



}

module.exports = unitController;
