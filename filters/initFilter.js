module.exports = function (req, res, next) {
    res.locals.seo = {
        title: 'crm',
        keywords: 'crm',
        description: 'crm'
    }

    next();
}