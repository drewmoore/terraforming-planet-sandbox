const express = require('express');

const router = express.Router();

router.get('/', async (req, res, next) => {
  try {
    const response = { message: `Hello ${req.query.name || 'World'}!` }

    res.send(response);
  } catch (error) {
    next(error);
  }
});

module.exports = router;
