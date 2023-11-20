const Base = require('./base.js');

class Customer extends Base {
    constructor(props = 'customers') {
        super(props);
    }
}

module.exports = Customer