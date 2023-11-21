const JWT = require("jsonwebtoken");
const JWT_SECRET = process.env.JWT_SECRET;

module.exports = function (req, res, next) {
    res.locals.isLogin = false;
    res.locals.userInfo = {};

    let token = req.cookies.web_token;
    if (token) {
        
        JWT.verify(token, JWT_SECRET, function (err, decoded) {

            if (!err) {
                // 设置登录状态和用户信息
                res.locals.isLogin = true;
                res.locals.userInfo = {
                    phone: decoded.phone,
                    user_id: decoded.user_id,
                    character: decoded.character,
                    name: decoded.name
                };
            }

            next();
        });
    } else {
        next();
    }
};


//next()使用



