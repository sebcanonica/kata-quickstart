module.exports = function (wallaby) {
    return {
      files: [
        'src/**/*.js'
      ],

      tests: [
        'spec/**/*.spec.js'
      ],

      env : {
        kind: 'chrome'
      }
    };
  };