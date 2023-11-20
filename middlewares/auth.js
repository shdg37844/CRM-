const authMiddleware = {
    mustLogin: function (req, res, next) {
        if (!res.locals.isLogin) {
            res.redirect('/admin/login')
            return
        }

        next();
    },
    mustRoot: function (req, res, next) {
        console.log(res.locals.userInfo);
        if (res.locals.userInfo.character != 1) {
            res.writeHead(403);
            res.end("403 Forbidden");
            return
        }
        next();
    }
}

module.exports = authMiddleware;