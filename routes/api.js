var express = require('express');
var router = express.Router();
var userController = require('./../controllers/user');
var authController = require('./../controllers/auth.js');
var customerController = require('./../controllers/customer.js');
var clueController = require('./../controllers/clue.js');
var unitController = require('./../controllers/unit.js');

router.post('/admin/user', userController.insert);
router.delete('/admin/user', userController.delete);
router.put('/admin/user/:id', userController.update);

router.post('/admin/login', authController.login);

router.post('/admin/clue', customerController.insert);
router.put('/admin/clue/edit/:id', customerController.update);
router.post('/admin/clue/edit/:id', clueController.insert);




module.exports = router;
