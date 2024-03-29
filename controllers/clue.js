const clueModel = require('./../models/clue_table.js');
const Clue = new clueModel();

const clueController = {
    insert: async function (req, res, next) {
        let userId = req.params.id;  // 用户id
        let content = req.body.content;
        let time = new Date();

        if (!content) {
            res.json({ code: 0, data: '内容不能为空' });
            return;
        }

        try {
            const clues = await Clue.insert({ userId, content, time });
            res.json({ code: 200, data: clues });
        } catch (e) {
            console.error(e);
            res.json({ code: 0, data: e.message });
        }
    },
    
}

module.exports = clueController;