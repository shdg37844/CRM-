var express = require('express');
var router = express.Router();
var userController = require('./../controllers/user');
var authController = require('./../controllers/auth.js');
var customerController = require('./../controllers/customer.js');

router.post('/admin/user', userController.insert);
router.delete('/admin/user', userController.delete);
router.put('/admin/user/:id', userController.update);

router.post('/admin/login', authController.login);

router.post('/admin/clue', customerController.insert);
router.put('/admin/clue/:id', customerController.update);
router.post('/admin/clue/edit/:id', customerController.insertClue);




module.exports = router;
